import 'package:autolog/core/widgets/app_card.dart';
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

    return AppCard(
      onTap: () {
        context.push("/statistics/$carId");
      },

      padding: const EdgeInsets.all(16),

      child: statistics.when(
        loading: () => const SizedBox(
          height: 180,
          child: Center(child: CircularProgressIndicator()),
        ),

        error: (_, _) => const SizedBox(
          height: 180,
          child: Center(child: Text("Chyba načtení nákladů")),
        ),

        data: (data) {
          final total = data.totalCost.toDouble();

          final fuelPercent = total == 0
              ? 0.0
              : data.fuelCost.toDouble() / total;

          final servicePercent = total == 0
              ? 0.0
              : data.serviceCost.toDouble() / total;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  _iconBox(context, Icons.bar_chart_rounded),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      "Statistiky nákladů",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(Icons.chevron_right),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Celkové výdaje",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 4),

              Text(
                "${total.toStringAsFixed(0)} Kč",

                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              _costBar(
                context,
                icon: Icons.local_gas_station,
                title: "Palivo",
                value: data.fuelCost,
                percent: fuelPercent,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 18),

              _costBar(
                context,
                icon: Icons.build,
                title: "Servis",
                value: data.serviceCost,
                percent: servicePercent,
                color: Colors.orange,
              ),
              const SizedBox(height: 18),
            ],
          );
        },
      ),
    );
  }

  Widget _iconBox(BuildContext context, IconData icon) {
    return Container(
      width: 46,

      height: 46,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),

        borderRadius: BorderRadius.circular(14),
      ),

      child: Icon(icon, color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _costBar(
    BuildContext context, {

    required IconData icon,

    required String title,

    required double value,

    required double percent,

    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),

            const SizedBox(width: 8),

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
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: LinearProgressIndicator(
            value: percent,

            minHeight: 8,

            backgroundColor: Colors.grey.shade300,

            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
