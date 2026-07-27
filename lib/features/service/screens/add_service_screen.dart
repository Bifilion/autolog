import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
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

  ServiceType selectedType = ServiceType.oil;

  DateTime selectedDate = DateTime.now();
  bool reminderEnabled = true;

  Future<void> saveService() async {
    if (kilometresController.text.isEmpty ||
        priceController.text.isEmpty ||
        (selectedType == ServiceType.custom && titleController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vyplň všechna povinná pole")),
      );

      return;
    }

    final service = ServiceRecord(
      carId: int.parse(widget.carId),

      date: selectedDate,

      kilometers: int.tryParse(kilometresController.text) ?? 0,

      type: selectedType,

      title: titleController.text,

      price: double.tryParse(priceController.text) ?? 0,

      note: noteController.text,

      reminderEnabled: reminderEnabled,
    );
    await ref.read(serviceProvider.notifier).addService(service);

    if (service.reminderEnabled) {
      final reminder = Reminder(
        carId: service.carId,

        title: service.displayName,

        type: service.type.toReminderType(),

        intervalKilometers: 15000,

        lastKilometers: service.kilometers,

        lastDate: service.date,

        enabled: true,
      );

      ref.read(reminderProvider.notifier).addReminder(reminder);
    }

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Přidat servis")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<ServiceType>(
              value: selectedType,

              decoration: const InputDecoration(labelText: "Typ servisu"),

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
            ),
            if (selectedType == ServiceType.custom)
              TextField(
                controller: titleController,

                decoration: const InputDecoration(
                  labelText: "Název vlastního servisu",
                ),
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

            SwitchListTile(
              title: const Text("Vytvořit připomínku"),

              subtitle: const Text(
                "Automaticky vytvoří další servisní upozornění",
              ),

              value: reminderEnabled,

              onChanged: (value) {
                setState(() {
                  reminderEnabled = value;
                });
              },
            ),

            FilledButton(onPressed: saveService, child: const Text("Uložit")),
          ],
        ),
      ),
    );
  }
}
