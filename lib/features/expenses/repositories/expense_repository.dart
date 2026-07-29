import 'package:autolog/core/database/isar_database.dart';
import 'package:autolog/features/expenses/models/expense.dart';
import 'package:isar/isar.dart';

class ExpenseRepository {
  Future<List<Expense>> getAll() async {
    final isar = await IsarDatabase.getInstance();

    return await isar.expenses.where().findAll();
  }

  Future<void> add(Expense expense) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  Future<void> remove(int id) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
  }

  Future<List<Expense>> getByCar(int carId) async {
    final isar = await IsarDatabase.getInstance();

    return await isar.expenses.filter().carIdEqualTo(carId).findAll();
  }
}
