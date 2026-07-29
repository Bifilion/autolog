import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReminderCard extends ConsumerWidget {
  final int carId;
  final int currentKilometers;

  const ReminderCard({
    super.key,
    required this.carId,
    required this.currentKilometers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(reminderProvider);

    return Card(
      child: remindersAsync.when(
        loading: () => const ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Připomínky"),
          subtitle: Text("Načítání..."),
        ),

        error: (_, _) => const ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Připomínky"),
          subtitle: Text("Chyba načtení"),
        ),

        data: (reminders) {
          final list = reminders.where((r) => r.carId == carId).toList();

          Color statusColor = Colors.grey;

          if (list.isNotEmpty) {
            final colors = list.map(
              (r) => r.statusColor(currentKilometers, DateTime.now()),
            );

            if (colors.contains(Colors.red)) {
              statusColor = Colors.red;
            } else if (colors.contains(Colors.orange)) {
              statusColor = Colors.orange;
            } else {
              statusColor = Colors.green;
            }
          }

          return ListTile(
            leading: const Icon(Icons.notifications),

            title: const Text("Připomínky"),

            subtitle: Text(
              list.isEmpty
                  ? "Žádné aktivní připomínky"
                  : "${list.length} aktivních připomínek",
            ),

            trailing: CircleAvatar(radius: 10, backgroundColor: statusColor),

            onTap: () {
              context.push("/reminder/$carId");
            },
          );
        },
      ),
    );
  }
}
