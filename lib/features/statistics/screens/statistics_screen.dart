import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:autolog/features/statistics/providers/statistics_provider.dart';
import 'package:autolog/features/statistics/widgets/expense_pie_chart.dart';
import 'package:autolog/features/statistics/widgets/monthly_cost_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  final String carId;

  const StatisticsScreen({super.key, required this.carId});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  StatisticsPeriod selectedPeriod = StatisticsPeriod.all;

  @override
  Widget build(BuildContext context) {
    final id = int.parse(widget.carId);

    final statistics = ref.watch(
      statisticsProvider(StatisticsFilter(carId: id, period: selectedPeriod)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Statistiky")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: statistics.when(
          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error, stack) =>
              Center(child: Text("Chyba načtení statistik")),

          data: (data) {
            return ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        const Text("Celkové náklady"),

                        const SizedBox(height: 8),

                        Text(
                          "${data.totalCost.toStringAsFixed(0)} Kč",

                          style: const TextStyle(
                            fontSize: 32,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),

                    child: DropdownButtonFormField<StatisticsPeriod>(
                      value: selectedPeriod,

                      decoration: const InputDecoration(
                        labelText: "Období",

                        border: OutlineInputBorder(),
                      ),

                      items: StatisticsPeriod.values
                          .map(
                            (period) => DropdownMenuItem(
                              value: period,

                              child: Text(period.label),
                            ),
                          )
                          .toList(),

                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          selectedPeriod = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                ExpensePieChart(
                  fuelCost: data.fuelCost,

                  serviceCost: data.serviceCost,
                ),

                const SizedBox(height: 12),

                MonthlyCostChart(data: data.monthlyCosts),

                const SizedBox(height: 12),

                _statCard(
                  icon: Icons.local_gas_station,

                  title: "Palivo",

                  value: data.fuelCost,

                  color: Colors.green,
                ),

                _statCard(
                  icon: Icons.build,

                  title: "Servis",

                  value: data.serviceCost,

                  color: Colors.orange,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,

    required String title,

    required double value,

    Color? color,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),

        title: Text(title),

        trailing: Text(
          "${value.toStringAsFixed(0)} Kč",

          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
