import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceCard extends ConsumerWidget {
  final ServiceRecord service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: Row(
        children: [
          // IKONA SERVISU
          Container(
            width: 46,

            height: 46,

            decoration: BoxDecoration(
              color: const Color(0xff7B6EF6),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(service.type.icon, color: Colors.white),
          ),

          const SizedBox(width: 14),

          // INFORMACE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  service.type == ServiceType.custom
                      ? service.title ?? "Vlastní servis"
                      : service.displayName,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 16,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.speed_rounded,

                      size: 16,

                      color: Colors.grey.shade600,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      "${service.kilometers} km",

                      style: TextStyle(
                        fontSize: 13,

                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Icon(
                      Icons.calendar_today_rounded,

                      size: 15,

                      color: Colors.grey.shade600,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      "${service.date.day}.${service.date.month}.${service.date.year}",

                      style: TextStyle(
                        fontSize: 13,

                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                if (service.note.isNotEmpty) ...[
                  const SizedBox(height: 6),

                  Text(
                    service.note,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 8),

          // CENA + MENU
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                "${service.price.toStringAsFixed(0)} Kč",

                style: const TextStyle(
                  fontSize: 16,

                  fontWeight: FontWeight.bold,
                ),
              ),

              PopupMenuButton<String>(
                padding: EdgeInsets.zero,

                icon: Icon(Icons.more_vert, color: Colors.grey.shade600),

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

                          content: const Text(
                            "Opravdu chceš odstranit tento servisní záznam?",
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
                        Icon(Icons.edit),

                        SizedBox(width: 10),

                        Text("Upravit"),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
