import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/dashboard_header.dart';
import 'package:autolog/features/cars/widgets/last_fuel_card.dart';
import 'package:autolog/features/cars/widgets/last_service_card.dart';
import 'package:autolog/features/cars/widgets/quick_action_card.dart';
import 'package:autolog/features/cars/widgets/reminder_card.dart';
import 'package:autolog/features/statistics/widgets/cost_overview_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarDashboardScreen extends ConsumerWidget {
  final int carId;

  const CarDashboardScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carAsync = ref.watch(carByIdProvider(carId));

    return carAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),

      error: (error, stack) => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(title: const Text("Chyba")),
        body: Center(child: Text("Chyba: $error")),
      ),

      data: (car) {
        if (car == null) {
          return Scaffold(
            backgroundColor: AppTheme.background,
            appBar: AppBar(title: const Text("Auto nenalezeno")),
            body: const Center(child: Text("Auto nenalezeno")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text("${car.brand} ${car.model}")),

          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            children: [
              DashboardHeader(car: car),

              const SizedBox(height: 24),

              _sectionTitle("Rychlé akce"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.build,
                        title: "Servis",
                        onTap: () {
                          context.push('/service/$carId');
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.local_gas_station,
                        title: "Tankování",
                        onTap: () {
                          context.push('/fuel/$carId');
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.notifications,
                        title: "Připomínky",
                        onTap: () {
                          context.push('/reminder/$carId/add');
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ReminderCard(carId: carId, currentKilometers: car.kilometers),

              const SizedBox(height: 20),

              _sectionTitle("Poslední servis"),

              LastServiceCard(carId: carId),

              const SizedBox(height: 20),

              _sectionTitle("Poslední tankování"),

              LastFuelCard(carId: carId),

              const SizedBox(height: 20),

              CostOverviewCard(carId: carId),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      ),
    );
  }
}
