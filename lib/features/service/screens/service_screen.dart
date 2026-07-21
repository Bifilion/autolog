import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceScreen extends ConsumerWidget {
  final String carId;

  const ServiceScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carServices = ref
        .watch(serviceProvider)
        .where((service) => service.carId == carId)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Servis")),

      body: carServices.isEmpty
          ? const Center(child: Text("Zatím žádný servis"))
          : ListView.builder(
              itemCount: carServices.length,
              itemBuilder: (context, index) {
                final service = carServices[index];

                return ListTile(
                  leading: const Icon(Icons.build),
                  title: Text(service.title),
                  subtitle: Text(
                    "${service.kilometers} km\n${service.date.day}.${service.date.month}.${service.date.year}",
                  ),
                  trailing: Text("${service.price.toStringAsFixed(0)} Kč"),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/service/$carId/add');
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
