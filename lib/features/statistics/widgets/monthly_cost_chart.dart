import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../providers/statistics_provider.dart';

class MonthlyCostChart extends StatelessWidget {
  final List<MonthlyCost> data;

  const MonthlyCostChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("Žádné údaje pro graf")),
        ),
      );
    }

    final maxValue = data.map((e) => e.cost).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Vývoj nákladů",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,

              child: BarChart(
                BarChartData(
                  maxY: maxValue * 1.2,

                  alignment: BarChartAlignment.spaceAround,

                  barTouchData: BarTouchData(enabled: true),

                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }

                          return Text(
                            data[index].month,
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  barGroups: List.generate(data.length, (index) {
                    return BarChartGroupData(
                      x: index,

                      barRods: [
                        BarChartRodData(
                          toY: data[index].cost,

                          width: 18,

                          borderRadius: BorderRadius.circular(4),
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
