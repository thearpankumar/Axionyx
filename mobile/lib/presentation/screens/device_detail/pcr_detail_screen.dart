import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/constants/device_types.dart';
import '../../../data/models/device_info.dart';
import '../../providers/device_state_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/glass_button.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/charts/progress_ring.dart';
import '../../widgets/charts/temperature_gauge.dart';
import '../../widgets/charts/phase_timeline.dart';
import '../../widgets/device_control/control_panel.dart';
import '../../widgets/dialogs/program_selector_dialog.dart';
import '../../widgets/dialogs/setpoint_dialog.dart';

/// PCR device detail screen
/// PCR device detail screen
class PCRDetailScreen extends ConsumerStatefulWidget {
  final DeviceInfo device;

  const PCRDetailScreen({super.key, required this.device});

  @override
  ConsumerState<PCRDetailScreen> createState() => _PCRDetailScreenState();
}

class _PCRDetailScreenState extends ConsumerState<PCRDetailScreen> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    final telemetryAsync = ref.watch(telemetryStreamProvider(widget.device));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showDeviceSettings(context),
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
    final cycleNumber = telemetry['cycleNumber'] ?? 0;
    final totalCycles = telemetry['totalCycles'] ?? 35;
    final temperature = telemetry['temperature'] as List?;
    final phase = telemetry['currentPhase'] ?? 'IDLE';
    final setpoints = telemetry['setpoint'] as List?;
    final timeRemaining = telemetry['timeRemaining'] as int? ?? 0;

    // Parse phase
    final currentPhase = _parsePhase(phase);

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
          const SizedBox(height: 24),

          // Progress Ring
          Center(
            child: ProgressRing(
              current: cycleNumber,
              total: totalCycles,
              phase: phase.toString().toUpperCase(),
              color: AppColorSchemes.pcrAccent,
              size: 220,
            ),
          ),
          const SizedBox(height: 16),

          // Time Remaining
          if (timeRemaining > 0 && state == 'RUNNING')
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    color: AppColorSchemes.pcrAccent,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Remaining',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(timeRemaining),
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColorSchemes.pcrAccent,
                          fontFeatures: [
                            const FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),

          // Phase Timeline
          GlassCard(
            child: PhaseTimeline(
              currentPhase: currentPhase,
              color: AppColorSchemes.pcrAccent,
            ),
          ),
          const SizedBox(height: 24),

          // Temperature zones with gauges
          if (temperature != null && temperature.isNotEmpty) ...[
            Text(
              'Temperature Zones',
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(temperature.length, (index) {
              final temp = temperature[index] as double? ?? 0.0;
              final setpoint = setpoints != null && index < setpoints.length
                  ? setpoints[index] as double?
                  : null;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    TemperatureGauge(
                      value: temp,
                      minValue: 0,
                      maxValue: 100,
                      label: 'Zone ${index + 1}',
                      color: AppColorSchemes.pcrAccent,
                      setpoint: setpoint,
                    ),
                    const SizedBox(height: 12),
                    Consumer(
                      builder: (context, ref, child) {
                        return GlassButton(
                          label: 'Adjust Setpoint',
                          icon: Icons.tune,
                          onPressed: () async {
                            final newSetpoint = await showDialog<double>(
                              context: context,
                              builder: (context) => SetpointDialog(
                                label: 'Zone ${index + 1} Setpoint',
                                currentValue: setpoint ?? 95.0,
                                minValue: 0,
                                maxValue: 100,
                                color: AppColorSchemes.pcrAccent,
                              ),
                            );

                            if (newSetpoint == null) return;

                            try {
                              final repository = ref.read(
                                  deviceRepositoryProvider(widget.device));
                              await repository.setSetpoint(index, newSetpoint);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Zone ${index + 1} setpoint: ${newSetpoint.toStringAsFixed(1)}°C',
                                    ),
                                  ),
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
                    ),
                  ],
                ),
              );
            }),
          ],

          // Control panel
          const SizedBox(height: 16),
          _buildControlPanel(context, state),
        ],
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, String state) {
    return Consumer(
      builder: (context, ref, child) {
        final repository = ref.watch(deviceRepositoryProvider(widget.device));

        return ControlPanel(
          state: state,
          deviceType: 'PCR',
          onStart: () async {
            if (_isDialogShowing) return;

            _isDialogShowing = true;
            try {
              // Show program selector dialog
              final selected = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  builder: (context, scrollController) =>
                      ProgramSelectorDialog(device: widget.device),
                ),
              );

              if (selected == null) return;

              // Start device with selected program
              try {
                await repository.startDevice(selected);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Started: ${selected['name'] ?? 'Program'}',
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            } finally {
              _isDialogShowing = false;
            }
          },
          onStop: () async {
            try {
              await repository.stopDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PCR stopped')),
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
                  const SnackBar(content: Text('PCR paused')),
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
                  const SnackBar(content: Text('PCR resumed')),
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

  PCRPhase _parsePhase(dynamic phase) {
    final phaseStr = phase.toString().toUpperCase();
    if (phaseStr.contains('HOT') && phaseStr.contains('START')) {
      return PCRPhase.hotStart;
    }
    if (phaseStr.contains('INIT')) {
      return PCRPhase.initialDenature;
    }
    if (phaseStr.contains('DENATURE')) {
      return PCRPhase.denature;
    }
    if (phaseStr.contains('ANNEAL') && phaseStr.contains('EXTEND')) {
      return PCRPhase.annealExtend;
    }
    if (phaseStr.contains('ANNEAL')) {
      return PCRPhase.anneal;
    }
    if (phaseStr.contains('EXTEND') && phaseStr.contains('FINAL')) {
      return PCRPhase.finalExtend;
    }
    if (phaseStr.contains('EXTEND')) {
      return PCRPhase.extend;
    }
    if (phaseStr.contains('HOLD')) {
      return PCRPhase.hold;
    }
    if (phaseStr.contains('COMPLETE')) {
      return PCRPhase.complete;
    }
    return PCRPhase.idle;
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
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
            'Cannot connect to ${widget.device.name}',
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
                  // Refresh the provider to reconnect
                  ref.invalidate(telemetryStreamProvider(widget.device));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeviceSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Device Settings',
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Device Information'),
              subtitle:
                  Text('ID: ${widget.device.id}\nHost: ${widget.device.host}'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.factory_outlined,
                  color: AppColorSchemes.error),
              title: const Text('Factory Reset',
                  style: TextStyle(color: AppColorSchemes.error)),
              subtitle: const Text('Wipe all settings and reset device'),
              onTap: () {
                Navigator.pop(context);
                _factoryReset(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _factoryReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Factory Reset'),
        content: const Text(
          'Are you sure you want to factory reset this device? '
          'All configurations and programs will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColorSchemes.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final repository = ref.read(deviceRepositoryProvider(widget.device));
        await repository.factoryReset();
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Factory reset signal sent')),
        );
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
