import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/constants/device_types.dart';

/// Incubator protocol timeline showing past, current, and future stages
class ProtocolTimeline extends StatelessWidget {
  final ProtocolStage currentStage;
  final Color color;

  const ProtocolTimeline({
    super.key,
    required this.currentStage,
    this.color = Colors.green,
  });

  List<ProtocolStage> get _allStages => [
        ProtocolStage.idle,
        ProtocolStage.preEquilibration,
        ProtocolStage.stage1,
        ProtocolStage.stage2,
        ProtocolStage.stage3,
        ProtocolStage.stage4,
        ProtocolStage.coolDown,
        ProtocolStage.complete,
      ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _allStages.indexOf(currentStage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Protocol Progress',
            style: AppTextStyles.titleSmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.8),
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _allStages.length,
            itemBuilder: (context, index) {
              final stage = _allStages[index];
              final isPast = index < currentIndex;
              final isCurrent = index == currentIndex;
              final isFuture = index > currentIndex;

              return _buildStageItem(
                context,
                stage,
                isPast: isPast,
                isCurrent: isCurrent,
                isFuture: isFuture,
                isLast: index == _allStages.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStageItem(
    BuildContext context,
    ProtocolStage stage, {
    required bool isPast,
    required bool isCurrent,
    required bool isFuture,
    required bool isLast,
  }) {
    Color dotColor;
    Color lineColor;
    Color textColor;

    if (isPast) {
      dotColor = color;
      lineColor = color.withValues(alpha: 0.5);
      textColor =
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    } else if (isCurrent) {
      dotColor = color;
      lineColor =
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);
      textColor = color;
    } else {
      dotColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);
      lineColor =
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);
      textColor =
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);
    }

    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dot
            Container(
              width: isCurrent ? 20 : 12,
              height: isCurrent ? 20 : 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrent
                    ? dotColor.withValues(alpha: 0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: dotColor,
                  width: isCurrent ? 3 : 2,
                ),
              ),
              child: isPast
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 8,
                        color: color,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            // Label
            SizedBox(
              width: 80,
              child: Text(
                _getStageLabel(stage),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTextStyles.bodySmall.copyWith(
                  color: textColor,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        // Line
        if (!isLast)
          Container(
            width: 40,
            height: 2,
            margin: const EdgeInsets.only(bottom: 40),
            color: lineColor,
          ),
      ],
    );
  }

  String _getStageLabel(ProtocolStage stage) {
    switch (stage) {
      case ProtocolStage.idle:
        return 'Idle';
      case ProtocolStage.preEquilibration:
        return 'Pre-\nEquilib.';
      case ProtocolStage.stage1:
        return 'Stage 1';
      case ProtocolStage.stage2:
        return 'Stage 2';
      case ProtocolStage.stage3:
        return 'Stage 3';
      case ProtocolStage.stage4:
        return 'Stage 4';
      case ProtocolStage.coolDown:
        return 'Cool\nDown';
      case ProtocolStage.complete:
        return 'Complete';
    }
  }
}
