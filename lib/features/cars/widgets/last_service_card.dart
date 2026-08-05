import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastServiceCard extends ConsumerWidget {
  final int carId;

  const LastServiceCard({super.key, required this.carId});

  String _daysAgo(DateTime date) {
    final days = DateTime.now().difference(date).inDays;

    if (days == 0) return "Dnes";

    if (days == 1) return "Včera";

    if (days < 30) return "Před $days dny";

    final months = (days / 30).floor();

    if (months == 1) {
      return "Před měsícem";
    }

    if (months < 12) {
      return "Před $months měsíci";
    }

    final years = (months / 12).floor();

    if (years == 1) {
      return "Před rokem";
    }

    return "Před $years lety";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestService = ref.watch(latestServiceProvider(carId));

    return latestService.when(
      loading: () => _card(child: const Text("Načítání servisu...")),

      error: (_, _) => _card(child: const Text("Chyba načtení servisu")),

      data: (service) {
        if (service == null) {
          return _card(
            child: Row(
              children: [
                _iconBox(Icons.build),

                const SizedBox(width: 14),

                const Text(
                  "Žádný servis",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }

        return InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            context.push("/service/$carId/history");
          },

          child: _card(
            child: Row(
              children: [
                _iconBox(service.type.icon),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        service.displayName,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${service.date.day}."
                        "${service.date.month}."
                        "${service.date.year}"
                        " • ${service.kilometers} km",

                        style: TextStyle(
                          color: Colors.grey.shade600,

                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        _daysAgo(service.date),

                        style: TextStyle(
                          color: Colors.grey.shade500,

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(
                      "${service.price.toStringAsFixed(0)} Kč",

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Icon(Icons.chevron_right, size: 20),
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

  Widget _iconBox(IconData icon) {
    return Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: const Color(0xff7B6EF6),

        borderRadius: BorderRadius.circular(15),
      ),

      child: Icon(icon, color: Colors.white),
    );
  }
}
