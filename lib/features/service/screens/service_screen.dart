import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/core/widgets/app_card.dart';
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
      backgroundColor: AppTheme.background,

      appBar: AppBar(title: const Text("Servis")),

      body: servicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text("Chyba: $error")),

        data: (allServices) {
          final carServices = allServices
              .where((service) => service.carId == int.parse(carId))
              .toList();

          if (carServices.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),

              child: AppCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      width: 60,

                      height: 60,

                      decoration: BoxDecoration(
                        color: const Color(0xff7B6EF6).withOpacity(.15),

                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.build_rounded,

                        size: 32,

                        color: Color(0xff7B6EF6),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Žádný servis",

                      style: TextStyle(
                        fontSize: 18,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Přidej první servisní záznam",

                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

            itemCount: carServices.length,

            separatorBuilder: (_, __) => const SizedBox(height: 10),

            itemBuilder: (context, index) {
              final service = carServices[index];

              return ServiceCard(service: service);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff7B6EF6),

        foregroundColor: Colors.white,

        onPressed: () {
          context.push('/service/$carId/add');
        },

        icon: const Icon(Icons.add),

        label: const Text("Servis"),
      ),
    );
  }
}
