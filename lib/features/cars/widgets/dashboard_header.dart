import 'dart:io';

import 'package:autolog/core/widgets/app_card.dart';
import 'package:autolog/features/cars/models/car.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashboardHeader extends StatelessWidget {
  final Car car;

  const DashboardHeader({super.key, required this.car});

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      debugPrint(image.path);

      // později:
      // car.imagePath = image.path;
      // uložit přes Isar
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = car.imagePath != null && car.imagePath!.isNotEmpty;

    return AppCard(
      padding: const EdgeInsets.all(18),

      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,

            child: Stack(
              children: [
                Container(
                  width: 90,

                  height: 90,

                  decoration: BoxDecoration(
                    color: const Color(0xff7B6EF6),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                          child: Image.file(
                            File(car.imagePath!),

                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.directions_car_filled_rounded,

                          color: Colors.white,

                          size: 50,
                        ),
                ),

                Positioned(
                  right: 0,

                  bottom: 0,

                  child: Container(
                    width: 28,

                    height: 28,

                    decoration: const BoxDecoration(
                      color: Color(0xff5E4FE0),

                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.camera_alt_rounded,

                      size: 15,

                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "${car.brand} ${car.model}",

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 20,

                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Rok výroby: ${car.year}",

                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Container(
                      width: 36,

                      height: 36,

                      decoration: BoxDecoration(
                        color: const Color(0xff7B6EF6).withOpacity(.15),

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.speed_rounded,

                        size: 20,

                        color: Color(0xff7B6EF6),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "${car.kilometers} km",

                      style: const TextStyle(
                        fontSize: 21,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
