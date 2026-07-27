import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddReminderScreen extends ConsumerStatefulWidget {
  final int carId;

  const AddReminderScreen({super.key, required this.carId});

  @override
  ConsumerState<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  ReminderType selectedType = ReminderType.oil;

  final intervalKmController = TextEditingController();

  final intervalDaysController = TextEditingController();

  final lastKmController = TextEditingController();

  final titleController = TextEditingController();

  DateTime? lastDate;

  Future<void> saveReminder() async {
    final reminder = Reminder(
      carId: widget.carId,

      type: selectedType,

      title: titleController.text.isEmpty
          ? selectedType.label
          : titleController.text,

      intervalKilometers: int.tryParse(intervalKmController.text),

      intervalDays: int.tryParse(intervalDaysController.text),

      lastKilometers: int.tryParse(lastKmController.text),

      lastDate: lastDate,
    );

    await ref.read(reminderProvider.notifier).addReminder(reminder);

    ref.invalidate(reminderProvider);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Přidat připomínku")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<ReminderType>(
              initialValue: selectedType,

              decoration: const InputDecoration(labelText: "Typ"),

              items: ReminderType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Row(
                        children: [
                          Icon(type.icon),

                          const SizedBox(width: 10),

                          Text(type.label),
                        ],
                      ),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedType = value;
                  });
                }
              },
            ),

            TextField(
              controller: intervalKmController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Interval km"),
            ),

            TextField(
              controller: intervalDaysController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Interval dní"),
            ),

            TextField(
              controller: lastKmController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Poslední km"),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),

              title: Text(
                lastDate == null
                    ? "Poslední datum"
                    : "${lastDate!.day}."
                          "${lastDate!.month}."
                          "${lastDate!.year}",
              ),

              onTap: () async {
                final date = await showDatePicker(
                  context: context,

                  initialDate: DateTime.now(),

                  firstDate: DateTime(2000),

                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  setState(() {
                    lastDate = date;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            FilledButton(onPressed: saveReminder, child: const Text("Uložit")),
          ],
        ),
      ),
    );
  }
}
