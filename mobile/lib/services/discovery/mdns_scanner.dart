import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:nsd/nsd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
import '../../core/constants/device_types.dart';
import 'package:flutter_multicast_lock/flutter_multicast_lock.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/device_info.dart';

/// mDNS service discovery for Axionyx devices
class MdnsScanner {
  final Logger _logger = Logger();
  final StreamController<List<DeviceInfo>> _savedDevicesController =
      StreamController<List<DeviceInfo>>.broadcast();
  final StreamController<List<DeviceInfo>> _foundDevicesController =
      StreamController<List<DeviceInfo>>.broadcast();
  final Map<String, DeviceInfo> _savedDevices = {};
  final Map<String, DeviceInfo> _foundDevices =
      {}; // Transient discovery results
  static const String _savedDevicesKey = 'saved_devices';

  Timer? _scanTimer;
  Timer? _aliveLogger;
  final List<Discovery> _activeDiscoveries = [];
  bool _isStopping = false;
  Future<void>? _activeOperation;
  final _multicastLock = FlutterMulticastLock();
  bool _isLockActive = false;

  /// Stream of saved (managed) devices
  Stream<List<DeviceInfo>> get savedDevicesStream =>
      _savedDevicesController.stream;

  /// Stream of transiently found (available) devices
  Stream<List<DeviceInfo>> get foundDevicesStream =>
      _foundDevicesController.stream;

  /// List of currently saved (managed) devices
  List<DeviceInfo> get savedDevices => _savedDevices.values.toList();

  /// List of transiently found (available) devices NOT yet saved
  List<DeviceInfo> get foundDevices => _foundDevices.values.toList();

  /// Start mDNS scanning
  Future<void> startScanning() async {
    if (_activeOperation != null) await _activeOperation;
    _activeOperation = _startScanningInternal();
    return _activeOperation;
  }

  Future<void> _startScanningInternal() async {
    try {
      _logger.i('Checking permissions for mDNS scanning...');

      // Request necessary permissions for mDNS on Android
      if (await Permission.location.isDenied) {
        await Permission.location.request();
      }

      // For Android 13+
      if (await Permission.nearbyWifiDevices.isDenied) {
        await Permission.nearbyWifiDevices.request();
      }

      _logger.i('Starting mDNS scanning for ${AppConstants.mdnsServiceType}');

      // Start discovery paths (mDNS + UDP Broadcast)
      await Future.wait([
        _startDiscovery(),
        _startUdpDiscovery(),
      ]);

      // Periodic check to confirm scanner is alive
      _aliveLogger?.cancel();
      _aliveLogger = Timer.periodic(const Duration(seconds: 15), (timer) {
        if (_activeDiscoveries.isNotEmpty) {
          _logger.d(
              'NSD Scanner alive. Currently searching. Saved: ${_savedDevices.length}, Found: ${_foundDevices.length}');
        }
      });

      // Auto-rescan periodically
      _scanTimer?.cancel();
      _scanTimer = Timer.periodic(
        AppConstants.discoveryRescanInterval,
        (_) => _refreshDevices(),
      );
    } catch (e) {
      _logger.e('Error starting mDNS discovery: $e');
      // Emit empty list on error
      _emitDevices();
    } finally {
      _activeOperation = null;
    }
  }

  /// Stop mDNS scanning
  Future<void> stopScanning() async {
    try {
      _scanTimer?.cancel();
      await _stopDiscovery();
      _logger.i('Stopped mDNS scanning');
    } catch (e) {
      _logger.e('Error stopping mDNS discovery: $e');
    }
  }

  /// Manually trigger a scan
  Future<void> scan() async {
    if (_activeOperation != null) await _activeOperation;
    _activeOperation = _scanInternal(duration: const Duration(seconds: 10));
    return _activeOperation;
  }

  /// Silently refresh saved devices (on startup/background)
  Future<void> refreshSavedDevices() async {
    _logger.i('Silently refreshing saved devices...');
    if (_activeOperation != null) await _activeOperation;
    _activeOperation =
        _scanInternal(duration: const Duration(seconds: 5), silent: true);
    return _activeOperation;
  }

  /// Targeted heal for a specific device that is failing
  Future<void> healDevice(String deviceId) async {
    _logger.i('Targeted healing requested for device: $deviceId');
    // If we're already scanning, just wait. Otherwise, start a quick scan.
    if (_activeOperation != null) {
      await _activeOperation;
    } else {
      _activeOperation = _scanInternal(duration: const Duration(seconds: 4));
      await _activeOperation;
    }
  }

  Future<void> _scanInternal(
      {required Duration duration, bool silent = false}) async {
    if (!silent) _logger.i('Starting discovery scan...');

    try {
      // Ensure permissions before scanning
      await Permission.location.request();
      await Permission.nearbyWifiDevices.request();

      // Stop existing discovery if running
      await _stopDiscovery();
      await Future.delayed(const Duration(milliseconds: 1000)); // Reset period

      // Start new discovery
      await Future.wait([
        _startDiscovery(),
        _startUdpDiscovery(),
      ]);

      // Wait for the specified duration
      await Future.delayed(duration);
    } catch (e) {
      _logger.e('Error during scan: $e');
    } finally {
      // Stop discovery after scan
      await _stopDiscovery();
      _activeOperation = null;
    }
  }

  /// Start nsd discovery
  Future<void> _startDiscovery() async {
    try {
      // Ensure Multicast Lock is active for Android reliability (esp. Oppo/Realme)
      if (!_isLockActive) {
        _logger.d('Acquiring Multicast Lock...');
        await _multicastLock.acquireMulticastLock(lockName: 'axionyx_scanner');
        _isLockActive = true;
      }

      final serviceTypes = [
        AppConstants.mdnsServiceType,
        '_http._tcp', // Fallback for standard discovery
      ];

      for (final type in serviceTypes) {
        _logger.i('Starting NSD discovery for $type');

        try {
          final discovery = await startDiscovery(
            type,
            ipLookupType: IpLookupType.any,
          );

          discovery.addServiceListener((service, status) {
            if (status == ServiceStatus.found) {
              _onServiceFound(service);
            } else if (status == ServiceStatus.lost) {
              _onServiceLost(service);
            }
          });

          _activeDiscoveries.add(discovery);

          await Future.delayed(const Duration(milliseconds: 200));
        } catch (e) {
          _logger.e('Failed to start discovery for $type: $e');
        }
      }

      _logger.i(
          'NSD discovery cycle established for ${serviceTypes.length} types');
    } catch (e) {
      _logger.e('Failed to establish NSD discovery: $e');
      rethrow;
    }
  }

  /// Stop nsd discovery
  Future<void> _stopDiscovery() async {
    if (_isStopping) return;
    _isStopping = true;

    try {
      // Release Multicast Lock
      if (_isLockActive) {
        _logger.d('Releasing Multicast Lock...');
        await _multicastLock.releaseMulticastLock();
        _isLockActive = false;
      }

      // Work on a copy to avoid concurrent modification issues
      final discoveriesToStop = List<Discovery>.from(_activeDiscoveries);
      _activeDiscoveries.clear();

      for (final discovery in discoveriesToStop) {
        try {
          _logger.d('Attempting to stop discovery: ${discovery.id}');
          await stopDiscovery(discovery);
          _logger.d('Successfully stopped discovery: ${discovery.id}');
        } catch (e) {
          if (e.toString().contains('under-locked')) {
            _logger.w(
                'NSD discovery already stopped or under-locked (system handled): ${discovery.id}');
          } else {
            _logger.e('Error stopping NSD discovery ${discovery.id}: $e');
          }
        }
      }
    } finally {
      _activeDiscoveries.clear();
      _isStopping = false;
    }
  }

  /// Start UDP broadcast discovery as fallback
  Future<void> _startUdpDiscovery() async {
    _logger.i(
        'Starting UDP Broadcast discovery on port ${AppConstants.udpDiscoveryPort}');

    RawDatagramSocket? socket;
    try {
      socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      socket.broadcastEnabled = true;

      // Broadcast the discovery request
      final data = utf8.encode(AppConstants.udpDiscoveryRequest);
      final destination = InternetAddress('255.255.255.255');

      socket.send(data, destination, AppConstants.udpDiscoveryPort);
      _logger.d(
          '🔍 UDP SHOUT: ${AppConstants.udpDiscoveryRequest} sent to $destination');

      // Listen and shout periodically
      final timeout = DateTime.now().add(const Duration(seconds: 5));
      DateTime lastShout = DateTime.now();

      while (DateTime.now().isBefore(timeout)) {
        // Periodic shout (every 1.5s) to catch dropped packets
        if (DateTime.now().difference(lastShout).inMilliseconds > 1500) {
          socket.send(data, destination, AppConstants.udpDiscoveryPort);
          lastShout = DateTime.now();
        }

        final datagram = socket.receive();
        if (datagram != null) {
          final reply = utf8.decode(datagram.data);
          _logger.d('🔍 UDP REPLY from ${datagram.address.address}: $reply');

          try {
            final json = jsonDecode(reply) as Map<String, dynamic>;
            if (json['type'] == AppConstants.udpDiscoveryReply) {
              _onUdpReplyFound(json);
            }
          } catch (e) {
            _logger.w('Failed to parse UDP reply: $e');
          }
        }
        await Future.delayed(const Duration(milliseconds: 50));
      }
    } catch (e) {
      _logger.e('UDP Discovery Error: $e');
    } finally {
      _logger.d('UDP Discovery finished');
      socket?.close();
    }
  }

  void _onUdpReplyFound(Map<String, dynamic> json) {
    try {
      final id = json['id'] as String;
      final name = json['name'] as String;
      final deviceType = json['device_type'] as String;
      final host = json['ip'] as String;
      final httpPort = json['http_port'] as int;
      final wsPort = json['ws_port'] as int;
      final version = json['version'] as String;
      final mac = json['mac'] as String;

      _logger.i('🔍 UDP RECOVERY: Found device $name at $host');

      final device = DeviceInfo(
        id: id,
        name: name,
        type: DeviceType.fromString(deviceType),
        host: host,
        httpPort: httpPort,
        websocketPort: wsPort,
        version: version,
        serial: id, // Fallback ID as serial
        mac: mac,
        lastSeen: DateTime.now(),
        isConnected: true,
      );

      // Logic for IP HEALING / UDP RECOVERY
      if (_savedDevices.containsKey(device.id)) {
        final existing = _savedDevices[device.id]!;
        if (existing.host != device.host) {
          _logger.i(
              'IP HEAL (UDP): Saved device ${device.name} IP changed ${existing.host} -> ${device.host}');
          _savedDevices[device.id] = device;
          _saveSavedDevices();
        } else {
          // Just update last seen
          _savedDevices[device.id] = device;
        }
      } else {
        _foundDevices[device.id] = device;
      }

      _emitDevices();
    } catch (e) {
      _logger.e('Error processing UDP recovery reply: $e');
    }
  }

  /// Handle service found
  void _onServiceFound(Service service) {
    _logger.i(
        '🔍 RAW Service Found: name=${service.name}, type=${service.type}, host=${service.host}:${service.port}');
    _logger.d('   🔬 FULL DATA: $service');

    try {
      // Parse TXT records with extra safety
      final txtRecords = <String, String>{};
      final rawTxt = service.txt;
      if (rawTxt != null) {
        for (final entry in rawTxt.entries) {
          final key = entry.key;
          final value = entry.value;
          if (value != null) {
            txtRecords[key] = utf8.decode(value, allowMalformed: true);
          } else {
            txtRecords[key] = '';
          }
          _logger.d('   📄 TXT: $key = ${txtRecords[key]}');
        }
      }

      // Extract host IP (prefer IPv4)
      String? host;
      if (service.addresses != null && service.addresses!.isNotEmpty) {
        host = service.addresses!.first.address;
      } else if (service.host != null) {
        host = service.host;
      }

      if (host == null || service.port == null) {
        _logger.w('   ⚠️ Service ${service.name} missing host or port');
        return;
      }

      _logger.d('   🌐 Host: $host, Port: ${service.port}');
      _logger.d('   🔍 TXT Keys: ${txtRecords.keys.toList()}');

      // Filter: If we're looking at generic _http._tcp, ensure it's an Axionyx device
      // We look for our specific TXT records like 'id' and 'type'
      if (!txtRecords.containsKey('id') || !txtRecords.containsKey('type')) {
        _logger.w(
            '   ⚠️ Skipping non-Axionyx service: ${service.name} (Missing id or type in TXT)');
        return;
      }

      // Get websocket port from TXT records, default to 81
      final wsPort = int.tryParse(txtRecords['ws'] ?? '81') ?? 81;

      // Create device info from mDNS data
      final device = DeviceInfo.fromMdns(
        name: service.name ?? 'Unknown Device',
        host: host,
        httpPort: service.port!,
        websocketPort: wsPort,
        txtRecords: txtRecords,
      );

      // Logic for IP HEALING / mDNS
      if (_savedDevices.containsKey(device.id)) {
        final existing = _savedDevices[device.id]!;
        if (existing.host != device.host) {
          _logger.i(
              'IP HEAL (mDNS): Saved device ${device.name} IP changed ${existing.host} -> ${device.host}');
          _savedDevices[device.id] = device;
          _saveSavedDevices();
        } else {
          // Update details/last seen
          _savedDevices[device.id] = device;
        }
      } else {
        // It's a new device available for adding
        _foundDevices[device.id] = device;
      }

      _emitDevices();
      _logger.i('Found device: ${device.name} (${device.host}) - ${device.id}');
    } catch (e) {
      _logger.e('Error processing found service: $e');
    }
  }

  /// Handle service lost
  void _onServiceLost(Service service) {
    try {
      // Look for the device in both maps
      final foundId = _foundDevices.entries
          .where((e) =>
              e.value.name == service.name || e.value.host == service.host)
          .map((e) => e.key)
          .firstOrNull;

      if (foundId != null) {
        _foundDevices.remove(foundId);
        _emitDevices();
        _logger.d('Removed lost available device: $foundId');
      }

      // We DON'T remove saved devices just because they are lost from mDNS
      // as they might be temporarily offline but still 'managed' by the user.
    } catch (e) {
      _logger.e('Error processing lost service: $e');
    }
  }

  /// Load saved devices from persistence
  Future<void> loadManualDevices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? devicesJson = prefs.getString(_savedDevicesKey);

      if (devicesJson != null) {
        final List<dynamic> decoded = jsonDecode(devicesJson);
        for (final item in decoded) {
          final device = DeviceInfo.fromJson(item as Map<String, dynamic>);
          _savedDevices[device.id] = device;
        }
        _logger
            .i('Loaded ${_savedDevices.length} saved devices from persistence');
        _emitDevices();
      }
    } catch (e) {
      _logger.e('Error loading saved devices: $e');
    }
  }

  /// Save saved devices to persistence
  Future<void> _saveSavedDevices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList =
          _savedDevices.values.map((device) => device.toJson()).toList();

      await prefs.setString(_savedDevicesKey, jsonEncode(savedList));
      _logger.d('Saved ${_savedDevices.length} devices to persistence');
    } catch (e) {
      _logger.e('Error saving devices: $e');
    }
  }

  /// Save/Add a device to managed list
  void addDevice(DeviceInfo device) {
    _logger.i('Managing device: ${device.name} (${device.host})');

    // Move from found to saved
    _foundDevices.remove(device.id);
    _savedDevices[device.id] = device;

    _saveSavedDevices();
    _emitDevices();
  }

  /// Remove a device from managed list
  void removeDevice(String deviceId) {
    _logger.i('Unmanaging device: $deviceId');
    _savedDevices.remove(deviceId);
    _saveSavedDevices();
    _emitDevices();
  }

  /// Refresh devices list (remove stale available devices)
  void _refreshDevices() {
    final now = DateTime.now();
    final staleFound = <String>[];

    for (final entry in _foundDevices.entries) {
      final lastSeen = entry.value.lastSeen;
      if (lastSeen != null) {
        final difference = now.difference(lastSeen);
        if (difference.inSeconds > 60) {
          staleFound.add(entry.key);
        }
      }
    }

    // Remove stale found devices
    for (final id in staleFound) {
      _foundDevices.remove(id);
      _logger.d('Removed stale available device: $id');
    }

    _emitDevices();
  }

  /// Emit current devices lists to streams
  void _emitDevices() {
    _savedDevicesController.add(savedDevices);
    _foundDevicesController.add(foundDevices);
  }

  /// Dispose resources
  void dispose() {
    _scanTimer?.cancel();
    _aliveLogger?.cancel();
    _stopDiscovery();
    _savedDevicesController.close();
    _foundDevicesController.close();
  }
}
