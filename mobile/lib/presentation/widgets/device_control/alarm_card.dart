import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/constants/device_types.dart';
import '../common/glass_card.dart';

/// Alarm card for displaying device alarms
class AlarmCard extends StatelessWidget {
  final AlarmSeverity severity;
  final AlarmType type;
  final String message;
  final DateTime timestamp;
  final bool acknowledged;
  final VoidCallback? onAcknowledge;

  const AlarmCard({
    super.key,
    required this.severity,
    required this.type,
    required this.message,
    required this.timestamp,
    this.acknowledged = false,
    this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getSeverityColor(severity);

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Severity indicator
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),

          // Alarm icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getAlarmIcon(type),
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Alarm details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _getSeverityLabel(severity),
                      style: AppTextStyles.titleSmall.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (acknowledged) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.green.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          'ACK',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTimestamp(timestamp),
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

          // Acknowledge button
          if (!acknowledged && onAcknowledge != null)
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              color: color,
              onPressed: onAcknowledge,
              tooltip: 'Acknowledge',
            ),
        ],
      ),
    );
  }

  Color _getSeverityColor(AlarmSeverity severity) {
    switch (severity) {
      case AlarmSeverity.critical:
        return AppColorSchemes.error;
      case AlarmSeverity.warning:
        return AppColorSchemes.warning;
    }
  }

  String _getSeverityLabel(AlarmSeverity severity) {
    switch (severity) {
      case AlarmSeverity.critical:
        return 'CRITICAL';
      case AlarmSeverity.warning:
        return 'WARNING';
    }
  }

  IconData _getAlarmIcon(AlarmType type) {
    switch (type) {
      case AlarmType.tempHigh:
      case AlarmType.tempLow:
        return Icons.thermostat;
      case AlarmType.humidityLow:
        return Icons.water_drop;
      case AlarmType.co2High:
      case AlarmType.co2Low:
        return Icons.cloud;
      case AlarmType.doorOpen:
        return Icons.door_front_door;
      case AlarmType.powerFailure:
        return Icons.power_off;
      case AlarmType.sensorFault:
        return Icons.error_outline;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
