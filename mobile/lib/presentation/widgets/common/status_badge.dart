import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/constants/device_types.dart';

/// Status badge widget with glassmorphism effect
class StatusBadge extends StatelessWidget {
  final String status;
  final DeviceState? deviceState;

  const StatusBadge({
    super.key,
    required this.status,
    this.deviceState,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = deviceState ?? DeviceState.fromString(status);
    final color = AppColorSchemes.getStatusColor(state.id);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              state.displayName.toUpperCase(),
              style: AppTextStyles.getStatusBadgeStyle(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
