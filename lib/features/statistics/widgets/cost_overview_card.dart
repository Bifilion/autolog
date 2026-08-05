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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff7B6EF6), Color(0xff5E4FE0)],
        ),
      ),

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

          final servicePercent = total == 0 ? 0.0 : data.serviceCost / total;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Text(
                      "Přehled nákladů",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),

              const SizedBox(height: 26),

              // TOTAL COST
              Text(
                "${total.toStringAsFixed(0)} Kč",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Celkové náklady",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 30),

              // FUEL
              _costBar(
                icon: Icons.local_gas_station,
                title: "Palivo",
                value: data.fuelCost,
                percent: fuelPercent,
                color: Colors.amberAccent,
              ),

              const SizedBox(height: 20),

              // SERVICE
              _costBar(
                icon: Icons.build,
                title: "Servis",
                value: data.serviceCost,
                percent: servicePercent,
                color: Colors.lightBlueAccent,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _costBar({
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
            Icon(icon, size: 20, color: Colors.white),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            Text(
              "${value.toStringAsFixed(0)} Kč",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              "${(percent * 100).round()} %",
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 8,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
