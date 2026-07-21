import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddFuelScreen extends ConsumerStatefulWidget {
  final String carId;

  const AddFuelScreen({super.key, required this.carId});

  @override
  ConsumerState<AddFuelScreen> createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends ConsumerState<AddFuelScreen> {
  final kilometresController = TextEditingController();

  final litersController = TextEditingController();

  final priceController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void saveFuel() {
    if (kilometresController.text.isEmpty ||
        litersController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vyplň všechna pole")));

      return;
    }

    final fuel = FuelRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),

      carId: widget.carId,

      date: selectedDate,

      kilometres: int.tryParse(kilometresController.text) ?? 0,

      liters: double.tryParse(litersController.text) ?? 0,

      price: double.tryParse(priceController.text) ?? 0,
    );

    ref.read(fuelProvider.notifier).addFuel(fuel);

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Přidat tankování")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: kilometresController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Stav kilometrů"),
            ),

            TextField(
              controller: litersController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(labelText: "Litry"),
            ),

            TextField(
              controller: priceController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(labelText: "Cena"),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),

              title: Text(
                "${selectedDate.day}."
                "${selectedDate.month}."
                "${selectedDate.year}",
              ),

              onTap: () async {
                final date = await showDatePicker(
                  context: context,

                  initialDate: selectedDate,

                  firstDate: DateTime(2000),

                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            FilledButton(onPressed: saveFuel, child: const Text("Uložit")),
          ],
        ),
      ),
    );
  }
}
