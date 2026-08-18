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

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    kilometersController.dispose();

    super.dispose();
  }

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

  Future<void> pickYear() async {
    final currentYear = DateTime.now().year;

    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        int selectedYear = int.tryParse(yearController.text) ?? currentYear;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Rok výroby',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 350,
                child: GridView.builder(
                  itemCount: currentYear - 1899,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final year = currentYear - index;

                    final isSelected = year == selectedYear;

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setDialogState(() {
                          selectedYear = year;
                        });

                        Navigator.pop(context, year);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff5E4FE0)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          year.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zrušit'),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedYear != null) {
      yearController.text = selectedYear.toString();
    }
  }

  Future<void> saveCar() async {
    final brand = brandController.text.trim();
    final model = modelController.text.trim();
    final year = int.tryParse(yearController.text.trim());
    final kilometers = int.tryParse(kilometersController.text.trim());

    if (brand.isEmpty || model.isEmpty || year == null || kilometers == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vyplňte prosím všechny údaje.')),
      );
      return;
    }

    final currentYear = DateTime.now().year;

    if (year < 1900 || year > currentYear) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zadejte platný rok výroby.')),
      );
      return;
    }

    if (kilometers < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nájezd nemůže být záporný.')),
      );
      return;
    }

    final car = Car(
      brand: brand,
      model: model,
      year: year,
      kilometers: kilometers,
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

      appBar: AppBar(title: const Text('Přidat vozidlo')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // FOTO VOZIDLA
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
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                    ),
                  ],
                ),

                child: imagePath == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.directions_car_rounded,
                            size: 70,
                            color: Color(0xff5E4FE0),
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Přidat fotku vozidla',
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

            // ZNAČKA
            _input(
              controller: brandController,
              label: 'Značka',
              icon: Icons.directions_car,
            ),

            // MODEL
            _input(
              controller: modelController,
              label: 'Model',
              icon: Icons.car_repair,
            ),

            // ROK VÝROBY
            _yearInput(),

            // NÁJEZD
            _input(
              controller: kilometersController,
              label: 'Aktuální nájezd',
              icon: Icons.speed,
              number: true,
            ),

            const SizedBox(height: 30),

            // ULOŽIT
            SizedBox(
              width: double.infinity,
              height: 52,

              child: FilledButton(
                onPressed: saveCar,

                child: const Text(
                  'Uložit vozidlo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yearInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: yearController,
        readOnly: true,
        onTap: pickYear,
        decoration: InputDecoration(
          labelText: 'Rok výroby',
          prefixIcon: const Icon(Icons.calendar_month_rounded),
          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
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

        keyboardType: number
            ? const TextInputType.numberWithOptions(
                decimal: false,
                signed: false,
              )
            : TextInputType.text,

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
