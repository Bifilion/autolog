import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:flutter/material.dart';

class StatisticsPeriodSelector extends StatelessWidget {
  final StatisticsPeriod selected;

  final ValueChanged<StatisticsPeriod> onChanged;

  const StatisticsPeriodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final quickPeriods = [
      StatisticsPeriod.today,
      StatisticsPeriod.week,
      StatisticsPeriod.month,
      StatisticsPeriod.last12Months,
      StatisticsPeriod.all,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Icon(
                  Icons.date_range_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Období",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,

              runSpacing: 8,

              children: quickPeriods.map((period) {
                final active = selected == period;

                return ChoiceChip(
                  label: Text(period.label),

                  selected: active,

                  onSelected: (_) {
                    onChanged(period);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                icon: const Icon(Icons.tune),

                label: const Text("Více možností"),

                onPressed: () {
                  showModalBottomSheet(
                    context: context,

                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              "Vybrat období",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            ListTile(
                              leading: const Icon(Icons.calendar_view_month),

                              title: const Text("3 měsíce"),

                              onTap: () {
                                Navigator.pop(context);

                                onChanged(StatisticsPeriod.last3Months);
                              },
                            ),

                            ListTile(
                              leading: const Icon(Icons.calendar_month),

                              title: const Text("6 měsíců"),

                              onTap: () {
                                Navigator.pop(context);

                                onChanged(StatisticsPeriod.last6Months);
                              },
                            ),

                            ListTile(
                              leading: const Icon(Icons.today),

                              title: const Text("Tento rok"),

                              onTap: () {
                                Navigator.pop(context);

                                onChanged(StatisticsPeriod.thisYear);
                              },
                            ),

                            ListTile(
                              leading: const Icon(Icons.date_range),

                              title: const Text("Vlastní období"),

                              onTap: () {
                                Navigator.pop(context);

                                onChanged(StatisticsPeriod.custom);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
