import 'package:autolog/core/database/isar_database.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:isar/isar.dart';

class ReminderRepository {
  Future<List<Reminder>> getAll() async {
    final isar = await IsarDatabase.getInstance();

    return await isar.reminders.where().findAll();
  }

  Future<void> add(Reminder reminder) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.reminders.put(reminder);
    });
  }

  Future<Reminder?> getByServiceId(int serviceId) async {
    final isar = await IsarDatabase.getInstance();

    return await isar.reminders
        .filter()
        .serviceIdEqualTo(serviceId)
        .findFirst();
  }

  Future<void> update(Reminder reminder) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.reminders.put(reminder);
    });
  }

  Future<void> remove(int id) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.reminders.delete(id);
    });
  }

  Future<List<Reminder>> getByCar(int carId) async {
    final isar = await IsarDatabase.getInstance();

    return await isar.reminders.filter().carIdEqualTo(carId).findAll();
  }
}
