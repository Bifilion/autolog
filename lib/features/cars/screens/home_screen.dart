import 'package:autolog/features/cars/providers/car_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(carProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Moje auta')),
      body: cars.isEmpty
          ? const Center(child: Text("Nemáš žádné auto"))
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Card(
                  child: ListTile(
                    title: Text("${car.brand} ${car.model}"),
                    subtitle: Text("${car.year} • ${car.kilometers} km"),
                    onTap: () {
                      context.push('/car/${car.id}');
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-car');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
