import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/repositories/reminder_repository.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/models/service_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderNotifier extends AsyncNotifier<List<Reminder>> {
  late ReminderRepository repository;

  @override
  Future<List<Reminder>> build() async {
    repository = await ref.watch(reminderRepositoryProvider.future);

    return await repository.getAll();
  }

  Future<void> addReminder(Reminder reminder) async {
    await repository.add(reminder);

    state = AsyncData(await repository.getAll());
  }

  Future<void> updateReminder(Reminder reminder) async {
    await repository.update(reminder);

    state = AsyncData(await repository.getAll());
  }

  Future<void> updateByService(ServiceRecord service) async {
    final repo = await repository;

    final reminder = await repo.getByServiceId(service.id);

    if (reminder == null) {
      return;
    }

    reminder
      ..title = service.displayName
      ..type = service.type.toReminderType()
      ..intervalKilometers = service.intervalKilometers
      ..intervalDays = service.intervalMonths != null
          ? service.intervalMonths! * 30
          : null
      ..lastKilometers = service.kilometers
      ..lastDate = service.date;

    await repo.update(reminder);

    state = AsyncData(await repo.getAll());
  }

  Future<void> removeReminder(Reminder reminder) async {
    await repository.remove(reminder.id);

    state = AsyncData(await repository.getAll());
  }

  Future<List<Reminder>> getByCar(int carId) async {
    return await repository.getByCar(carId);
  }

  Future<List<Reminder>> getDueReminders(
    int carId,
    int currentKilometers,
    DateTime today,
  ) async {
    final reminders = await getByCar(carId);

    return reminders.where((reminder) {
      return reminder.isKmDue(currentKilometers) || reminder.isTimeDue(today);
    }).toList();
  }
}

final reminderProvider =
    AsyncNotifierProvider<ReminderNotifier, List<Reminder>>(
      ReminderNotifier.new,
    );
