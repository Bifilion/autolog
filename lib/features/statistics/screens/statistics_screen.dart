import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:autolog/features/statistics/providers/statistics_provider.dart';
import 'package:autolog/features/statistics/widgets/expense_pie_chart.dart';
import 'package:autolog/features/statistics/widgets/monthly_cost_chart.dart';
import 'package:autolog/features/statistics/widgets/statistics_metric_card.dart';
import 'package:autolog/features/statistics/widgets/statistics_period_selector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  final String carId;

  const StatisticsScreen({super.key, required this.carId});

  @override
  ConsumerState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  StatisticsPeriod selectedPeriod = StatisticsPeriod.last12Months;

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

          error: (error, stack) => Center(child: Text("Chyba: $error")),

          data: (data) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 16),

                StatisticsPeriodSelector(
                  selected: selectedPeriod,
                  onChanged: (period) {
                    setState(() {
                      selectedPeriod = period;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // METRIKY
                Row(
                  children: [
                    Expanded(
                      child: StatisticsMetricCard(
                        icon: Icons.speed,
                        title: "Cena / km",
                        value: "${data.costPerKm.toStringAsFixed(2)} Kč",
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: StatisticsMetricCard(
                        icon: Icons.build,
                        title: "Servisů",
                        value: "${data.serviceCount}",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: StatisticsMetricCard(
                        icon: Icons.local_gas_station,
                        title: "Tankování",
                        value: "${data.fuelCount}",
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: StatisticsMetricCard(
                        icon: Icons.trending_up,
                        title: "Největší",
                        value: data.biggestExpense,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // GRAF 1
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ExpensePieChart(
                    fuelCost: data.fuelCost,
                    serviceCost: data.serviceCost,
                  ),
                ),

                const SizedBox(height: 16),

                // GRAF 2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: MonthlyCostChart(data: data.monthlyCosts),
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}
