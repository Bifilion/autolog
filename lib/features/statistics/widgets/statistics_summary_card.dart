import 'package:autolog/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class StatisticsSummaryCard extends StatelessWidget {
  final double total;
  final double fuel;
  final double service;

  const StatisticsSummaryCard({
    super.key,
    required this.total,
    required this.fuel,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final double fuelPercent = total == 0 ? 0.0 : fuel / total;

    final double servicePercent = total == 0 ? 0.0 : service / total;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 48,

                height: 48,

                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.15),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Icon(
                  Icons.analytics_rounded,

                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Text(
                  "Celkové náklady",

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            "${total.toStringAsFixed(0)} Kč",

            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          _costRow(
            title: "Palivo",

            value: fuel,

            percent: fuelPercent,

            icon: Icons.local_gas_station,

            color: Colors.amber,
          ),

          const SizedBox(height: 16),

          _costRow(
            title: "Servis",

            value: service,

            percent: servicePercent,

            icon: Icons.build,

            color: Colors.lightBlue,
          ),
        ],
      ),
    );
  }

  Widget _costRow({
    required String title,

    required double value,

    required double percent,

    required IconData icon,

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
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: LinearProgressIndicator(
            minHeight: 8,

            value: percent,

            backgroundColor: Colors.grey.withValues(alpha: 0.15),

            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
