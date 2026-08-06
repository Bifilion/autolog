import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  final String carId;

  const ServiceHistoryScreen({super.key, required this.carId});

  @override
  ConsumerState<ServiceHistoryScreen> createState() =>
      _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  String sortType = "date_desc";

  String get sortLabel {
    switch (sortType) {
      case "date_desc":
        return "Nejnovější";
      case "date_asc":
        return "Nejstarší";
      case "price_desc":
        return "Nejdražší";
      case "price_asc":
        return "Nejlevnější";
      default:
        return "";
    }
  }

  void changeSort(String value) {
    setState(() {
      sortType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(serviceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historie servisu"),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),

            onSelected: changeSort,

            itemBuilder: (context) => [
              PopupMenuItem(
                value: "date_desc",
                child: Text(
                  "Nejnovější",
                  style: TextStyle(
                    fontWeight: sortType == "date_desc"
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),

              const PopupMenuItem(value: "date_asc", child: Text("Nejstarší")),

              const PopupMenuItem(
                value: "price_desc",
                child: Text("Nejdražší"),
              ),

              const PopupMenuItem(
                value: "price_asc",
                child: Text("Nejlevnější"),
              ),
            ],
          ),
        ],
      ),

      body: servicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (_, _) => const Center(child: Text("Chyba načtení")),

        data: (services) {
          final list = services
              .where((s) => s.carId == int.parse(widget.carId))
              .toList();

          switch (sortType) {
            case "date_desc":
              list.sort((a, b) => b.date.compareTo(a.date));
              break;

            case "date_asc":
              list.sort((a, b) => a.date.compareTo(b.date));
              break;

            case "price_desc":
              list.sort((a, b) => b.price.compareTo(a.price));
              break;

            case "price_asc":
              list.sort((a, b) => a.price.compareTo(b.price));
              break;
          }

          if (list.isEmpty) {
            return const Center(child: Text("Žádný servis"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),

            itemCount: list.length,

            itemBuilder: (context, index) {
              final service = list[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      CircleAvatar(
                        radius: 23,

                        backgroundColor: service.type.color.withValues(
                          alpha: 0.15,
                        ),

                        child: Icon(
                          service.type.icon,
                          color: service.type.color,
                        ),
                      ),

                      const SizedBox(width: 14),

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
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                const Icon(Icons.calendar_month, size: 16),

                                const SizedBox(width: 6),

                                Text(
                                  "${service.date.day}."
                                  "${service.date.month}."
                                  "${service.date.year}",
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(Icons.speed, size: 16),

                                const SizedBox(width: 6),

                                Text("${service.kilometers} km"),
                              ],
                            ),

                            if (service.note.isNotEmpty) ...[
                              const SizedBox(height: 10),

                              Text(
                                service.note,

                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ],
                        ),
                      ),

                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),

                        onSelected: (value) async {
                          if (value == "edit") {
                            context.push("/service/edit", extra: service);
                          }

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
                        },

                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "edit",
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 12),
                                Text("Upravit"),
                              ],
                            ),
                          ),

                          const PopupMenuItem(
                            value: "delete",
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline, size: 20),
                                SizedBox(width: 12),
                                Text("Smazat"),
                              ],
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
        },
      ),
    );
  }
}
