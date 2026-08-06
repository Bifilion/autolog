import 'package:autolog/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class StatisticsMetricCard extends StatelessWidget {
  final IconData icon;

  final String title;

  final String value;

  const StatisticsMetricCard({
    super.key,

    required this.icon,

    required this.title,

    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 40,

            height: 40,

            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.12),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,

              size: 22,

              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,

            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            title,

            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
