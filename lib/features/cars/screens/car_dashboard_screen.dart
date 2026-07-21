import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/cars/widgets/dashboard_card.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarDashboardScreen extends ConsumerWidget {
  final String carId;

  const CarDashboardScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.read(carProvider.notifier).getCarById(carId);

    final fuelCost = ref.watch(totalFuelCostProvider(carId));

    final serviceCost = ref.watch(totalServiceCostProvider(carId));

    final totalCost = fuelCost + serviceCost;

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
              icon: Icons.attach_money,
              title: "Náklady",
              value:
                  "Palivo: ${fuelCost.toStringAsFixed(0)} Kč\n"
                  "Servis: ${serviceCost.toStringAsFixed(0)} Kč\n"
                  "Celkem: ${totalCost.toStringAsFixed(0)} Kč",
            ),
          ],
        ),
      ),
    );
  }
}
