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
import '../../widgets/charts/temperature_gauge.dart';
import '../../widgets/charts/protocol_timeline.dart';
import '../../widgets/device_control/control_panel.dart';
import '../../widgets/device_control/alarm_card.dart';
import '../../widgets/dialogs/protocol_selector_dialog.dart';
import '../../widgets/dialogs/setpoint_dialog.dart';

/// Incubator device detail screen
/// Incubator device detail screen
class IncubatorDetailScreen extends ConsumerStatefulWidget {
  final DeviceInfo device;

  const IncubatorDetailScreen({super.key, required this.device});

  @override
  ConsumerState<IncubatorDetailScreen> createState() =>
      _IncubatorDetailScreenState();
}

class _IncubatorDetailScreenState extends ConsumerState<IncubatorDetailScreen> {
  bool _isDialogShowing = false;

  bool _isDeviceReachable = false;

  static const Map<String, dynamic> _emptyTelemetry = {
    'state': 'IDLE',
    'uptime': 0,
    'temperature': 0.0,
    'humidity': 0.0,
    'co2Level': 0.0,
    'temperatureSetpoint': 0.0,
    'humiditySetpoint': 0.0,
    'co2Setpoint': 0.0,
    'temperatureStable': false,
    'humidityStable': false,
    'co2Stable': false,
    'environmentStable': false,
    'timeStable': 0,
    'errors': [],
  };

  @override
  Widget build(BuildContext context) {
    final telemetryAsync = ref.watch(telemetryStreamProvider(widget.device));

    _isDeviceReachable = telemetryAsync.hasValue && !telemetryAsync.isLoading;
    final isConnecting = telemetryAsync.isLoading;
    final isOffline = telemetryAsync.hasError;
    final telemetry = telemetryAsync.asData?.value ?? _emptyTelemetry;

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
          child: Column(
            children: [
              _buildConnectionBanner(
                context,
                isConnecting: isConnecting,
                isOffline: isOffline,
              ),
              Expanded(child: _buildContent(context, telemetry)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionBanner(
    BuildContext context, {
    required bool isConnecting,
    required bool isOffline,
  }) {
    if (!isConnecting && !isOffline) return const SizedBox.shrink();

    final color = isConnecting ? AppColorSchemes.warning : AppColorSchemes.error;
    final icon = isConnecting ? Icons.wifi_find : Icons.wifi_off;
    final message = isConnecting
        ? 'Connecting to ${widget.device.name}…'
        : 'Device offline — check that it is powered on and on the same network';

    return Container(
      color: color.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(color: color),
            ),
          ),
          if (isConnecting)
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2, color: color),
            ),
          if (isOffline)
            TextButton(
              onPressed: () =>
                  ref.invalidate(telemetryStreamProvider(widget.device)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.bodySmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showNotConnectedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.wifi_off, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            const Text('Device is not connected'),
          ],
        ),
        backgroundColor: AppColorSchemes.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> telemetry) {
    final state = telemetry['state'] ?? 'IDLE';
    final temperature = (telemetry['temperature'] as num?)?.toDouble() ?? 0.0;
    final humidity = (telemetry['humidity'] as num?)?.toDouble() ?? 0.0;
    final co2 = (telemetry['co2Level'] as num?)?.toDouble() ?? 0.0;
    final environmentStable = telemetry['environmentStable'] ?? false;
    final tempSetpoint = (telemetry['temperatureSetpoint'] as num?)?.toDouble();
    final humiditySetpoint = (telemetry['humiditySetpoint'] as num?)
        ?.toDouble();
    final co2Setpoint = (telemetry['co2Setpoint'] as num?)?.toDouble();
    final alarms = telemetry['alarms'] as List?;
    final stage = telemetry['currentStage'] ?? 'IDLE';

    // Parse protocol stage
    final currentStage = _parseStage(stage);

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
                const Text('Status', style: AppTextStyles.titleMedium),
                StatusBadge(status: state),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Stability indicator
          if (environmentStable)
            GlassCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColorSchemes.success,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Environment Stable',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColorSchemes.success,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Conditions within acceptable range',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),

          // Protocol Timeline
          if (state == 'RUNNING' || state == 'PAUSED')
            GlassCard(
              child: ProtocolTimeline(
                currentStage: currentStage,
                color: AppColorSchemes.incubatorAccent,
              ),
            ),
          if (state == 'RUNNING' || state == 'PAUSED')
            const SizedBox(height: 24),

          // Environmental gauges
          Text(
            'Environmental Parameters',
            style: AppTextStyles.titleMedium.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),

          // Temperature
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TemperatureGauge(
                  value: temperature,
                  minValue: 0,
                  maxValue: 50,
                  label: 'Temperature',
                  color: Colors.red,
                  setpoint: tempSetpoint,
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, child) {
                    return GlassButton(
                      label: 'Adjust Temperature',
                      icon: Icons.tune,
                      onPressed: () async {
                        if (!_isDeviceReachable) {
                          _showNotConnectedSnackbar(context);
                          return;
                        }
                        final newSetpoint = await showDialog<double>(
                          context: context,
                          builder: (context) => SetpointDialog(
                            label: 'Temperature Setpoint',
                            currentValue: tempSetpoint ?? 37.0,
                            minValue: 0,
                            maxValue: 50,
                            color: Colors.red,
                          ),
                        );

                        if (newSetpoint == null) return;

                        try {
                          final repository = ref.read(
                            deviceRepositoryProvider(widget.device),
                          );
                          await repository.setSetpoint(0, newSetpoint);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Temperature setpoint: ${newSetpoint.toStringAsFixed(1)}°C',
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
          ),
          const SizedBox(height: 24),

          // Humidity
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TemperatureGauge(
                  value: humidity,
                  minValue: 0,
                  maxValue: 100,
                  label: 'Humidity',
                  color: Colors.blue,
                  setpoint: humiditySetpoint,
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, child) {
                    return GlassButton(
                      label: 'Adjust Humidity',
                      icon: Icons.tune,
                      onPressed: () async {
                        if (!_isDeviceReachable) {
                          _showNotConnectedSnackbar(context);
                          return;
                        }
                        final newSetpoint = await showDialog<double>(
                          context: context,
                          builder: (context) => SetpointDialog(
                            label: 'Humidity Setpoint',
                            currentValue: humiditySetpoint ?? 70.0,
                            minValue: 0,
                            maxValue: 100,
                            color: Colors.blue,
                          ),
                        );

                        if (newSetpoint == null) return;

                        try {
                          final repository = ref.read(
                            deviceRepositoryProvider(widget.device),
                          );
                          await repository.setSetpoint(1, newSetpoint);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Humidity setpoint: ${newSetpoint.toStringAsFixed(1)}%',
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
          ),
          const SizedBox(height: 24),

          // CO2
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TemperatureGauge(
                  value: co2,
                  minValue: 0,
                  maxValue: 10,
                  label: 'CO₂',
                  color: Colors.green,
                  setpoint: co2Setpoint,
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, child) {
                    return GlassButton(
                      label: 'Adjust CO₂',
                      icon: Icons.tune,
                      onPressed: () async {
                        if (!_isDeviceReachable) {
                          _showNotConnectedSnackbar(context);
                          return;
                        }
                        final newSetpoint = await showDialog<double>(
                          context: context,
                          builder: (context) => SetpointDialog(
                            label: 'CO₂ Setpoint',
                            currentValue: co2Setpoint ?? 5.0,
                            minValue: 0,
                            maxValue: 10,
                            color: Colors.green,
                          ),
                        );

                        if (newSetpoint == null) return;

                        try {
                          final repository = ref.read(
                            deviceRepositoryProvider(widget.device),
                          );
                          await repository.setSetpoint(2, newSetpoint);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'CO₂ setpoint: ${newSetpoint.toStringAsFixed(1)}%',
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
          ),
          const SizedBox(height: 24),

          // Alarms
          if (alarms != null && alarms.isNotEmpty) ...[
            Text(
              'Active Alarms',
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 12),
            ...alarms.asMap().entries.map((entry) {
              final index = entry.key;
              final alarm = entry.value;
              return AlarmCard(
                severity: _parseSeverity(alarm['severity']),
                type: _parseAlarmType(alarm['type']),
                message: alarm['message'] ?? 'Unknown alarm',
                timestamp:
                    DateTime.tryParse(alarm['timestamp'] ?? '') ??
                    DateTime.now(),
                acknowledged: alarm['acknowledged'] ?? false,
                onAcknowledge: () async {
                  await _acknowledgeAlarm(ref, index);
                },
              );
            }),
            const SizedBox(height: 16),
          ],

          // Control panel
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
          deviceType: 'Incubator',
          onStart: () async {
            if (_isDialogShowing) return;

            _isDialogShowing = true;
            try {
              // Show protocol selector dialog
              final selected = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  builder: (context, scrollController) =>
                      ProtocolSelectorDialog(device: widget.device),
                ),
              );

              if (selected == null) return;

              // Check reachability only when about to send the command
              if (!_isDeviceReachable) {
                if (context.mounted) _showNotConnectedSnackbar(context);
                return;
              }

              // Start device with selected protocol
              try {
                await repository.startProtocol(selected);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Started: ${selected['name'] ?? 'Protocol'}',
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            } finally {
              _isDialogShowing = false;
            }
          },
          onStop: () async {
            if (!_isDeviceReachable) {
              _showNotConnectedSnackbar(context);
              return;
            }
            try {
              await repository.stopDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Protocol stopped')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            }
          },
          onPause: () async {
            if (!_isDeviceReachable) {
              _showNotConnectedSnackbar(context);
              return;
            }
            try {
              await repository.pauseDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Protocol paused')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            }
          },
          onResume: () async {
            if (!_isDeviceReachable) {
              _showNotConnectedSnackbar(context);
              return;
            }
            try {
              await repository.resumeDevice();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Protocol resumed')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            }
          },
        );
      },
    );
  }

  ProtocolStage _parseStage(dynamic stage) {
    final stageStr = stage.toString().toUpperCase();
    if (stageStr.contains('PRE') && stageStr.contains('EQUI')) {
      return ProtocolStage.preEquilibration;
    }
    if (stageStr.contains('STAGE') && stageStr.contains('1')) {
      return ProtocolStage.stage1;
    }
    if (stageStr.contains('STAGE') && stageStr.contains('2')) {
      return ProtocolStage.stage2;
    }
    if (stageStr.contains('STAGE') && stageStr.contains('3')) {
      return ProtocolStage.stage3;
    }
    if (stageStr.contains('STAGE') && stageStr.contains('4')) {
      return ProtocolStage.stage4;
    }
    if (stageStr.contains('COOL')) return ProtocolStage.coolDown;
    if (stageStr.contains('COMPLETE')) return ProtocolStage.complete;
    return ProtocolStage.idle;
  }

  AlarmSeverity _parseSeverity(dynamic severity) {
    final severityStr = severity.toString().toUpperCase();
    if (severityStr.contains('CRITICAL')) return AlarmSeverity.critical;
    return AlarmSeverity.warning;
  }

  AlarmType _parseAlarmType(dynamic type) {
    final typeStr = type.toString().toUpperCase();
    if (typeStr.contains('TEMP') && typeStr.contains('HIGH')) {
      return AlarmType.tempHigh;
    }
    if (typeStr.contains('TEMP') && typeStr.contains('LOW')) {
      return AlarmType.tempLow;
    }
    if (typeStr.contains('HUMID') && typeStr.contains('LOW')) {
      return AlarmType.humidityLow;
    }
    if (typeStr.contains('CO2') && typeStr.contains('HIGH')) {
      return AlarmType.co2High;
    }
    if (typeStr.contains('CO2') && typeStr.contains('LOW')) {
      return AlarmType.co2Low;
    }
    if (typeStr.contains('DOOR')) return AlarmType.doorOpen;
    if (typeStr.contains('POWER')) return AlarmType.powerFailure;
    return AlarmType.sensorFault;
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
              subtitle: Text(
                'ID: ${widget.device.id}\nHost: ${widget.device.host}',
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.factory_outlined,
                color: AppColorSchemes.error,
              ),
              title: const Text(
                'Factory Reset',
                style: TextStyle(color: AppColorSchemes.error),
              ),
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
          'All configurations and protocols will be lost.',
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  /// Acknowledge alarm at given index
  Future<void> _acknowledgeAlarm(WidgetRef ref, int index) async {
    try {
      final repository = ref.read(deviceRepositoryProvider(widget.device));
      await repository.acknowledgeAlarm(index);
    } catch (e) {
      // Error is handled by repository/API client
    }
  }
}
