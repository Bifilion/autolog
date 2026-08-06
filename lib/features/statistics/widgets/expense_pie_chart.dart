import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatefulWidget {
  final double fuelCost;
  final double serviceCost;

  const ExpensePieChart({
    super.key,
    required this.fuelCost,
    required this.serviceCost,
  });

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final total = widget.fuelCost + widget.serviceCost;

    if (total == 0) {
      return Card(
        child: const Padding(
          padding: EdgeInsets.all(20),

          child: Center(child: Text("Žádné náklady")),
        ),
      );
    }

    return Card(
      elevation: 0,

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
                    Icons.pie_chart_rounded,

                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  "Rozdělení nákladů",

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 260,

              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 45,

                  sectionsSpace: 4,

                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            response == null ||
                            response.touchedSection == null) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        }
                      });
                    },
                  ),

                  sections: [
                    _section(
                      value: widget.fuelCost,

                      title: "Palivo",

                      percent: widget.fuelCost / total,

                      color: Colors.green,

                      index: 0,
                    ),

                    _section(
                      value: widget.serviceCost,

                      title: "Servis",

                      percent: widget.serviceCost / total,

                      color: Colors.orange,

                      index: 1,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Column(
                children: [
                  Text(
                    "${total.toStringAsFixed(0)} Kč",

                    style: const TextStyle(
                      fontSize: 24,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Celkové náklady",

                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _legend(
              color: Colors.green,

              title: "Palivo",

              value: widget.fuelCost,

              percent: widget.fuelCost / total,
            ),

            const SizedBox(height: 12),

            _legend(
              color: Colors.orange,

              title: "Servis",

              value: widget.serviceCost,

              percent: widget.serviceCost / total,
            ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _section({
    required double value,

    required String title,

    required double percent,

    required Color color,

    required int index,
  }) {
    final isTouched = index == touchedIndex;

    return PieChartSectionData(
      value: value,

      color: color,

      radius: isTouched ? 95 : 82,

      title: "${(percent * 100).round()}%",

      titleStyle: const TextStyle(
        color: Colors.white,

        fontWeight: FontWeight.bold,

        fontSize: 14,
      ),
    );
  }

  Widget _legend({
    required Color color,

    required String title,

    required double value,

    required double percent,
  }) {
    return Row(
      children: [
        Container(
          width: 14,

          height: 14,

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        Text(
          "${value.toStringAsFixed(0)} Kč",

          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(width: 8),

        Text(
          "${(percent * 100).round()} %",

          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
