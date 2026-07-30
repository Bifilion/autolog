import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:autolog/features/statistics/providers/statistics_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CostOverviewCard extends ConsumerWidget {
  final int carId;

  const CostOverviewCard({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statistics = ref.watch(
      statisticsProvider(
        StatisticsFilter(carId: carId, period: StatisticsPeriod.all),
      ),
    );

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        onTap: () {
          context.push("/statistics/$carId");
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: statistics.when(
            loading: () => const SizedBox(
              height: 180,

              child: Center(child: CircularProgressIndicator()),
            ),

            error: (error, stack) => const SizedBox(
              height: 180,

              child: Center(child: Text("Chyba načtení nákladů")),
            ),

            data: (data) {
              final total = data.totalCost;

              final fuelPercent = total == 0 ? 0.0 : data.fuelCost / total;

              final servicePercent = total == 0
                  ? 0.0
                  : data.serviceCost / total;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet),

                      const SizedBox(width: 10),

                      Text(
                        "Přehled nákladů",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const Spacer(),

                      const Icon(Icons.chevron_right),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${total.toStringAsFixed(0)} Kč",

                          style: const TextStyle(
                            fontSize: 32,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Celkové náklady",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _item(
                          icon: Icons.local_gas_station,

                          title: "Palivo",

                          value: data.fuelCost,

                          color: Colors.green,
                        ),
                      ),

                      Expanded(
                        child: _item(
                          icon: Icons.build,

                          title: "Servis",

                          value: data.serviceCost,

                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child: SizedBox(
                      height: 10,

                      child: Row(
                        children: [
                          Expanded(
                            flex: (fuelPercent * 100).round(),

                            child: Container(color: Colors.green),
                          ),

                          Expanded(
                            flex: (servicePercent * 100).round(),

                            child: Container(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,

    required String title,

    required double value,

    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,

          backgroundColor: color.withOpacity(0.15),

          child: Icon(icon, color: color, size: 20),
        ),

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title, style: const TextStyle(fontSize: 13)),

            Text(
              "${value.toStringAsFixed(0)} Kč",

              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
