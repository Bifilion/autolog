import 'package:autolog/features/cars/models/car.dart';
import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${car.brand} ${car.model}")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${car.year}", style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 10),

            Text(
              "${car.kilometers} km",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.build),
                title: const Text("Servis"),
                subtitle: const Text("0 záznamů"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.local_gas_station),
                title: const Text("Tankování"),
                subtitle: const Text("0 záznamů"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text("Náklady"),
                subtitle: const Text("0 Kč"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
