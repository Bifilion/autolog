import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/expenses/models/expense.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  static Isar? _isar;

  static Future<Isar> getInstance() async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open([
      CarSchema,
      ServiceRecordSchema,
      FuelRecordSchema,
      ReminderSchema,
      ExpenseSchema,
    ], directory: dir.path);

    return _isar!;
  }

  static Future<void> clearAllData() async {
    final isar = await getInstance();

    await isar.writeTxn(() async {
      await isar.cars.clear();
      await isar.serviceRecords.clear();
      await isar.fuelRecords.clear();
      await isar.reminders.clear();
      await isar.expenses.clear();
    });
  }
}
