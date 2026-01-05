import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/constants/device_types.dart';
import '../../../data/models/device_info.dart';
import '../../providers/device_discovery_provider.dart';
import '../common/glass_card.dart';
import 'add_device_dialog.dart';

class DiscoveryWizardDialog extends ConsumerStatefulWidget {
  const DiscoveryWizardDialog({super.key});

  @override
  ConsumerState<DiscoveryWizardDialog> createState() =>
      _DiscoveryWizardDialogState();
}

enum WizardStep { scanning, list, configure }

class _DiscoveryWizardDialogState extends ConsumerState<DiscoveryWizardDialog> {
  WizardStep _currentStep = WizardStep.scanning;
  DeviceInfo? _selectedDevice;

  // Controllers for configuration step
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DeviceType _selectedType = DeviceType.dummy;

  @override
  void initState() {
    super.initState();
    // Start scanning immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scanDevicesProvider)();

      // Auto-transition to list if devices are found
      // (Wait a few seconds for first shout)
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _currentStep == WizardStep.scanning) {
          setState(() => _currentStep = WizardStep.list);
        }
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _selectDevice(DeviceInfo device) {
    setState(() {
      _selectedDevice = device;
      _nameController.text = device.name;
      _selectedType = device.type;
      _currentStep = WizardStep.configure;
    });
  }

  void _addDevice() {
    if (_formKey.currentState!.validate()) {
      final finalDevice = _selectedDevice!.copyWith(
        name: _nameController.text,
        type: _selectedType,
      );

      ref.read(addManualDeviceProvider)(finalDevice);
      Navigator.of(context).pop(finalDevice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450, maxHeight: 600),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: _buildStepContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    return switch (_currentStep) {
      WizardStep.scanning => _buildScanningStep(),
      WizardStep.list => _buildListStep(),
      WizardStep.configure => _buildConfigureStep(),
    };
  }

  Widget _buildScanningStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const CircularProgressIndicator(strokeWidth: 3),
        const SizedBox(height: 32),
        const Text('Discovering Devices', style: AppTextStyles.titleLarge),
        const SizedBox(height: 12),
        Text(
          'Axionyx is shouting on the network to find your devices...',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 40),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildListStep() {
    final availableDevices = ref.watch(availableDevicesProvider).value ?? [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Available Devices',
                style: AppTextStyles.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, size: 20),
              onPressed: () => ref.read(scanDevicesProvider)(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (availableDevices.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sensors_off_outlined,
                    size: 48,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 16),
                  const Text('No new devices found yet',
                      style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Ensure your device is powered on and connected to the same WiFi.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              itemCount: availableDevices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final device = availableDevices[index];
                return _buildDeviceTile(device);
              },
            ),
          ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Manually'),
              onPressed: () async {
                Navigator.of(context).pop();
                final manual = await showDialog<DeviceInfo>(
                  context: context,
                  builder: (context) => const AddDeviceDialog(),
                );
                if (manual != null && mounted) {
                  ref.read(addManualDeviceProvider)(manual);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeviceTile(DeviceInfo device) {
    return InkWell(
      onTap: () => _selectDevice(device),
      borderRadius: BorderRadius.circular(16),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.3),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColorSchemes.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getDeviceIcon(device.type),
                color: AppColorSchemes.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.name, style: AppTextStyles.titleMedium),
                  Text(
                    '${device.type.toString().split('.').last.toUpperCase()} • ${device.host}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigureStep() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _currentStep = WizardStep.list),
            ),
            const Text('Configure Device', style: AppTextStyles.titleLarge),
            const SizedBox(height: 24),
            Text('Device Name',
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColorSchemes.primary)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration:
                  const InputDecoration(hintText: 'e.g., Lab Incubator #1'),
              validator: (v) => v == null || v.isEmpty ? 'Name required' : null,
            ),
            const SizedBox(height: 24),
            Text('Confirm Type',
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColorSchemes.primary)),
            const SizedBox(height: 12),
            LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: SegmentedButton<DeviceType>(
                    segments: const [
                      ButtonSegment(
                          value: DeviceType.pcr,
                          label: Text('PCR'),
                          icon: Icon(Icons.science)),
                      ButtonSegment(
                          value: DeviceType.incubator,
                          label: Text('Incubator'),
                          icon: Icon(Icons.thermostat)),
                      ButtonSegment(
                          value: DeviceType.dummy,
                          label: Text('Dummy'),
                          icon: Icon(Icons.device_unknown)),
                    ],
                    selected: {_selectedType},
                    onSelectionChanged: (set) =>
                        setState(() => _selectedType = set.first),
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addDevice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorSchemes.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add to Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDeviceIcon(DeviceType type) {
    return switch (type) {
      DeviceType.pcr => Icons.science,
      DeviceType.incubator => Icons.thermostat,
      DeviceType.dummy => Icons.device_unknown,
    };
  }
}
