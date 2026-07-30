import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final double fuelCost;
  final double serviceCost;

  const ExpensePieChart({
    super.key,
    required this.fuelCost,
    required this.serviceCost,
  });

  @override
  Widget build(BuildContext context) {
    final total = fuelCost + serviceCost;

    if (total == 0) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("Žádné náklady")),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Text(
              "Rozdělení nákladů",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 220,

              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,

                  centerSpaceRadius: 45,

                  sections: [
                    PieChartSectionData(
                      value: fuelCost,

                      title:
                          "${((fuelCost / total) * 100).toStringAsFixed(0)} %",

                      color: Colors.green,

                      radius: 80,

                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: serviceCost,

                      title:
                          "${((serviceCost / total) * 100).toStringAsFixed(0)} %",

                      color: Colors.orange,

                      radius: 80,

                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                _legend(Colors.green, "Palivo", fuelCost),

                const SizedBox(width: 20),

                _legend(Colors.orange, "Servis", serviceCost),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(Color color, String title, double value) {
    return Row(
      children: [
        Container(
          width: 12,

          height: 12,

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 6),

        Text("$title ${value.toStringAsFixed(0)} Kč"),
      ],
    );
  }
}
