import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReminderScreen extends ConsumerWidget {
  final int carId;

  const ReminderScreen({super.key, required this.carId});

  Widget _iconBox(BuildContext context, IconData icon, Color color) {
    return Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Icon(icon, color: color),
    );
  }

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

                return aColor.toARGB32().compareTo(bColor.toARGB32());
              });

              if (list.isEmpty) {
                return const Center(child: Text("Žádné připomínky"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),

                itemCount: list.length,

                itemBuilder: (context, index) {
                  final reminder = list[index];

                  final color = reminder.statusColor(
                    car.kilometers,
                    DateTime.now(),
                  );

                  final km = reminder.kmStatus(car.kilometers);

                  final days = reminder.timeStatus(DateTime.now());

                  return AppCard(
                    margin: const EdgeInsets.only(bottom: 10),

                    child: Row(
                      children: [
                        _iconBox(context, reminder.type.icon, color),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                reminder.title ?? reminder.type.label,

                                style: const TextStyle(
                                  fontSize: 16,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              if (km.isNotEmpty)
                                Text(
                                  km,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),

                              if (days.isNotEmpty)
                                Text(
                                  days,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                            ],
                          ),
                        ),

                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert),

                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: "edit",

                              child: Row(
                                children: [
                                  Icon(Icons.edit),

                                  SizedBox(width: 10),

                                  Text("Upravit"),
                                ],
                              ),
                            ),

                            PopupMenuItem(
                              value: "delete",

                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline),

                                  SizedBox(width: 10),

                                  Text("Smazat"),
                                ],
                              ),
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
                      ],
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
