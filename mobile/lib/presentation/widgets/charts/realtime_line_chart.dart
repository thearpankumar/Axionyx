import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/text_styles.dart';

/// Real-time line chart for temperature monitoring
class RealtimeLineChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final String label;
  final double? setpoint;
  final double minY;
  final double maxY;
  final int maxDataPoints;

  const RealtimeLineChart({
    super.key,
    required this.data,
    this.color = Colors.blue,
    required this.label,
    this.setpoint,
    this.minY = 0,
    this.maxY = 100,
    this.maxDataPoints = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            label,
            style: AppTextStyles.titleSmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.8),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: data.isEmpty
              ? Center(
                  child: Text(
                    'No data available',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: LineChart(
                    _buildChartData(context),
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.linear,
                  ),
                ),
        ),
      ],
    );
  }

  LineChartData _buildChartData(BuildContext context) {
    final spots = <FlSpot>[];
    final displayData = data.length > maxDataPoints
        ? data.sublist(data.length - maxDataPoints)
        : data;

    for (var i = 0; i < displayData.length; i++) {
      spots.add(FlSpot(i.toDouble(), displayData[i]));
    }

    return LineChartData(
      minY: minY,
      maxY: maxY,
      minX: 0,
      maxX: (displayData.length - 1).toDouble(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxY - minY) / 4,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.1),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: (maxY - minY) / 4,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      lineBarsData: [
        // Setpoint line
        if (setpoint != null)
          LineChartBarData(
            spots: [
              FlSpot(0, setpoint!),
              FlSpot((displayData.length - 1).toDouble(), setpoint!),
            ],
            isCurved: false,
            color: Colors.white.withValues(alpha: 0.5),
            barWidth: 1.5,
            dotData: const FlDotData(show: false),
            dashArray: [5, 5],
          ),
        // Actual temperature line
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.3),
                color.withValues(alpha: 0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (group) => Colors.black.withValues(alpha: 0.8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toStringAsFixed(1)}°C',
                AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
