import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../services/discovery/mdns_scanner.dart';
import '../../data/models/device_info.dart';

/// Provider for mDNS scanner instance
final mdnsScannerProvider = Provider<MdnsScanner>((ref) {
  final scanner = MdnsScanner();
  // Load persisted manual devices
  scanner.loadManualDevices().then((_) {
    // Silently refresh IPs on startup
    scanner.refreshSavedDevices();
  });
  ref.onDispose(() => scanner.dispose());
  return scanner;
});

/// Provider for managed (saved) devices stream
final managedDevicesProvider = StreamProvider<List<DeviceInfo>>((ref) {
  final scanner = ref.watch(mdnsScannerProvider);
  return scanner.savedDevicesStream;
});

/// Provider for transiently found devices stream (during scan)
final availableDevicesProvider = StreamProvider<List<DeviceInfo>>((ref) {
  final scanner = ref.watch(mdnsScannerProvider);
  return scanner.foundDevicesStream;
});

/// Provider for search query
final deviceSearchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for filtered devices based on search query (for Home Screen)
final filteredDevicesProvider = Provider<AsyncValue<List<DeviceInfo>>>((ref) {
  final devicesAsync = ref.watch(managedDevicesProvider);
  final searchQuery = ref.watch(deviceSearchQueryProvider).toLowerCase();

  return devicesAsync.whenData((devices) {
    if (searchQuery.isEmpty) {
      return devices;
    }

    return devices.where((device) {
      final matchesName = device.name.toLowerCase().contains(searchQuery);
      final matchesHost = device.host.toLowerCase().contains(searchQuery);
      final matchesType =
          device.type.toString().toLowerCase().contains(searchQuery);
      final matchesSerial =
          device.serial?.toLowerCase().contains(searchQuery) ?? false;

      return matchesName || matchesHost || matchesType || matchesSerial;
    }).toList();
  });
});

/// Provider to trigger manual scan
final scanDevicesProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final scanner = ref.read(mdnsScannerProvider);
    await scanner.scan();
  };
});

/// Provider to add device manually
final addManualDeviceProvider = Provider<void Function(DeviceInfo)>((ref) {
  return (DeviceInfo device) {
    final scanner = ref.read(mdnsScannerProvider);
    scanner.addDevice(device);
  };
});

/// Provider to remove device
final removeDeviceProvider = Provider<void Function(String)>((ref) {
  return (String deviceId) {
    final scanner = ref.read(mdnsScannerProvider);
    scanner.removeDevice(deviceId);
  };
});
