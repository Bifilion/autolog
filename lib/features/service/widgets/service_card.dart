import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final ServiceRecord service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service.type == ServiceType.custom
                      ? service.title ?? "Vlastní servis"
                      : service.displayName,
                ),

                Text(
                  "${service.price.toStringAsFixed(0)} Kč",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "🚗 ${service.kilometers} km",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              "📅 ${service.date.day}.${service.date.month}.${service.date.year}",
            ),
            const SizedBox(height: 4),
            if (service.note.isNotEmpty) Text("📝 ${service.note}"),
          ],
        ),
      ),
    );
  }
}
