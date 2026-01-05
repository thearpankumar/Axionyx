import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../data/models/device_info.dart';
import '../../providers/device_state_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/glass_button.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/charts/temperature_gauge.dart';
import '../../widgets/device_control/control_panel.dart';

/// Dummy device detail screen
class DummyDetailScreen extends ConsumerWidget {
  final DeviceInfo device;

  const DummyDetailScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetryAsync = ref.watch(telemetryStreamProvider(device));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(device.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: telemetryAsync.when(
            data: (telemetry) => _buildContent(context, telemetry),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => _buildOfflineState(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> telemetry) {
    final state = telemetry['state'] ?? 'IDLE';
    final temperature = telemetry['temperature'] ?? 0.0;
    final setpoint = telemetry['setpoint'] ?? 25.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status card
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: AppTextStyles.titleMedium,
                ),
                StatusBadge(status: state),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Temperature gauge
          Center(
            child: TemperatureGauge(
              value: temperature,
              minValue: 0,
              maxValue: 100,
              label: 'Temperature',
              color: AppColorSchemes.dummyAccent,
              setpoint: setpoint,
            ),
          ),
          const SizedBox(height: 32),

          // Control panel
          _buildControlPanel(context, state),
        ],
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, String state) {
    return Consumer(
      builder: (context, ref, child) {
        final repository = ref.watch(deviceRepositoryProvider(device));

        return ControlPanel(
          state: state,
          deviceType: 'Dummy Device',
          onStart: () async {
            try {
              await repository.startDevice({});
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Device started')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          onStop: () async {
            try {
              await repository.stopDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Device stopped')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          onPause: () async {
            try {
              await repository.pauseDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Device paused')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          onResume: () async {
            try {
              await repository.resumeDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Device resumed')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
        );
      },
    );
  }

  Widget _buildOfflineState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 80,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Device Offline',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Cannot connect to ${device.name}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, child) {
              return GlassButton(
                label: 'Retry',
                icon: Icons.refresh,
                onPressed: () {
                  ref.invalidate(telemetryStreamProvider(device));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
