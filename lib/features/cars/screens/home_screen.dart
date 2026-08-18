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
      appBar: AppBar(
        automaticallyImplyLeading: false,

        titleSpacing: 20,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AutoLog",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 2),

            const Text(
              "Moje garáž",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: "Nastavení",
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              context.push("/settings");
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: carsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text(error.toString())),

        data: (cars) {
          if (cars.isEmpty) {
            return const Center(child: Text("Nemáš žádné vozidlo"));
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),

            itemCount: cars.length,

            itemBuilder: (context, index) {
              final car = cars[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),

                child: CarCard(
                  car: car,

                  onTap: () {
                    context.push("/car/${car.id}");
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/add-car");
        },

        icon: const Icon(Icons.add_rounded),

        label: const Text("Přidat vozidlo"),
      ),
    );
  }
}
