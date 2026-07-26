import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/dashboard_card.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_stats_provider.dart'
    hide totalServiceCostProvider;
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

    final fuelCost = ref.watch(totalFuelCostProvider(int.parse(carId)));

    final serviceCost = ref.watch(totalServiceCostProvider(int.parse(carId)));

    // final totalCost = (fuelCost.value ?? 0) + (serviceCost.value ?? 0);

    final latestService = ref.watch(latestServiceProvider(int.parse(carId)));

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
                Text(
                  "${car.year}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Nájezd: ${car.kilometers} km",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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

                DashboardCard(
                  icon: Icons.notifications,
                  title: "Připomínky",
                  value: "Žádné záznamy",
                ),

                DashboardCard(
                  icon: Icons.build,
                  title: "Poslední servis",
                  value: latestService.when(
                    data: (service) =>
                        service == null ? "Žádný záznam" : service.type.label,

                    loading: () => "Načítám...",

                    error: (_, _) => "Chyba načtení",
                  ),
                ),

                DashboardCard(
                  icon: Icons.attach_money,
                  title: "Náklady",
                  value:
                      "Palivo: ${(fuelCost.value ?? 0).toStringAsFixed(0)} Kč\n"
                      "Servis: ${(serviceCost.value ?? 0).toStringAsFixed(0)} Kč\n"
                      "Celkem: ${((fuelCost.value ?? 0) + (serviceCost.value ?? 0)).toStringAsFixed(0)} Kč",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
