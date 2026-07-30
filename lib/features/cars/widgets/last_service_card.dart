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

    if (months == 1) return "Před měsícem";

    if (months < 12) return "Před $months měsíci";

    final years = (months / 12).floor();

    if (years == 1) return "Před rokem";

    return "Před $years lety";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestService = ref.watch(latestServiceProvider(carId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          child: Text(
            "Poslední servis",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
          child: latestService.when(
            loading: () => const ListTile(title: Text("Načítání...")),

            error: (_, _) => const ListTile(title: Text("Chyba načtení")),

            data: (service) {
              if (service == null) {
                return const ListTile(
                  leading: CircleAvatar(child: Icon(Icons.build)),
                  title: Text("Žádný servis"),
                );
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: service.type.color.withValues(alpha: 0.15),
                  child: Icon(service.type.icon, color: service.type.color),
                ),

                title: Text(
                  service.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text(
                  "${service.date.day}.${service.date.month}.${service.date.year}"
                  " • ${service.kilometers} km",
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${service.price.toStringAsFixed(0)} Kč",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Text(
                      _daysAgo(service.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                onTap: () {
                  context.push("/service/$carId/history");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
