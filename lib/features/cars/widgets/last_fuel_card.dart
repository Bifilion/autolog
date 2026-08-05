import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/fuel/providers/fuel_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastFuelCard extends ConsumerWidget {
  final int carId;

  const LastFuelCard({super.key, required this.carId});

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
    final latestFuel = ref.watch(latestFuelProvider(carId));

    return latestFuel.when(
      loading: () => _card(child: const Text("Načítání tankování...")),

      error: (_, _) => _card(child: const Text("Chyba načtení tankování")),

      data: (fuel) {
        if (fuel == null) {
          return _card(
            child: Row(
              children: [
                _iconBox(),

                const SizedBox(width: 14),

                const Text(
                  "Žádné tankování",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }

        return InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            context.push("/fuel/$carId");
          },

          child: _card(
            child: Row(
              children: [
                _iconBox(),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "${fuel.liters.toStringAsFixed(1)} l",

                        style: const TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${fuel.date.day}."
                        "${fuel.date.month}."
                        "${fuel.date.year}"
                        " • ${fuel.kilometers} km",

                        style: TextStyle(
                          color: Colors.grey.shade600,

                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${fuel.pricePerLiter.toStringAsFixed(2)} Kč/l"
                        " • ${_daysAgo(fuel.date)}",

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
                      "${fuel.price.toStringAsFixed(0)} Kč",

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

  Widget _iconBox() {
    return Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: const Color(0xff7B6EF6),

        borderRadius: BorderRadius.circular(15),
      ),

      child: const Icon(
        Icons.local_gas_station_rounded,

        color: Colors.white,

        size: 24,
      ),
    );
  }
}
