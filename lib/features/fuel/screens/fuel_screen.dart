import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FuelScreen extends ConsumerWidget {
  final String carId;

  const FuelScreen({super.key, required this.carId});

  Widget _iconBox(BuildContext context, IconData icon) {
    return Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),

        borderRadius: BorderRadius.circular(15),
      ),

      child: Icon(icon, color: Theme.of(context).colorScheme.primary),
    );
  }

  Future<void> _deleteFuel(
    BuildContext context,
    WidgetRef ref,
    FuelRecord fuel,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Smazat tankování?"),

          content: const Text("Opravdu chcete tento záznam odstranit?"),

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
      await ref.read(fuelProvider.notifier).removeFuel(fuel);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuelAsync = ref.watch(fuelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Tankování")),

      body: fuelAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text("Chyba: $error")),

        data: (allFuels) {
          final fuels = allFuels
              .where((fuel) => fuel.carId == int.parse(carId))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              children: [
                if (fuels.length >= 2)
                  FutureBuilder<double>(
                    future: ref
                        .read(fuelProvider.notifier)
                        .calculateConsumption(int.parse(carId)),

                    builder: (context, snapshot) {
                      final consumption = snapshot.data ?? 0;

                      return AppCard(
                        child: Row(
                          children: [
                            _iconBox(context, Icons.speed),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  const Text(
                                    "Průměrná spotřeba",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "${consumption.toStringAsFixed(1)} l / 100 km",

                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 8),

                Expanded(
                  child: fuels.isEmpty
                      ? const Center(child: Text("Zatím žádné tankování"))
                      : ListView.builder(
                          itemCount: fuels.length,

                          itemBuilder: (context, index) {
                            final fuel = fuels[index];

                            return AppCard(
                              child: Row(
                                children: [
                                  _iconBox(context, Icons.local_gas_station),

                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          "${fuel.liters.toStringAsFixed(1)} litrů",

                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,

                                            fontSize: 16,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          "${fuel.kilometers} km",

                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),

                                        Text(
                                          "${fuel.date.day}.${fuel.date.month}.${fuel.date.year}",

                                          style: TextStyle(
                                            color: Colors.grey.shade500,

                                            fontSize: 13,
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
                                        ),
                                      ),

                                      PopupMenuButton<String>(
                                        icon: const Icon(Icons.more_vert),

                                        onSelected: (value) {
                                          if (value == "edit") {
                                            context.push(
                                              "/fuel/edit",
                                              extra: fuel,
                                            );
                                          }

                                          if (value == "delete") {
                                            _deleteFuel(context, ref, fuel);
                                          }
                                        },

                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: "edit",

                                            child: Row(
                                              children: [
                                                Icon(Icons.edit),

                                                SizedBox(width: 8),

                                                Text("Upravit"),
                                              ],
                                            ),
                                          ),

                                          const PopupMenuItem(
                                            value: "delete",

                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),

                                                SizedBox(width: 8),

                                                Text("Smazat"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/fuel/$carId/add');
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
