import 'dart:io';

import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final kilometersController = TextEditingController();

  String? imagePath;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> saveCar() async {
    final car = Car(
      brand: brandController.text.trim(),

      model: modelController.text.trim(),

      year: int.parse(yearController.text),

      kilometers: int.parse(kilometersController.text),

      imagePath: imagePath,
    );

    await ref.read(carProvider.notifier).addCar(car);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(title: const Text("Přidat vozidlo")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // FOTO AUTA
            GestureDetector(
              onTap: pickImage,

              child: Container(
                height: 180,

                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),

                      blurRadius: 15,
                    ),
                  ],
                ),

                child: imagePath == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [
                          Icon(
                            Icons.directions_car_rounded,
                            size: 70,
                            color: Color(0xff5E4FE0),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Přidat fotku vozidla",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(28),

                        child: Image.file(
                          File(imagePath!),

                          fit: BoxFit.cover,

                          width: double.infinity,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            _input(
              controller: brandController,

              label: "Značka",

              icon: Icons.directions_car,
            ),

            _input(
              controller: modelController,

              label: "Model",

              icon: Icons.car_repair,
            ),

            _input(
              controller: yearController,

              label: "Rok výroby",

              icon: Icons.calendar_month,

              number: true,
            ),

            _input(
              controller: kilometersController,

              label: "Aktuální nájezd",

              icon: Icons.speed,

              number: true,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: FilledButton(
                onPressed: saveCar,

                child: const Text(
                  "Uložit vozidlo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,

    required String label,

    required IconData icon,

    bool number = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      child: TextField(
        controller: controller,

        keyboardType: number ? TextInputType.number : TextInputType.text,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: Icon(icon),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
