import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditReminderScreen extends ConsumerStatefulWidget {
  final int carId;
  final Reminder reminder;

  const EditReminderScreen({
    super.key,
    required this.carId,
    required this.reminder,
  });

  @override
  ConsumerState<EditReminderScreen> createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends ConsumerState<EditReminderScreen> {
  late TextEditingController kmController;

  late TextEditingController daysController;

  @override
  void initState() {
    super.initState();

    kmController = TextEditingController(
      text: widget.reminder.intervalKilometers?.toString() ?? "",
    );

    daysController = TextEditingController(
      text: widget.reminder.intervalDays?.toString() ?? "",
    );
  }

  void save() {
    final updated = Reminder(
      carId: widget.carId,

      type: widget.reminder.type,

      intervalKilometers: int.tryParse(kmController.text),

      intervalDays: int.tryParse(daysController.text),

      lastDate: widget.reminder.lastDate,

      lastKilometers: widget.reminder.lastKilometers,

      enabled: widget.reminder.enabled,
    );

    updated.id = widget.reminder.id;

    ref.read(reminderProvider.notifier).updateReminder(updated);

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upravit připomínku")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: kmController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Interval km"),
            ),

            TextField(
              controller: daysController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Interval dní"),
            ),

            const SizedBox(height: 20),

            FilledButton(onPressed: save, child: const Text("Uložit změny")),
          ],
        ),
      ),
    );
  }
}
