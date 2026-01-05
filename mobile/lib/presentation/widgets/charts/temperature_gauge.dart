import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/text_styles.dart';

/// Circular temperature gauge with animated needle
class TemperatureGauge extends StatefulWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final String label;
  final Color color;
  final double? setpoint;

  const TemperatureGauge({
    super.key,
    required this.value,
    this.minValue = 0,
    this.maxValue = 100,
    required this.label,
    this.color = Colors.blue,
    this.setpoint,
  });

  @override
  State<TemperatureGauge> createState() => _TemperatureGaugeState();
}

class _TemperatureGaugeState extends State<TemperatureGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(TemperatureGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation =
          Tween<double>(begin: _previousValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.forward(from: 0);
      _previousValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _GaugePainter(
                  value: _animation.value,
                  minValue: widget.minValue,
                  maxValue: widget.maxValue,
                  color: widget.color,
                  setpoint: widget.setpoint,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surface
                      .withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _animation.value.toStringAsFixed(1),
                        style: AppTextStyles.getTemperatureStyle(fontSize: 36),
                      ),
                      Text(
                        '°C',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: AppTextStyles.bodyMedium.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        if (widget.setpoint != null) ...[
          const SizedBox(height: 4),
          Text(
            'Setpoint: ${widget.setpoint!.toStringAsFixed(1)}°C',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
          ),
        ],
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final Color color;
  final double? setpoint;
  final Color backgroundColor;

  _GaugePainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.color,
    this.setpoint,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    const startAngle = math.pi * 0.75; // 135 degrees
    const sweepAngle = math.pi * 1.5; // 270 degrees

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw value arc with gradient
    final normalizedValue =
        ((value - minValue) / (maxValue - minValue)).clamp(0.0, 1.0);
    final valueAngle = sweepAngle * normalizedValue;

    // Only draw gradient if there's a value to show
    if (valueAngle > 0) {
      // Ensure endAngle is always larger than startAngle by a small amount to avoid assertion error
      final endAngle =
          startAngle + valueAngle + 0.001; // Small epsilon to ensure difference

      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: endAngle,
        colors: [
          color.withValues(alpha: 0.5),
          color,
        ],
      );

      final valuePaint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: radius),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        valueAngle,
        false,
        valuePaint,
      );
    } else {
      // Draw a simple arc when value is 0
      final valuePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        valueAngle,
        false,
        valuePaint,
      );
    }

    // Draw setpoint indicator if available
    if (setpoint != null) {
      final normalizedSetpoint =
          ((setpoint! - minValue) / (maxValue - minValue)).clamp(0.0, 1.0);
      final setpointAngle = startAngle + (sweepAngle * normalizedSetpoint);

      final setpointPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final setpointX = center.dx + radius * math.cos(setpointAngle);
      final setpointY = center.dy + radius * math.sin(setpointAngle);

      canvas.drawCircle(
        Offset(setpointX, setpointY),
        6,
        setpointPaint,
      );

      // Draw inner circle
      final innerPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(setpointX, setpointY),
        3,
        innerPaint,
      );
    }

    // Draw tick marks
    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 2;

    for (var i = 0; i <= 10; i++) {
      final tickAngle = startAngle + (sweepAngle * i / 10);
      final innerRadius = radius - 12;
      final outerRadius = radius - 4;

      final x1 = center.dx + innerRadius * math.cos(tickAngle);
      final y1 = center.dy + innerRadius * math.sin(tickAngle);
      final x2 = center.dx + outerRadius * math.cos(tickAngle);
      final y2 = center.dy + outerRadius * math.sin(tickAngle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
    }
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.setpoint != setpoint ||
        oldDelegate.color != color;
  }
}
