import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';

/// Circular progress ring for PCR cycles
class ProgressRing extends StatefulWidget {
  final int current;
  final int total;
  final String? phase;
  final Color color;
  final double size;

  const ProgressRing({
    super.key,
    required this.current,
    required this.total,
    this.phase,
    this.color = Colors.blue,
    this.size = 200,
  });

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    final progress = widget.total > 0 ? widget.current / widget.total : 0.0;
    _animation = Tween<double>(begin: 0, end: progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
    _previousProgress = progress;
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newProgress = widget.total > 0 ? widget.current / widget.total : 0.0;
    if (oldWidget.current != widget.current ||
        oldWidget.total != widget.total) {
      _animation =
          Tween<double>(begin: _previousProgress, end: newProgress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward(from: 0);
      _previousProgress = newProgress;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: _animation.value,
              color: widget.color,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.current}',
                          style: AppTextStyles.getTemperatureStyle(
                            fontSize: widget.size * 0.2,
                          ).copyWith(
                            color: widget.color,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${widget.total}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: widget.size * 0.1,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cycles',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  if (widget.phase != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: widget.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        widget.phase!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: widget.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 15;
    const startAngle = -math.pi / 2; // Start at top
    const fullAngle = math.pi * 2; // Full circle

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullAngle,
      false,
      backgroundPaint,
    );

    // Draw progress arc with gradient
    if (progress > 0) {
      final progressAngle = fullAngle * progress.clamp(0.0, 1.0);

      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + progressAngle,
        colors: [
          color,
          color.withValues(alpha: 0.6),
          color,
        ],
        stops: const [0.0, 0.5, 1.0],
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: radius),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        progressAngle,
        false,
        progressPaint,
      );

      // Draw end cap
      final endAngle = startAngle + progressAngle;
      final capX = center.dx + radius * math.cos(endAngle);
      final capY = center.dy + radius * math.sin(endAngle);

      final capPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(capX, capY),
        10,
        capPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
