import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final kilometersController = TextEditingController();

  void saveCar() {
    final car = Car(
      id: DateTime.now().toString(),
      brand: brandController.text,
      model: modelController.text,
      year: int.parse(yearController.text),
      kilometers: int.parse(kilometersController.text),
    );

    ref.read(carProvider.notifier).addCar(car);

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Přidat auto")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: "Značka"),
            ),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: "Model"),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: "Rok výroby"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kilometersController,
              decoration: const InputDecoration(labelText: "Nájezd km"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: saveCar, child: const Text("Uložit auto")),
          ],
        ),
      ),
    );
  }
}
