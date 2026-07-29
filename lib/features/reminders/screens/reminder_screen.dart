import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReminderScreen extends ConsumerWidget {
  final int carId;

  const ReminderScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(reminderProvider);

    final carAsync = ref.watch(carByIdProvider(carId));

    return Scaffold(
      appBar: AppBar(title: const Text("Připomínky")),

      body: carAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (_, _) => const Center(child: Text("Chyba načtení auta")),

        data: (car) {
          if (car == null) {
            return const Center(child: Text("Auto nenalezeno"));
          }

          return remindersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),

            error: (_, _) =>
                const Center(child: Text("Chyba načtení připomínek")),

            data: (reminders) {
              final list = reminders.where((r) => r.carId == carId).toList();

              list.sort((a, b) {
                final aColor = a.statusColor(car.kilometers, DateTime.now());

                final bColor = b.statusColor(car.kilometers, DateTime.now());

                return aColor.value.compareTo(bColor.value);
              });

              if (list.isEmpty) {
                return const Center(child: Text("Žádné připomínky"));
              }

              return ListView.builder(
                itemCount: list.length,

                itemBuilder: (context, index) {
                  final reminder = list[index];

                  final color = reminder.statusColor(
                    car.kilometers,
                    DateTime.now(),
                  );

                  final km = reminder.kmStatus(car.kilometers);

                  final days = reminder.timeStatus(DateTime.now());

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    child: ListTile(
                      leading: Icon(reminder.type.icon, color: color),

                      title: Text(reminder.title ?? reminder.type.label),

                      subtitle: Text(
                        [km, days].where((e) => e.isNotEmpty).join("\n"),
                      ),

                      trailing: PopupMenuButton(
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: "edit", child: Text("Upravit")),

                          PopupMenuItem(value: "delete", child: Text("Smazat")),
                        ],

                        onSelected: (value) async {
                          if (value == "edit") {
                            context.push("/reminder/edit", extra: reminder);
                          }

                          if (value == "delete") {
                            final confirm = await showDialog<bool>(
                              context: context,

                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Smazat připomínku?"),

                                  content: Text(
                                    reminder.title ?? reminder.type.label,
                                  ),

                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },

                                      child: const Text("Zrušit"),
                                    ),

                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },

                                      child: const Text("Smazat"),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm == true) {
                              await ref
                                  .read(reminderProvider.notifier)
                                  .removeReminder(reminder);
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
