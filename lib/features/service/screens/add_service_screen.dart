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

  final kilometresController = TextEditingController();

  final priceController = TextEditingController();

  final noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void saveService() {
    if (titleController.text.isEmpty ||
        kilometresController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vyplň všechna povinná pole")),
      );

      return;
    }

    final service = ServiceRecord(
      id: DateTime.now().toString(),

      carId: widget.carId,

      date: selectedDate,

      kilometers: int.tryParse(kilometresController.text) ?? 0,

      title: titleController.text,

      price: double.tryParse(priceController.text) ?? 0,

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
              controller: kilometresController,

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

            ListTile(
              leading: const Icon(Icons.calendar_month),

              title: Text(
                "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}",
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

            FilledButton(onPressed: saveService, child: const Text("Uložit")),
          ],
        ),
      ),
    );
  }
}
