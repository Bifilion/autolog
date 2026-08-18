import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../providers/statistics_provider.dart';

class MonthlyCostChart extends StatelessWidget {
  final List<MonthlyCost> data;

  const MonthlyCostChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 24),
              Text(
                "Pro vybrané období nejsou žádná data.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    final maxValue = data.map((e) => e.cost).reduce((a, b) => a > b ? a : b);

    final minValue = data.map((e) => e.cost).reduce((a, b) => a < b ? a : b);

    final maxY = maxValue == 0 ? 100.0 : maxValue * 1.25;

    final minY = minValue > 0 ? (minValue * 0.75) : 0.0;

    final primary = Theme.of(context).colorScheme.primary;

    final spots = List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index].cost),
    );

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),

            const SizedBox(height: 6),

            Text(
              "Celkové náklady za jednotlivá období",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 260,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: data.length > 1 ? (data.length - 1).toDouble() : 1,

                  minY: minY,
                  maxY: maxY,

                  clipData: const FlClipData.all(),

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: _horizontalInterval(maxY),
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withValues(alpha: 0.12),
                        strokeWidth: 1,
                      );
                    },
                  ),

                  borderData: FlBorderData(show: false),

                  lineTouchData: LineTouchData(
                    enabled: true,

                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();

                          if (index < 0 || index >= data.length) {
                            return null;
                          }

                          final item = data[index];

                          return LineTooltipItem(
                            "${item.month}\n"
                            "${item.cost.toStringAsFixed(0)} Kč",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),

                    getTouchedSpotIndicator: (barData, spotIndexes) {
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: primary.withValues(alpha: 0.35),
                            strokeWidth: 1,
                            dashArray: [4, 4],
                          ),
                          FlDotData(
                            getDotPainter: (spot, percent, bar, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: primary,
                                strokeWidth: 3,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
                  ),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        interval: _leftInterval(maxY),
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatAxisValue(value),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: _bottomInterval(data.length),
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              data[index].month,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,

                      isCurved: true,

                      curveSmoothness: .25,

                      color: primary,

                      barWidth: 3,

                      isStrokeCapRound: true,

                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: primary,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),

                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            primary.withValues(alpha: 0.18),
                            primary.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  "Náklady",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const Spacer(),

                Text(
                  "${data.length} období",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.show_chart_rounded, color: primary),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Text(
            "Vývoj nákladů",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static double _bottomInterval(int length) {
    if (length <= 6) {
      return 1;
    }

    if (length <= 12) {
      return 2;
    }

    if (length <= 24) {
      return 4;
    }

    return 6;
  }

  static double _leftInterval(double maxY) {
    if (maxY <= 1000) {
      return 200;
    }

    if (maxY <= 5000) {
      return 1000;
    }

    if (maxY <= 10000) {
      return 2000;
    }

    return maxY / 5;
  }

  static double _horizontalInterval(double maxY) {
    if (maxY <= 1000) {
      return 200;
    }

    if (maxY <= 5000) {
      return 1000;
    }

    if (maxY <= 10000) {
      return 2000;
    }

    return maxY / 5;
  }

  static String _formatAxisValue(double value) {
    if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(0)}k";
    }

    return value.toStringAsFixed(0);
  }
}
