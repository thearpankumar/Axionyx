import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/constants/device_types.dart';
import '../../../data/models/device_info.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/device_api.dart';
import '../../../core/constants/api_endpoints.dart';
import 'wifi_setup_dialog.dart';
import 'dart:ui';

/// Dialog for manually adding a device
class AddDeviceDialog extends StatefulWidget {
  const AddDeviceDialog({super.key});

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _hostController = TextEditingController();
  final _httpPortController = TextEditingController(text: '80');
  final _wsPortController = TextEditingController(text: '81');

  DeviceType _selectedType = DeviceType.dummy;
  bool _isProbing = false;
  String? _probeError;

  @override
  void dispose() {
    _nameController.dispose();
    _hostController.dispose();
    _httpPortController.dispose();
    _wsPortController.dispose();
    super.dispose();
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
                            'Add Device Manually',
                            style: AppTextStyles.titleLarge,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Device Name
                    Text(
                      'Device Name',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Lab PCR-1',
                        prefixIcon: const Icon(Icons.devices),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a device name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Device Type
                    Text(
                      'Device Type',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<DeviceType>(
                      segments: const [
                        ButtonSegment<DeviceType>(
                          value: DeviceType.pcr,
                          label: Text('PCR'),
                          icon: Icon(Icons.science),
                        ),
                        ButtonSegment<DeviceType>(
                          value: DeviceType.incubator,
                          label: Text('Incubator'),
                          icon: Icon(Icons.thermostat),
                        ),
                        ButtonSegment<DeviceType>(
                          value: DeviceType.dummy,
                          label: Text('Dummy'),
                          icon: Icon(Icons.device_unknown),
                        ),
                      ],
                      selected: {_selectedType},
                      onSelectionChanged: (Set<DeviceType> newSelection) {
                        setState(() {
                          _selectedType = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // IP Address / Host
                    Text(
                      'IP Address',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _hostController,
                      decoration: InputDecoration(
                        hintText: 'e.g., 192.168.1.100',
                        prefixIcon: const Icon(Icons.dns),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an IP address';
                        }
                        // Basic IP validation
                        final ipRegex = RegExp(
                          r'^(\d{1,3}\.){3}\d{1,3}$',
                        );
                        if (!ipRegex.hasMatch(value)) {
                          return 'Please enter a valid IP address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Ports
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HTTP Port',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColorSchemes.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _httpPortController,
                                decoration: InputDecoration(
                                  hintText: '80',
                                  prefixIcon: const Icon(Icons.http),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  final port = int.tryParse(value);
                                  if (port == null ||
                                      port < 1 ||
                                      port > 65535) {
                                    return 'Invalid port';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WebSocket Port',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColorSchemes.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _wsPortController,
                                decoration: InputDecoration(
                                  hintText: '81',
                                  prefixIcon: const Icon(Icons.link),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  final port = int.tryParse(value);
                                  if (port == null ||
                                      port < 1 ||
                                      port > 65535) {
                                    return 'Invalid port';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
                                  'If connected to device AP (Axionyx-XXXX):',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Use IP: 192.168.4.1',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'For auto-discovery: Connect device to your WiFi network first.',
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
                    const SizedBox(height: 24),

                    // WiFi Setup Option
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton.icon(
                        onPressed: _showWiFiSetup,
                        icon: const Icon(Icons.wifi_outlined),
                        label: const Text('Configure Device WiFi First'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColorSchemes.info,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Discovery Warning
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColorSchemes.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColorSchemes.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColorSchemes.warning,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Discovery might fail if your phone is on 5GHz while the device is on 2.4GHz. Try connecting your phone to the 2.4GHz band if "Scan" finds nothing.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isProbing ? null : _addDevice,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorSchemes.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isProbing
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Add Device'),
                          ),
                        ),
                      ],
                    ),
                    if (_probeError != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _probeError!,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColorSchemes.error),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addDevice() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProbing = true;
        _probeError = null;
      });

      try {
        final host = _hostController.text;
        final httpPort = int.parse(_httpPortController.text);
        final wsPort = int.parse(_wsPortController.text);

        // Try to probe device for real ID/MAC
        final baseUrl = ApiEndpoints.buildHttpUrl(host, '', port: httpPort);
        final client = ApiClient(baseUrl: baseUrl);
        final api = DeviceApi(client);

        String deviceId = '${host}_${DateTime.now().millisecondsSinceEpoch}';
        String? mac;
        String? version;
        String? serial;

        try {
          final info =
              await api.getDeviceInfo().timeout(const Duration(seconds: 5));
          mac = info['mac']?.toString();
          deviceId = mac ?? info['id']?.toString() ?? deviceId;
          version = info['version']?.toString();
          serial = info['serial']?.toString();
        } catch (e) {
          debugPrint('Device probe failed, using fallback ID: $e');
          // We still allow adding it even if probe fails, but warn the user
        }

        if (mounted) {
          final device = DeviceInfo(
            id: deviceId,
            name: _nameController.text,
            type: _selectedType,
            host: host,
            httpPort: httpPort,
            websocketPort: wsPort,
            mac: mac,
            version: version,
            serial: serial,
            isConnected: false,
            lastSeen: DateTime.now(),
          );

          Navigator.of(context).pop(device);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _probeError = 'Connection error: $e';
            _isProbing = false;
          });
        }
      }
    }
  }

  Future<void> _showWiFiSetup() async {
    // Create temporary device info for WiFi setup
    final tempDevice = DeviceInfo(
      id: 'temp_${_hostController.text}',
      name: _nameController.text.isNotEmpty ? _nameController.text : 'Device',
      type: _selectedType,
      host: _hostController.text.isNotEmpty
          ? _hostController.text
          : '192.168.4.1',
      httpPort: int.tryParse(_httpPortController.text) ?? 80,
      websocketPort: int.tryParse(_wsPortController.text) ?? 81,
      isConnected: false,
    );

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => WiFiSetupDialog(device: tempDevice),
    );

    // If WiFi was configured successfully, show hint
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('WiFi configured! Reconnect to WiFi and use "Scan Devices"'),
          backgroundColor: Color(0xFF10B981),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
