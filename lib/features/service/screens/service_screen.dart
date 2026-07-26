import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:autolog/features/service/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceScreen extends ConsumerWidget {
  final String carId;

  const ServiceScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(serviceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Servis")),

      body: servicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text("Chyba: $error")),

        data: (allServices) {
          final carServices = allServices
              .where((service) => service.carId == int.parse(carId))
              .toList();

          return carServices.isEmpty
              ? const Center(child: Text("Zatím žádný servis"))
              : ListView.builder(
                  itemCount: carServices.length,

                  itemBuilder: (context, index) {
                    final service = carServices[index];

                    return ServiceCard(service: service);
                  },
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
