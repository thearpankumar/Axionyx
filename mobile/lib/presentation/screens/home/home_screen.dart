import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/glass_button.dart';
import '../../../core/theme/text_styles.dart';
import '../../providers/device_discovery_provider.dart';
import 'widgets/device_card.dart';
import '../device_detail/pcr_detail_screen.dart';
import '../device_detail/incubator_detail_screen.dart';
import '../device_detail/dummy_detail_screen.dart';
import '../settings/settings_screen.dart';
import '../../../core/constants/device_types.dart';
import '../../../data/models/device_info.dart';
import '../../../core/theme/color_schemes.dart';
import '../../widgets/dialogs/add_device_dialog.dart';
import '../../widgets/dialogs/discovery_wizard_dialog.dart';

/// Home screen showing discovered devices
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(filteredDevicesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Devices',
          style: AppTextStyles.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GlassCard(
                  color: const Color(0xFF0A0A0A), // Match black theme
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search devices...',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.5),
                      ),
                      suffixIcon: ref
                              .watch(deviceSearchQueryProvider)
                              .isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                ref
                                    .read(deviceSearchQueryProvider.notifier)
                                    .state = '';
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      ref.read(deviceSearchQueryProvider.notifier).state =
                          value;
                    },
                  ),
                ),
              ),

              // Device list
              Expanded(
                child: devicesAsync.when(
                  data: (devices) {
                    if (devices.isEmpty) {
                      final searchQuery = ref.watch(deviceSearchQueryProvider);
                      return _buildEmptyState(context, ref,
                          isSearching: searchQuery.isNotEmpty);
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(scanDevicesProvider)();
                      },
                      child: ListView.builder(
                        itemCount: devices.length + 1,
                        itemBuilder: (context, index) {
                          if (index == devices.length) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Divider(height: 32),
                                  Text(
                                    'Missing a device?',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  GlassButton(
                                    label: 'Add Device Manually',
                                    icon: Icons.add,
                                    onPressed: () =>
                                        _showAddDeviceDialog(context, ref),
                                  ),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            );
                          }
                          final device = devices[index];
                          return DeviceCard(
                            device: device,
                            onTap: () => _navigateToDetail(context, device),
                            onDelete: () => _deleteDevice(context, ref, device),
                          );
                        },
                      ),
                    );
                  },
                  loading: () =>
                      _buildEmptyState(context, ref, isSearching: false),
                  error: (error, stack) =>
                      _buildEmptyState(context, ref, isSearching: false),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: devicesAsync.asData?.value.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _showDiscoveryWizard(context, ref),
              icon: const Icon(Icons.wifi_find),
              label: const Text('Scan Devices'),
              backgroundColor: AppColorSchemes.primary,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  Future<void> _showDiscoveryWizard(BuildContext context, WidgetRef ref) async {
    final device = await showDialog<DeviceInfo>(
      context: context,
      builder: (context) => const DiscoveryWizardDialog(),
    );

    if (device != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added ${device.name} successfully'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }

  void _navigateToDetail(BuildContext context, DeviceInfo device) {
    final Widget screen = switch (device.type) {
      DeviceType.pcr => PCRDetailScreen(device: device),
      DeviceType.incubator => IncubatorDetailScreen(device: device),
      DeviceType.dummy => DummyDetailScreen(device: device),
    };

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> _deleteDevice(
      BuildContext context, WidgetRef ref, DeviceInfo device) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Device'),
        content: Text('Are you sure you want to remove ${device.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColorSchemes.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      ref.read(removeDeviceProvider)(device.id);
    }
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref,
      {required bool isSearching}) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.devices_outlined,
              size: 80,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              isSearching ? 'No matching devices' : 'No devices found',
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSearching
                  ? 'Try adjusting your search terms'
                  : 'Tap "Scan Devices" to find devices on your WiFi',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.4),
              ),
            ),
            if (!isSearching) ...[
              const SizedBox(height: 8),
              Text(
                'Connected to device AP? Use "Add Device Manually"',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.3),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (!isSearching) ...[
              const SizedBox(height: 24),
              GlassButton(
                label: 'Discover Devices',
                icon: Icons.wifi_find,
                onPressed: () => _showDiscoveryWizard(context, ref),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                label: const Text('Add Manually'),
                icon: const Icon(Icons.add, size: 20),
                onPressed: () => _showAddDeviceDialog(context, ref),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showAddDeviceDialog(BuildContext context, WidgetRef ref) async {
    final device = await showDialog<DeviceInfo>(
      context: context,
      builder: (context) => const AddDeviceDialog(),
    );

    if (device != null && context.mounted) {
      // Add device to scanner
      ref.read(addManualDeviceProvider)(device);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added ${device.name} successfully'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }
}
