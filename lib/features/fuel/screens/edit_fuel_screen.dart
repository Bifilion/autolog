import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditFuelScreen extends ConsumerStatefulWidget {
  final FuelRecord fuel;

  const EditFuelScreen({super.key, required this.fuel});

  @override
  ConsumerState<EditFuelScreen> createState() => _EditFuelScreenState();
}

class _EditFuelScreenState extends ConsumerState<EditFuelScreen> {
  late final TextEditingController kilometersController;
  late final TextEditingController litersController;
  late final TextEditingController priceController;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    kilometersController = TextEditingController(
      text: widget.fuel.kilometers.toString(),
    );

    litersController = TextEditingController(
      text: widget.fuel.liters.toString(),
    );

    priceController = TextEditingController(text: widget.fuel.price.toString());

    selectedDate = widget.fuel.date;
  }

  Future<void> save() async {
    final updated = FuelRecord(
      carId: widget.fuel.carId,

      date: selectedDate,

      kilometers: int.tryParse(kilometersController.text) ?? 0,

      liters: double.tryParse(litersController.text) ?? 0,

      price: double.tryParse(priceController.text) ?? 0,
    );

    updated.id = widget.fuel.id;

    await ref.read(fuelProvider.notifier).updateFuel(updated);

    if (mounted) {
      context.pop();
    }
  }

  Widget _iconBox(BuildContext context, IconData icon) {
    return Container(
      width: 42,

      height: 42,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upravit tankování")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: kilometersController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Stav kilometrů",

                prefixIcon: Icon(Icons.speed),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: litersController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Litry",

                prefixIcon: Icon(Icons.local_gas_station),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: priceController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Cena",

                prefixIcon: Icon(Icons.payments),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: _iconBox(context, Icons.calendar_month),

                title: const Text("Datum tankování"),

                subtitle: Text(
                  "${selectedDate.day}."
                  "${selectedDate.month}."
                  "${selectedDate.year}",
                ),

                trailing: const Icon(Icons.edit),

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
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: FilledButton(
                onPressed: save,

                child: const Text("Uložit změny"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    kilometersController.dispose();

    litersController.dispose();

    priceController.dispose();

    super.dispose();
  }
}
