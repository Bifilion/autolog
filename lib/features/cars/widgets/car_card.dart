import 'dart:io';

import 'package:autolog/features/cars/models/car.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;

  const CarCard({super.key, required this.car, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              // FOTO AUTA
              CircleAvatar(
                radius: 36,

                backgroundColor: Theme.of(context).colorScheme.primaryContainer,

                backgroundImage: car.imagePath != null
                    ? FileImage(File(car.imagePath!))
                    : null,

                child: car.imagePath == null
                    ? const Icon(Icons.directions_car, size: 36)
                    : null,
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "${car.brand} ${car.model}",

                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "${car.year}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.speed, size: 18),

                        const SizedBox(width: 5),

                        Text("${car.kilometers} km"),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
