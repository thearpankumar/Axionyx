import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../data/models/device_info.dart';
import '../../providers/device_state_provider.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';

/// Dialog for configuring device WiFi credentials
class WiFiSetupDialog extends ConsumerStatefulWidget {
  final DeviceInfo device;

  const WiFiSetupDialog({super.key, required this.device});

  @override
  ConsumerState<WiFiSetupDialog> createState() => _WiFiSetupDialogState();
}

class _WiFiSetupDialogState extends ConsumerState<WiFiSetupDialog> {
  final _formKey = GlobalKey<FormState>();
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  List<WiFiAccessPoint>? _wifiNetworks;
  bool _isScanning = false;
  String? _selectedSSID;

  @override
  void initState() {
    super.initState();
    _scanWiFiNetworks();
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _scanWiFiNetworks() async {
    setState(() {
      _isScanning = true;
      _errorMessage = null;
    });

    try {
      // Request location permission (required for WiFi scanning on Android)
      final status = await Permission.locationWhenInUse.request();

      if (!status.isGranted) {
        setState(() {
          _errorMessage =
              'Location permission is required to scan WiFi networks';
          _isScanning = false;
        });
        return;
      }

      // Check if WiFi scan is supported
      final canScan = await WiFiScan.instance.canGetScannedResults();
      if (canScan != CanGetScannedResults.yes) {
        setState(() {
          _errorMessage = 'WiFi scanning not available on this device';
          _isScanning = false;
        });
        return;
      }

      // Start WiFi scan
      await WiFiScan.instance.startScan();

      // Get scan results
      final results = await WiFiScan.instance.getScannedResults();

      // Sort by signal strength (strongest first) and remove duplicates
      final uniqueNetworks = <String, WiFiAccessPoint>{};
      for (final ap in results) {
        if (ap.ssid.isNotEmpty) {
          if (!uniqueNetworks.containsKey(ap.ssid) ||
              (uniqueNetworks[ap.ssid]?.level ?? -100) < ap.level) {
            uniqueNetworks[ap.ssid] = ap;
          }
        }
      }

      final sortedNetworks = uniqueNetworks.values.toList()
        ..sort((a, b) => b.level.compareTo(a.level));

      setState(() {
        _wifiNetworks = sortedNetworks;
        _isScanning = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to scan WiFi networks: ${e.toString()}';
        _isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Connect Device to WiFi',
                            style: AppTextStyles.titleLarge,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // WiFi Network Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select WiFi Network',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColorSchemes.primary,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _isScanning ? null : _scanWiFiNetworks,
                          icon: _isScanning
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.refresh, size: 18),
                          label: Text(_isScanning ? 'Scanning...' : 'Rescan'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColorSchemes.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // WiFi Network List
                    if (_wifiNetworks != null && _wifiNetworks!.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _wifiNetworks!.length,
                          itemBuilder: (context, index) {
                            final network = _wifiNetworks![index];
                            final isSelected = _selectedSSID == network.ssid;
                            return ListTile(
                              leading: Icon(
                                _getWiFiIcon(network.level),
                                color: isSelected
                                    ? AppColorSchemes.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                              ),
                              title: Text(
                                network.ssid,
                                style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              subtitle: Text(
                                _getSecurityText(network),
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle,
                                      color: AppColorSchemes.primary)
                                  : null,
                              selected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedSSID = network.ssid;
                                  _ssidController.text = network.ssid;
                                });
                              },
                            );
                          },
                        ),
                      )
                    else if (_isScanning)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'No WiFi networks found',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6)),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Manual SSID Entry
                    Text(
                      'Or Enter Manually',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ssidController,
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        hintText: 'Enter WiFi network name',
                        prefixIcon: const Icon(Icons.wifi),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedSSID = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select or enter WiFi network name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // WiFi Password
                    Text(
                      'WiFi Password',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      enabled: !_isLoading,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter WiFi password',
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter WiFi password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Info box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColorSchemes.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColorSchemes.info.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColorSchemes.info,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Device will connect to your WiFi network.',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'After setup, reconnect your phone to the same WiFi to use auto-discovery.',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error message
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColorSchemes.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColorSchemes.error.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColorSchemes.error,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColorSchemes.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _configureWiFi,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorSchemes.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Configure WiFi'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _configureWiFi() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repository = ref.read(deviceRepositoryProvider(widget.device));

      // Call WiFi configure API
      await repository.deviceApi.configureWifi(
        ssid: _ssidController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('WiFi Configured'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Device is connecting to WiFi network.'),
              SizedBox(height: 16),
              Text('Next steps:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('1. Reconnect your phone to the same WiFi network'),
              SizedBox(height: 4),
              Text('2. Use "Scan Devices" to discover the device'),
              SizedBox(height: 4),
              Text('3. Device should appear automatically!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close success dialog
                Navigator.of(context)
                    .pop(true); // Close WiFi setup dialog with success
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to configure WiFi: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  IconData _getWiFiIcon(int level) {
    if (level > -50) {
      return Icons.wifi;
    } else if (level > -60) {
      return Icons.wifi_2_bar;
    } else if (level > -70) {
      return Icons.wifi_1_bar;
    } else {
      return Icons.wifi_1_bar;
    }
  }

  String _getSecurityText(WiFiAccessPoint network) {
    final capabilities = network.capabilities.toLowerCase();
    if (capabilities.contains('wpa3')) {
      return 'WPA3';
    } else if (capabilities.contains('wpa2')) {
      return 'WPA2';
    } else if (capabilities.contains('wpa')) {
      return 'WPA';
    } else if (capabilities.contains('wep')) {
      return 'WEP';
    } else {
      return 'Open';
    }
  }
}
