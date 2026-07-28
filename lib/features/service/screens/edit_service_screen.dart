import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditServiceScreen extends ConsumerStatefulWidget {
  final ServiceRecord service;

  const EditServiceScreen({super.key, required this.service});

  @override
  ConsumerState<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends ConsumerState<EditServiceScreen> {
  late final TextEditingController titleController;
  late final TextEditingController kilometresController;
  late final TextEditingController priceController;
  late final TextEditingController noteController;

  late ServiceType selectedType;
  late DateTime selectedDate;
  late bool reminderEnabled;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.service.title ?? "");

    kilometresController = TextEditingController(
      text: widget.service.kilometers.toString(),
    );

    priceController = TextEditingController(
      text: widget.service.price.toString(),
    );

    noteController = TextEditingController(text: widget.service.note);

    selectedType = widget.service.type;

    selectedDate = widget.service.date;

    reminderEnabled = widget.service.reminderEnabled;
  }

  Future<void> save() async {
    final updated = ServiceRecord(
      carId: widget.service.carId,

      date: selectedDate,

      kilometers: int.tryParse(kilometresController.text) ?? 0,

      type: selectedType,

      title: selectedType == ServiceType.custom ? titleController.text : null,

      price: double.tryParse(priceController.text) ?? 0,

      note: noteController.text,

      reminderEnabled: reminderEnabled,

      intervalKilometers: widget.service.intervalKilometers,

      intervalMonths: widget.service.intervalMonths,
    );

    updated.id = widget.service.id;

    await ref.read(serviceProvider.notifier).removeService(widget.service);

    await ref.read(serviceProvider.notifier).updateService(updated);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upravit servis")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<ServiceType>(
              initialValue: selectedType,

              items: ServiceType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.label));
              }).toList(),

              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedType = value;
                  });
                }
              },

              decoration: const InputDecoration(labelText: "Typ servisu"),
            ),

            if (selectedType == ServiceType.custom)
              TextField(
                controller: titleController,

                decoration: const InputDecoration(labelText: "Název servisu"),
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

            SwitchListTile(
              title: const Text("Připomínka"),

              value: reminderEnabled,

              onChanged: (value) {
                setState(() {
                  reminderEnabled = value;
                });
              },
            ),

            const SizedBox(height: 20),

            FilledButton(onPressed: save, child: const Text("Uložit změny")),
          ],
        ),
      ),
    );
  }
}
