import 'package:autolog/features/fuel/providers/fuel_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastFuelCard extends ConsumerWidget {
  final int carId;

  const LastFuelCard({super.key, required this.carId});

  String _daysAgo(DateTime date) {
    final days = DateTime.now().difference(date).inDays;

    if (days == 0) return "Dnes";
    if (days == 1) return "Včera";
    if (days < 30) return "Před $days dny";

    final months = (days / 30).floor();

    if (months == 1) return "Před měsícem";

    if (months < 12) return "Před $months měsíci";

    final years = (months / 12).floor();

    if (years == 1) return "Před rokem";

    return "Před $years lety";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestFuel = ref.watch(latestFuelProvider(carId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          child: Text(
            "Poslední tankování",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
          child: latestFuel.when(
            loading: () => const ListTile(title: Text("Načítání...")),

            error: (_, _) => const ListTile(title: Text("Chyba načtení")),

            data: (fuel) {
              if (fuel == null) {
                return const ListTile(
                  leading: CircleAvatar(child: Icon(Icons.local_gas_station)),
                  title: Text("Žádné tankování"),
                );
              }

              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.local_gas_station),
                ),

                title: Text(
                  "${fuel.liters.toStringAsFixed(1)} l",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text(
                  "${fuel.date.day}.${fuel.date.month}.${fuel.date.year}"
                  " • ${fuel.kilometers} km\n"
                  "${fuel.pricePerLiter.toStringAsFixed(2)} Kč/l",
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${fuel.price.toStringAsFixed(0)} Kč",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Text(
                      _daysAgo(fuel.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                onTap: () {
                  context.push("/fuel/$carId");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
