import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  final double fuelCost;
  final double serviceCost;
  final double otherCost;

  const StatisticsCard({
    super.key,
    required this.fuelCost,
    required this.serviceCost,
    required this.otherCost,
  });

  @override
  Widget build(BuildContext context) {
    final total = fuelCost + serviceCost + otherCost;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Statistiky", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 16),

            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text("Palivo"),
              trailing: Text("${fuelCost.toStringAsFixed(0)} Kč"),
            ),

            ListTile(
              leading: const Icon(Icons.build),
              title: const Text("Servis"),
              trailing: Text("${serviceCost.toStringAsFixed(0)} Kč"),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Celkem"),
              trailing: Text(
                "${total.toStringAsFixed(0)} Kč",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Ostatní"),
              trailing: Text("${otherCost.toStringAsFixed(0)} Kč"),
            ),
          ],
        ),
      ),
    );
  }
}
