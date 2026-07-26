import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FuelScreen extends ConsumerWidget {
  final String carId;

  const FuelScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuelAsync = ref.watch(fuelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Tankování")),

      body: fuelAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text("Chyba: $error")),

        data: (allFuels) {
          final fuels = allFuels
              .where((fuel) => fuel.carId == int.parse(carId))
              .toList();

          return Column(
            children: [
              if (fuels.length >= 2)
                FutureBuilder<double>(
                  future: ref
                      .read(fuelProvider.notifier)
                      .calculateConsumption(int.parse(carId)),

                  builder: (context, snapshot) {
                    final consumption = snapshot.data ?? 0;

                    return Card(
                      margin: const EdgeInsets.all(12),

                      child: ListTile(
                        leading: const Icon(Icons.speed),

                        title: const Text("Průměrná spotřeba"),

                        subtitle: Text(
                          "${consumption.toStringAsFixed(1)} l / 100 km",
                        ),
                      ),
                    );
                  },
                ),

              Expanded(
                child: fuels.isEmpty
                    ? const Center(child: Text("Zatím žádné tankování"))
                    : ListView.builder(
                        itemCount: fuels.length,

                        itemBuilder: (context, index) {
                          final fuel = fuels[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            child: ListTile(
                              leading: const Icon(Icons.local_gas_station),

                              title: Text("${fuel.liters} litrů"),

                              subtitle: Text(
                                "${fuel.kilometers} km\n"
                                "${fuel.date.day}."
                                "${fuel.date.month}."
                                "${fuel.date.year}",
                              ),

                              trailing: Text(
                                "${fuel.price.toStringAsFixed(0)} Kč",
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/fuel/$carId/add');
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
