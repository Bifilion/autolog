import 'package:autolog/features/cars/models/car.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final Car car;

  const DashboardHeader({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 34,
              child: Icon(Icons.directions_car, size: 34),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${car.brand} ${car.model}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${car.year}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${car.kilometers} km",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
