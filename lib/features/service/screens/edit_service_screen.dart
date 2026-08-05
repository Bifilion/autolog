import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditServiceScreen extends ConsumerStatefulWidget {
  final ServiceRecord service;

  const EditServiceScreen({super.key, required this.service});

  @override
  ConsumerState<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends ConsumerState<EditServiceScreen> {
  late final TextEditingController titleController;
  late final TextEditingController kilometresController;
  late final TextEditingController priceController;
  late final TextEditingController noteController;

  late ServiceType selectedType;

  late DateTime selectedDate;

  late bool reminderEnabled;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.service.title ?? "");

    kilometresController = TextEditingController(
      text: widget.service.kilometers.toString(),
    );

    priceController = TextEditingController(
      text: widget.service.price.toString(),
    );

    noteController = TextEditingController(text: widget.service.note);

    selectedType = widget.service.type;

    selectedDate = widget.service.date;

    reminderEnabled = widget.service.reminderEnabled;
  }

  Future<void> save() async {
    final updated = ServiceRecord(
      carId: widget.service.carId,

      date: selectedDate,

      kilometers: int.tryParse(kilometresController.text) ?? 0,

      type: selectedType,

      title: selectedType == ServiceType.custom ? titleController.text : null,

      price: double.tryParse(priceController.text) ?? 0,

      note: noteController.text,

      reminderEnabled: reminderEnabled,

      intervalKilometers: widget.service.intervalKilometers,

      intervalMonths: widget.service.intervalMonths,
    );

    updated.id = widget.service.id;

    await ref.read(serviceProvider.notifier).updateService(updated);

    await ref.read(reminderProvider.notifier).updateByService(updated);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(title: const Text("Upravit servis")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _section(
              child: DropdownButtonFormField<ServiceType>(
                value: selectedType,

                decoration: const InputDecoration(labelText: "Typ servisu"),

                items: ServiceType.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.label));
                }).toList(),

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedType = value;
                    });
                  }
                },
              ),
            ),

            if (selectedType == ServiceType.custom)
              _section(
                child: TextField(
                  controller: titleController,

                  decoration: const InputDecoration(labelText: "Název servisu"),
                ),
              ),

            _section(
              child: Column(
                children: [
                  TextField(
                    controller: kilometresController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: "Kilometry",

                      prefixIcon: Icon(Icons.speed),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: priceController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: "Cena",

                      prefixIcon: Icon(Icons.payments),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: noteController,

                    decoration: const InputDecoration(
                      labelText: "Poznámka",

                      prefixIcon: Icon(Icons.note),
                    ),
                  ),
                ],
              ),
            ),

            _section(
              child: ListTile(
                contentPadding: EdgeInsets.zero,

                leading: const Icon(Icons.calendar_month),

                title: Text(
                  "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}",
                ),

                trailing: const Icon(Icons.edit),

                onTap: () async {
                  final date = await showDatePicker(
                    context: context,

                    initialDate: selectedDate,

                    firstDate: DateTime(2000),

                    lastDate: DateTime.now(),
                  );

                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
            ),

            _section(
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,

                title: const Text("Připomínka"),

                subtitle: const Text("Automaticky hlídat další servis"),

                value: reminderEnabled,

                onChanged: (value) {
                  setState(() {
                    reminderEnabled = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              height: 52,

              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff7B6EF6),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                onPressed: save,

                child: const Text("Uložit změny"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),
      ),

      child: child,
    );
  }

  @override
  void dispose() {
    titleController.dispose();

    kilometresController.dispose();

    priceController.dispose();

    noteController.dispose();

    super.dispose();
  }
}
