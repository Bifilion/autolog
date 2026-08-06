import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
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
  late ReminderType selectedType;

  late final TextEditingController titleController;
  late final TextEditingController kmController;
  late final TextEditingController daysController;

  @override
  void initState() {
    super.initState();

    selectedType = widget.reminder.type;

    titleController = TextEditingController(text: widget.reminder.title ?? "");

    kmController = TextEditingController(
      text: widget.reminder.intervalKilometers?.toString() ?? "",
    );

    daysController = TextEditingController(
      text: widget.reminder.intervalDays?.toString() ?? "",
    );
  }

  Future<void> save() async {
    final updated = Reminder(
      carId: widget.carId,

      type: selectedType,

      title: titleController.text.isEmpty
          ? selectedType.label
          : titleController.text,

      intervalKilometers: int.tryParse(kmController.text),

      intervalDays: int.tryParse(daysController.text),

      lastDate: widget.reminder.lastDate,

      lastKilometers: widget.reminder.lastKilometers,

      enabled: widget.reminder.enabled,
    );

    updated.id = widget.reminder.id;

    await ref.read(reminderProvider.notifier).updateReminder(updated);

    if (mounted) {
      context.pop();
    }
  }

  Widget _fieldCard({required Widget child}) {
    return AppCard(
      margin: EdgeInsets.zero,

      padding: const EdgeInsets.all(12),

      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upravit připomínku")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [
              _fieldCard(
                child: DropdownButtonFormField<ReminderType>(
                  value: selectedType,

                  decoration: const InputDecoration(
                    labelText: "Typ připomínky",

                    prefixIcon: Icon(Icons.notifications),
                  ),

                  items: ReminderType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,

                      child: Row(
                        children: [
                          Icon(type.icon),

                          const SizedBox(width: 10),

                          Text(type.label),
                        ],
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedType = value;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              _fieldCard(
                child: TextField(
                  controller: titleController,

                  decoration: const InputDecoration(
                    labelText: "Název připomínky",

                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _fieldCard(
                child: TextField(
                  controller: kmController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: "Interval kilometrů",

                    prefixIcon: Icon(Icons.speed),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _fieldCard(
                child: TextField(
                  controller: daysController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: "Interval dní",

                    prefixIcon: Icon(Icons.calendar_month),
                  ),
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
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();

    kmController.dispose();

    daysController.dispose();

    super.dispose();
  }
}
