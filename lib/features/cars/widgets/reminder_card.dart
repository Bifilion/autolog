import 'package:autolog/core/widgets/app_card.dart';
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

    return remindersAsync.when(
      loading: () => _card(child: const Text("Načítání připomínek...")),

      error: (_, _) => _card(child: const Text("Chyba načtení připomínek")),

      data: (reminders) {
        final list = reminders
            .where((r) => r.carId == carId && r.enabled)
            .toList();

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

        return InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            context.push("/reminder/$carId");
          },

          child: _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    _iconBox(),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Text(
                        "Připomínky",

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Icon(Icons.chevron_right),
                  ],
                ),

                const SizedBox(height: 18),

                Text(
                  list.isEmpty
                      ? "Žádné aktivní připomínky"
                      : "${list.length} aktivních připomínek",

                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      width: 10,

                      height: 10,

                      decoration: BoxDecoration(
                        color: statusColor,

                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      _statusText(statusColor),

                      style: TextStyle(
                        color: statusColor,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _card({required Widget child}) {
    return AppCard(child: child);
  }

  Widget _iconBox() {
    return Container(
      width: 46,

      height: 46,

      decoration: BoxDecoration(
        color: const Color(0xff7B6EF6),

        borderRadius: BorderRadius.circular(15),
      ),

      child: const Icon(
        Icons.notifications_active_rounded,

        color: Colors.white,
      ),
    );
  }

  String _statusText(Color color) {
    if (color == Colors.red) {
      return "Vyžaduje pozornost";
    }

    if (color == Colors.orange) {
      return "Blíží se termín";
    }

    if (color == Colors.green) {
      return "Vše v pořádku";
    }

    return "Bez připomínek";
  }
}
