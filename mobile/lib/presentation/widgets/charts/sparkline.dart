import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Mini sparkline chart for trend visualization
class Sparkline extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double height;
  final double strokeWidth;
  final bool showDots;
  final bool fillArea;

  const Sparkline({
    super.key,
    required this.data,
    this.color = Colors.blue,
    this.height = 40,
    this.strokeWidth = 2.0,
    this.showDots = false,
    this.fillArea = true,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(height: height);
    }

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(
          data: data,
          color: color,
          strokeWidth: strokeWidth,
          showDots: showDots,
          fillArea: fillArea,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool showDots;
  final bool fillArea;

  _SparklinePainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
    required this.showDots,
    required this.fillArea,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty || data.length < 2) return;

    final minValue = data.reduce(math.min);
    final maxValue = data.reduce(math.max);
    final range = maxValue - minValue;

    if (range == 0) {
      // Draw horizontal line if all values are the same
      final y = size.height / 2;
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );
      return;
    }

    final path = Path();
    final fillPath = Path();
    final points = <Offset>[];

    // Calculate points
    for (var i = 0; i < data.length; i++) {
      final x = (size.width / (data.length - 1)) * i;
      final normalizedValue = (data[i] - minValue) / range;
      final y = size.height - (normalizedValue * size.height);

      points.add(Offset(x, y));

      if (i == 0) {
        path.moveTo(x, y);
        if (fillArea) {
          fillPath.moveTo(x, size.height);
          fillPath.lineTo(x, y);
        }
      } else {
        path.lineTo(x, y);
        if (fillArea) {
          fillPath.lineTo(x, y);
        }
      }
    }

    // Close fill path
    if (fillArea) {
      fillPath.lineTo(size.width, size.height);
      fillPath.close();

      // Draw gradient fill
      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.3),
          color.withValues(alpha: 0.05),
        ],
      );

      final fillPaint = Paint()
        ..shader = gradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        )
        ..style = PaintingStyle.fill;

      canvas.drawPath(fillPath, fillPaint);
    }

    // Draw line
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    // Draw dots
    if (showDots) {
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final dotBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      for (final point in points) {
        canvas.drawCircle(point, 3, dotBorderPaint);
        canvas.drawCircle(point, 2.5, dotPaint);
      }

      // Highlight last point
      if (points.isNotEmpty) {
        final lastPoint = points.last;
        canvas.drawCircle(lastPoint, 5, dotBorderPaint);
        canvas.drawCircle(lastPoint, 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.showDots != showDots ||
        oldDelegate.fillArea != fillArea;
  }
}
