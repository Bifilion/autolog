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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              "Žádné údaje pro graf",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      );
    }

    final maxValue = data.map((e) => e.cost).reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,

      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 44,

                  height: 44,

                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(.15),

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Icon(
                    Icons.bar_chart_rounded,

                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "Vývoj nákladů",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 260,

              child: BarChart(
                BarChartData(
                  maxY: maxValue == 0 ? 100 : maxValue * 1.25,

                  alignment: BarChartAlignment.spaceAround,

                  gridData: FlGridData(show: true, drawVerticalLine: false),

                  borderData: FlBorderData(show: false),

                  barTouchData: BarTouchData(
                    enabled: true,

                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          "${data[groupIndex].month}\n"
                          "${rod.toY.toStringAsFixed(0)} Kč",

                          const TextStyle(
                            fontWeight: FontWeight.bold,

                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        reservedSize: 32,

                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),

                            child: Text(
                              data[index].month,

                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: List.generate(data.length, (index) {
                    return BarChartGroupData(
                      x: index,

                      barRods: [
                        BarChartRodData(
                          toY: data[index].cost,

                          width: 18,

                          borderRadius: BorderRadius.circular(8),

                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,

                              Theme.of(context).colorScheme.secondary,
                            ],

                            begin: Alignment.bottomCenter,

                            end: Alignment.topCenter,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
