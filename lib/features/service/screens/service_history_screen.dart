import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceHistoryScreen extends ConsumerWidget {
  final String carId;

  const ServiceHistoryScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(serviceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Historie servisu")),

      body: servicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (_, _) => const Center(child: Text("Chyba načtení")),

        data: (services) {
          final list = services
              .where((s) => s.carId == int.parse(carId))
              .toList();

          list.sort((a, b) => b.date.compareTo(a.date));

          if (list.isEmpty) {
            return const Center(child: Text("Žádný servis"));
          }

          return ListView.builder(
            itemCount: list.length,

            itemBuilder: (context, index) {
              final service = list[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      CircleAvatar(
                        backgroundColor: service.type.color.withValues(
                          alpha: 0.15,
                        ),

                        child: Icon(
                          service.type.icon,
                          color: service.type.color,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    service.displayName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Text(
                                  "${service.price.toStringAsFixed(0)} Kč",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 6),

                                Text(
                                  "${service.date.day}.${service.date.month}.${service.date.year}",
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Row(
                              children: [
                                const Icon(Icons.speed, size: 16),
                                const SizedBox(width: 6),

                                Text("${service.kilometers} km"),
                              ],
                            ),

                            if (service.note.isNotEmpty) ...[
                              const SizedBox(height: 8),

                              Text(
                                service.note,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ],
                        ),
                      ),

                      PopupMenuButton(
                        onSelected: (value) async {
                          if (value == "delete") {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Smazat servis?"),

                                  content: Text(service.displayName),

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
                                  .read(serviceProvider.notifier)
                                  .removeService(service);
                            }
                          }

                          if (value == "edit") {
                            context.push("/service/edit", extra: service);
                          }
                        },

                        itemBuilder: (context) => const [
                          PopupMenuItem(value: "edit", child: Text("Upravit")),

                          PopupMenuItem(value: "delete", child: Text("Smazat")),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
