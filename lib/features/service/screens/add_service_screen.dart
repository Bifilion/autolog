import 'package:autolog/core/theme/app_theme.dart';
import 'package:autolog/features/expenses/models/expense.dart';
import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/providers/reminder_provider.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddServiceScreen extends ConsumerStatefulWidget {
  final String carId;

  const AddServiceScreen({super.key, required this.carId});

  @override
  ConsumerState<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends ConsumerState<AddServiceScreen> {
  final titleController = TextEditingController();

  final kilometresController = TextEditingController();

  final priceController = TextEditingController();

  final noteController = TextEditingController();

  final intervalKmController = TextEditingController();

  final intervalMonthsController = TextEditingController();

  ServiceType selectedType = ServiceType.oil;

  DateTime selectedDate = DateTime.now();

  bool reminderEnabled = true;

  @override
  void initState() {
    super.initState();

    intervalKmController.text =
        selectedType.defaultIntervalKm?.toString() ?? "";

    intervalMonthsController.text =
        selectedType.defaultIntervalMonths?.toString() ?? "";
  }

  Future<void> saveService() async {
    if (kilometresController.text.isEmpty ||
        priceController.text.isEmpty ||
        (selectedType == ServiceType.custom && titleController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vyplň všechna povinná pole")),
      );

      return;
    }

    final service = ServiceRecord(
      carId: int.parse(widget.carId),

      date: selectedDate,

      kilometers: int.tryParse(kilometresController.text) ?? 0,

      type: selectedType,

      title: selectedType == ServiceType.custom ? titleController.text : null,

      price: double.tryParse(priceController.text) ?? 0,

      note: noteController.text,

      reminderEnabled: reminderEnabled,

      intervalKilometers: reminderEnabled
          ? int.tryParse(intervalKmController.text)
          : null,

      intervalMonths: reminderEnabled
          ? int.tryParse(intervalMonthsController.text)
          : null,
    );

    await ref.read(serviceProvider.notifier).addService(service);

    await ref
        .read(expenseProvider.notifier)
        .addExpense(
          Expense(
            carId: service.carId,

            date: service.date,

            amount: service.price,

            type: ExpenseType.service,

            title: service.displayName,
          ),
        );

    if (service.reminderEnabled &&
        (service.intervalKilometers != null ||
            service.intervalMonths != null)) {
      final reminder = Reminder(
        carId: service.carId,

        title: service.displayName,

        serviceId: service.id,

        type: service.type.toReminderType(),

        intervalKilometers: service.intervalKilometers,

        intervalDays: service.intervalMonths != null
            ? service.intervalMonths! * 30
            : null,

        lastKilometers: service.kilometers,

        lastDate: service.date,

        enabled: true,
      );

      ref.read(reminderProvider.notifier).addReminder(reminder);
    }

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(title: const Text("Přidat servis")),

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

                      intervalKmController.text =
                          value.defaultIntervalKm?.toString() ?? "";

                      intervalMonthsController.text =
                          value.defaultIntervalMonths?.toString() ?? "";
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
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,

                    title: const Text("Vytvořit připomínku"),

                    subtitle: const Text("Automatické servisní upozornění"),

                    value: reminderEnabled,

                    onChanged: (value) {
                      setState(() {
                        reminderEnabled = value;
                      });
                    },
                  ),

                  if (reminderEnabled) ...[
                    TextField(
                      controller: intervalKmController,

                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        labelText: "Interval km",
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: intervalMonthsController,

                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        labelText: "Interval měsíce",
                      ),
                    ),
                  ],
                ],
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

                onPressed: saveService,

                child: const Text("Uložit servis"),
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

    intervalKmController.dispose();

    intervalMonthsController.dispose();

    super.dispose();
  }
}
