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

  // Barvy odpovídají významu jednotlivých kategorií,
  // ale zároveň dobře zapadají do fialového designu aplikace.
  static const Color fuelColor = Color(0xFF20C7B5);
  static const Color serviceColor = Color(0xFF7567F8);

  @override
  Widget build(BuildContext context) {
    final total = widget.fuelCost + widget.serviceCost;

    if (total == 0) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("Žádné náklady")),
        ),
      );
    }

    final fuelPercent = widget.fuelCost / total;
    final servicePercent = widget.serviceCost / total;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.pie_chart_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "Rozdělení nákladů",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // GRAF
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 60,
                  sectionsSpace: 5,
                  startDegreeOffset: -90,

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
                      percent: fuelPercent,
                      index: 0,
                      color: fuelColor,
                    ),

                    _section(
                      value: widget.serviceCost,
                      percent: servicePercent,
                      index: 1,
                      color: serviceColor,
                    ),
                  ],
                ),
              ),
            ),

            // STŘED GRAFU
            Transform.translate(
              offset: const Offset(0, -150),
              child: SizedBox(
                height: 70,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${total.toStringAsFixed(0)} Kč",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        "Celkem",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // VYSVĚTLENÍ
            Text(
              "Podíl jednotlivých nákladů",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // PALIVO
            _legend(
              color: fuelColor,
              title: "Palivo",
              value: widget.fuelCost,
              percent: fuelPercent,
            ),

            const SizedBox(height: 10),

            // SERVIS
            _legend(
              color: serviceColor,
              title: "Servis",
              value: widget.serviceCost,
              percent: servicePercent,
            ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _section({
    required double value,
    required double percent,
    required int index,
    required Color color,
  }) {
    final isTouched = index == touchedIndex;

    return PieChartSectionData(
      value: value,
      color: color,

      radius: isTouched ? 92 : 80,

      title: "${(percent * 100).round()}%",

      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),

      badgeWidget: null,
      showTitle: percent >= 0.05,
    );
  }

  Widget _legend({
    required Color color,
    required String title,
    required double value,
    required double percent,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          // BAREVNÝ INDIKÁTOR
          Container(
            width: 12,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const SizedBox(width: 12),

          // NÁZEV
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "${(percent * 100).round()} % nákladů",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          // CENA
          Text(
            "${value.toStringAsFixed(0)} Kč",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
