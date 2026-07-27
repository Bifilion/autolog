import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/dashboard_header.dart';
import 'package:autolog/features/cars/widgets/last_fuel_card.dart';
import 'package:autolog/features/cars/widgets/last_service_card.dart';
import 'package:autolog/features/cars/widgets/reminder_card.dart';
import 'package:autolog/features/cars/widgets/statistics_card.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarDashboardScreen extends ConsumerWidget {
  final String carId;

  const CarDashboardScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carIdInt = int.parse(carId);

    final carFuture = ref.read(carProvider.notifier).getCarById(carIdInt);

    final fuelCost = ref.watch(totalFuelCostProvider(carIdInt));

    final serviceCost = ref.watch(totalServiceCostProvider(carIdInt));

    return FutureBuilder(
      future: carFuture,

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final car = snapshot.data;

        if (car == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Auto nenalezeno")),

            body: const Center(child: Text("Auto nenalezeno")),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text("${car.brand} ${car.model}")),

          body: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                DashboardHeader(car: car),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.build),

                    title: const Text("Servis"),

                    subtitle: const Text("Žádné záznamy"),

                    onTap: () {
                      context.push('/service/$carId');
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.local_gas_station),

                    title: const Text("Tankování"),

                    subtitle: const Text("Žádná data"),

                    onTap: () {
                      context.push('/fuel/$carId');
                    },
                  ),
                ),
                LastFuelCard(carId: carIdInt),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text("Připomínky"),

                    onTap: () {
                      context.push('/reminder/$carId/add');
                    },
                  ),
                ),
                ReminderCard(carId: int.parse(carId)),

                LastServiceCard(carId: carIdInt),

                StatisticsCard(
                  fuelCost: fuelCost.value ?? 0,
                  serviceCost: serviceCost.value ?? 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
