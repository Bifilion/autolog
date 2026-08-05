import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/car_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsState = ref.watch(carProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Moje garáž")),

      body: carsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text(error.toString())),

        data: (cars) {
          if (cars.isEmpty) {
            return const Center(child: Text("Nemáš žádné vozidlo"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),

            itemCount: cars.length,

            itemBuilder: (context, index) {
              final car = cars[index];

              return CarCard(
                car: car,

                onTap: () {
                  context.push("/car/${car.id}");
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/add-car");
        },

        icon: const Icon(Icons.add),

        label: const Text("Přidat vozidlo"),
      ),
    );
  }
}
