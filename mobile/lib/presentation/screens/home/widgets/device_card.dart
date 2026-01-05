import 'package:flutter/material.dart';
import '../../../widgets/common/glass_card.dart';
import '../../../widgets/common/status_badge.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/color_schemes.dart';
import '../../../../core/constants/device_types.dart';
import '../../../../data/models/device_info.dart';

/// Glassmorphic device card
class DeviceCard extends StatelessWidget {
  final DeviceInfo device;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final deviceColor = AppColorSchemes.getDeviceColor(device.type.id);

    return GlassHeroCard(
      heroTag: 'device-${device.id}',
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Device icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: deviceColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getDeviceIcon(device.type),
              color: deviceColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),

          // Device info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name,
                  style: AppTextStyles.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  device.type.displayName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.wifi,
                      size: 16,
                      color: device.isConnected ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      device.host,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete button or Status indicator
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: AppColorSchemes.error.withValues(alpha: 0.7),
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            const StatusBadge(status: 'IDLE'),
        ],
      ),
    );
  }

  IconData _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.pcr:
        return Icons.science_outlined;
      case DeviceType.incubator:
        return Icons.thermostat_outlined;
      case DeviceType.dummy:
        return Icons.device_unknown_outlined;
    }
  }
}
