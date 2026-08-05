import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/features/expenses/models/expense.dart';
import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
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
  final kilometersController = TextEditingController();

  final litersController = TextEditingController();

  final priceController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> saveFuel() async {
    if (kilometersController.text.isEmpty ||
        litersController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vyplň všechna pole")));

      return;
    }

    final fuel = FuelRecord(
      carId: int.parse(widget.carId),

      date: selectedDate,

      kilometers: int.tryParse(kilometersController.text) ?? 0,

      liters: double.tryParse(litersController.text) ?? 0,

      price: double.tryParse(priceController.text) ?? 0,
    );

    await ref.read(fuelProvider.notifier).addFuel(fuel);

    await ref
        .read(expenseProvider.notifier)
        .addExpense(
          Expense(
            carId: fuel.carId,

            date: fuel.date,

            amount: fuel.price,

            type: ExpenseType.fuel,

            title: "Tankování",
          ),
        );

    if (mounted) {
      context.pop();
    }
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: TextField(
        controller: controller,

        keyboardType: keyboardType,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(title: const Text("Přidat tankování")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _inputField(
              controller: kilometersController,

              label: "Stav kilometrů",

              keyboardType: TextInputType.number,

              icon: Icons.speed,
            ),

            _inputField(
              controller: litersController,

              label: "Litry",

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              icon: Icons.local_gas_station,
            ),

            _inputField(
              controller: priceController,

              label: "Cena",

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              icon: Icons.payments,
            ),

            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListTile(
                leading: const Icon(Icons.calendar_month),

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

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: FilledButton(
                onPressed: saveFuel,

                child: const Text("Uložit tankování"),
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
