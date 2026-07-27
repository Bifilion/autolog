import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReminderCard extends ConsumerWidget {
  final int carId;

  const ReminderCard({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(reminderProvider);

    final carAsync = ref.watch(carByIdProvider(carId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                const Icon(Icons.notifications),

                const SizedBox(width: 10),

                Text(
                  "Připomínky",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const SizedBox(height: 12),

            carAsync.when(
              loading: () => const CircularProgressIndicator(),

              error: (_, _) => const Text("Chyba načtení auta"),

              data: (car) {
                if (car == null) {
                  return const Text("Auto nenalezeno");
                }

                return remindersAsync.when(
                  loading: () => const CircularProgressIndicator(),

                  error: (_, _) => const Text("Chyba načtení připomínek"),

                  data: (reminders) {
                    final list = reminders
                        .where((r) => r.carId == carId)
                        .toList();

                    if (list.isEmpty) {
                      return const Text("Žádné připomínky");
                    }

                    list.sort((a, b) {
                      final aColor = a.statusColor(
                        car.kilometers,
                        DateTime.now(),
                      );

                      final bColor = b.statusColor(
                        car.kilometers,
                        DateTime.now(),
                      );

                      return aColor.value.compareTo(bColor.value);
                    });

                    return Column(
                      children: list.map((reminder) {
                        final km = reminder.kmStatus(car.kilometers);

                        final days = reminder.timeStatus(DateTime.now());

                        return ListTile(
                          leading: Icon(
                            reminder.type.icon,

                            color: reminder.statusColor(
                              car.kilometers,
                              DateTime.now(),
                            ),
                          ),

                          title: Text(reminder.title ?? reminder.type.label),

                          subtitle: Text(
                            [km, days].where((e) => e.isNotEmpty).join("\n"),
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "edit",
                                child: Text("Upravit"),
                              ),
                              const PopupMenuItem(
                                value: "delete",
                                child: Text("Smazat"),
                              ),
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

                                      content: Text(reminder.type.label),

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
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
