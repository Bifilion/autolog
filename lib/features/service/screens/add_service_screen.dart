import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddServiceScreen extends ConsumerStatefulWidget {
  final String carId;

  const AddServiceScreen({super.key, required this.carId});

  @override
  ConsumerState<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends ConsumerState<AddServiceScreen> {
  final titleController = TextEditingController();

  final mileageController = TextEditingController();

  final priceController = TextEditingController();

  final noteController = TextEditingController();

  void saveService() {
    final service = ServiceRecord(
      id: DateTime.now().toString(),

      carId: widget.carId,

      date: DateTime.now(),

      kilometers: int.parse(mileageController.text),

      title: titleController.text,

      price: double.parse(priceController.text),

      note: noteController.text,
    );

    ref.read(serviceProvider.notifier).addService(service);

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Přidat servis")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              decoration: const InputDecoration(labelText: "Název"),
            ),

            TextField(
              controller: mileageController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Kilometry"),
            ),

            TextField(
              controller: priceController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Cena"),
            ),

            TextField(
              controller: noteController,

              decoration: const InputDecoration(labelText: "Poznámka"),
            ),

            const SizedBox(height: 20),

            FilledButton(onPressed: saveService, child: const Text("Uložit")),
          ],
        ),
      ),
    );
  }
}
