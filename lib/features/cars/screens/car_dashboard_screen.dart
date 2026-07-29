import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/dashboard_header.dart';
import 'package:autolog/features/cars/widgets/last_service_card.dart';
import 'package:autolog/features/cars/widgets/quick_action_card.dart';
import 'package:autolog/features/cars/widgets/reminder_card.dart';
import 'package:autolog/features/cars/widgets/statistics_card.dart';
import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:autolog/features/expenses/providers/expense_stats_provider.dart';
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

    final fuelCost = ref.watch(
      expenseByTypeProvider((carId: carIdInt, type: ExpenseType.fuel)),
    );

    final serviceCost = ref.watch(
      expenseByTypeProvider((carId: carIdInt, type: ExpenseType.service)),
    );

    final otherCost = ref.watch(totalOtherCostProvider(carIdInt));

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

                const Text(
                  "Rychlé akce",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Row(
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

                    const SizedBox(width: 8),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.local_gas_station,
                        title: "Tankování",

                        onTap: () {
                          context.push('/fuel/$carId');
                        },
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.notifications,
                        title: "Připomínka",

                        onTap: () {
                          context.push('/reminder/$carId/add');
                        },
                      ),
                    ),
                  ],
                ),
                ReminderCard(
                  carId: carIdInt,
                  currentKilometers: car.kilometers,
                ),

                LastServiceCard(carId: carIdInt),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("Historie servisu"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push('/service/$carId/history');
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.payments),

                    title: const Text("Náklady"),

                    trailing: const Icon(Icons.chevron_right),

                    onTap: () {
                      context.push('/expenses/$carId/history');
                    },
                  ),
                ),

                StatisticsCard(
                  fuelCost: fuelCost.value ?? 0,
                  serviceCost: serviceCost.value ?? 0,
                  otherCost: otherCost.value ?? 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
