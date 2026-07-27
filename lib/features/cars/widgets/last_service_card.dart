import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastServiceCard extends ConsumerWidget {
  final int carId;

  const LastServiceCard({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestService = ref.watch(latestServiceProvider(carId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: latestService.when(
          data: (service) {
            if (service == null) {
              return const ListTile(
                leading: Icon(Icons.build),
                title: Text("Poslední servis"),
                subtitle: Text("Žádný záznam"),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.build),
                    const SizedBox(width: 10),
                    Text(
                      "Poslední servis",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  service.displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 8),

                Text("🚗 ${service.kilometers} km"),

                Text("💰 ${service.price.toStringAsFixed(0)} Kč"),

                Text(
                  "📅 "
                  "${service.date.day}."
                  "${service.date.month}."
                  "${service.date.year}",
                ),
              ],
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error, stack) => const ListTile(
            leading: Icon(Icons.error),
            title: Text("Chyba načtení servisu"),
          ),
        ),
      ),
    );
  }
}
