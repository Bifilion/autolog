import 'package:autolog/features/fuel/providers/fuel_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastFuelCard extends ConsumerWidget {
  final int carId;

  const LastFuelCard({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestFuel = ref.watch(latestFuelProvider(carId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: latestFuel.when(
          data: (fuel) {
            if (fuel == null) {
              return const ListTile(
                leading: Icon(Icons.local_gas_station),
                title: Text("Poslední tankování"),
                subtitle: Text("Žádný záznam"),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    const Icon(Icons.local_gas_station),

                    const SizedBox(width: 10),

                    Text(
                      "Poslední tankování",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text("⛽ ${fuel.liters.toStringAsFixed(1)} litrů"),

                Text("💰 ${fuel.price.toStringAsFixed(0)} Kč"),

                Text("💵 ${fuel.pricePerLiter.toStringAsFixed(2)} Kč/l"),

                Text("🚗 ${fuel.kilometers} km"),

                Text(
                  "📅 "
                  "${fuel.date.day}."
                  "${fuel.date.month}."
                  "${fuel.date.year}",
                ),
              ],
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error, stack) => const ListTile(
            leading: Icon(Icons.error),

            title: Text("Chyba načtení tankování"),
          ),
        ),
      ),
    );
  }
}
