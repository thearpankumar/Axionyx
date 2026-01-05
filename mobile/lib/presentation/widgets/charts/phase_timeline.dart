import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/constants/device_types.dart';

/// PCR phase timeline showing past, current, and future phases
class PhaseTimeline extends StatelessWidget {
  final PCRPhase currentPhase;
  final Color color;

  const PhaseTimeline({
    super.key,
    required this.currentPhase,
    this.color = Colors.red,
  });

  List<PCRPhase> get _allPhases => [
        PCRPhase.idle,
        PCRPhase.hotStart,
        PCRPhase.initialDenature,
        PCRPhase.denature,
        PCRPhase.anneal,
        PCRPhase.extend,
        PCRPhase.finalExtend,
        PCRPhase.hold,
        PCRPhase.complete,
      ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _allPhases.indexOf(currentPhase);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Phase Progress',
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
            itemCount: _allPhases.length,
            itemBuilder: (context, index) {
              final phase = _allPhases[index];
              final isPast = index < currentIndex;
              final isCurrent = index == currentIndex;
              final isFuture = index > currentIndex;

              return _buildPhaseItem(
                context,
                phase,
                isPast: isPast,
                isCurrent: isCurrent,
                isFuture: isFuture,
                isLast: index == _allPhases.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhaseItem(
    BuildContext context,
    PCRPhase phase, {
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
                _getPhaseLabel(phase),
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

  String _getPhaseLabel(PCRPhase phase) {
    switch (phase) {
      case PCRPhase.idle:
        return 'Idle';
      case PCRPhase.hotStart:
        return 'Hot\nStart';
      case PCRPhase.initialDenature:
        return 'Initial\nDenature';
      case PCRPhase.denature:
        return 'Denature';
      case PCRPhase.anneal:
        return 'Anneal';
      case PCRPhase.extend:
        return 'Extend';
      case PCRPhase.annealExtend:
        return 'Anneal\n+Extend';
      case PCRPhase.finalExtend:
        return 'Final\nExtend';
      case PCRPhase.hold:
        return 'Hold';
      case PCRPhase.complete:
        return 'Complete';
    }
  }
}
