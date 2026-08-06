import 'package:autolog/core/widgets/app_card.dart';
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

  final titleController = TextEditingController();
  final intervalKmController = TextEditingController();
  final intervalDaysController = TextEditingController();
  final lastKmController = TextEditingController();

  DateTime? lastDate;

  bool useKilometers = false;
  bool useTime = false;

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
      appBar: AppBar(title: const Text("Přidat připomínku")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<ReminderType>(
              initialValue: selectedType,

              decoration: const InputDecoration(
                labelText: "Typ připomínky",
                prefixIcon: Icon(Icons.notifications_active),
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

            const SizedBox(height: 16),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Vlastní název (volitelné)",
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: SwitchListTile(
                value: useKilometers,

                secondary: _iconBox(context, Icons.speed),

                title: const Text("Hlídat podle kilometrů"),

                onChanged: (value) {
                  setState(() {
                    useKilometers = value;
                  });
                },
              ),
            ),

            if (useKilometers) ...[
              const SizedBox(height: 16),

              TextField(
                controller: intervalKmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Interval (km)",
                  prefixIcon: Icon(Icons.route),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: lastKmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Poslední stav kilometrů",
                  prefixIcon: Icon(Icons.speed),
                ),
              ),
            ],

            const SizedBox(height: 20),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: SwitchListTile(
                value: useTime,

                secondary: _iconBox(context, Icons.calendar_month),

                title: const Text("Hlídat podle času"),

                onChanged: (value) {
                  setState(() {
                    useTime = value;
                  });
                },
              ),
            ),

            if (useTime) ...[
              const SizedBox(height: 16),

              TextField(
                controller: intervalDaysController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Interval (dny)",
                  prefixIcon: Icon(Icons.schedule),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                child: ListTile(
                  leading: _iconBox(context, Icons.calendar_today),

                  title: const Text("Poslední datum"),

                  subtitle: Text(
                    lastDate == null
                        ? "Nevybráno"
                        : "${lastDate!.day}.${lastDate!.month}.${lastDate!.year}",
                  ),

                  trailing: const Icon(Icons.edit),

                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: lastDate ?? DateTime.now(),
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
              ),
            ],

            const SizedBox(height: 30),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: FilledButton(
                onPressed: saveReminder,

                child: const Text("Uložit připomínku"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveReminder() async {
    if (!useKilometers && !useTime) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Zapni alespoň jeden způsob hlídání")),
      );

      return;
    }

    if (useKilometers && intervalKmController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vyplň interval kilometrů")));

      return;
    }

    if (useTime && intervalDaysController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vyplň interval dní")));

      return;
    }

    final reminder = Reminder(
      carId: widget.carId,

      type: selectedType,

      title: titleController.text.trim().isEmpty
          ? selectedType.label
          : titleController.text.trim(),

      intervalKilometers: useKilometers
          ? int.tryParse(intervalKmController.text)
          : null,

      intervalDays: useTime ? int.tryParse(intervalDaysController.text) : null,

      lastKilometers: useKilometers
          ? int.tryParse(lastKmController.text)
          : null,

      lastDate: useTime ? lastDate : null,

      enabled: true,
    );

    await ref.read(reminderProvider.notifier).addReminder(reminder);

    ref.invalidate(reminderProvider);

    if (mounted) {
      context.pop();
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    intervalKmController.dispose();

    intervalDaysController.dispose();

    lastKmController.dispose();

    super.dispose();
  }
}
