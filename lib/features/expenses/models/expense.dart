import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  late int carId;

  late DateTime date;

  late double amount;

  @enumerated
  late ExpenseType type;

  String? title;

  Expense({
    required this.carId,
    required this.date,
    required this.amount,
    required this.type,
    this.title,
  });
}
