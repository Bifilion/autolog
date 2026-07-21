import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FuelScreen extends ConsumerWidget {
  final String carId;

  const FuelScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuels = ref
        .watch(fuelProvider)
        .where((fuel) => fuel.carId == carId)
        .toList();

    final consumption = ref
        .read(fuelProvider.notifier)
        .calculateConsumption(carId);

    return Scaffold(
      appBar: AppBar(title: const Text("Tankování")),

      body: Column(
        children: [
          if (fuels.length >= 2)
            Card(
              margin: const EdgeInsets.all(12),

              child: ListTile(
                leading: const Icon(Icons.speed),

                title: const Text("Průměrná spotřeba"),

                subtitle: Text("${consumption.toStringAsFixed(1)} l / 100 km"),
              ),
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
                            "${fuel.kilometres} km\n"
                            "${fuel.date.day}.${fuel.date.month}.${fuel.date.year}",
                          ),

                          trailing: Text("${fuel.price.toStringAsFixed(0)} Kč"),
                        ),
                      );
                    },
                  ),
          ),
        ],
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
