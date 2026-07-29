import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseByTypeProvider =
    FutureProvider.family<double, ({int carId, ExpenseType type})>((
      ref,
      params,
    ) async {
      final expenses = await ref.watch(expenseProvider.future);

      double total = 0;

      for (final expense in expenses) {
        if (expense.carId == params.carId && expense.type == params.type) {
          total += expense.amount;
        }
      }

      return total;
    });

final totalExpenseProvider = FutureProvider.family<double, int>((
  ref,
  carId,
) async {
  final expenses = await ref.watch(expenseProvider.future);

  double total = 0;

  for (final expense in expenses) {
    if (expense.carId == carId) {
      total += expense.amount;
    }
  }

  return total;
});

final totalOtherCostProvider = FutureProvider.family<double, int>((
  ref,
  carId,
) async {
  final expenses = await ref.watch(expenseProvider.future);

  double total = 0;

  for (final expense in expenses) {
    if (expense.carId == carId &&
        expense.type != ExpenseType.fuel &&
        expense.type != ExpenseType.service) {
      total += expense.amount;
    }
  }

  return total;
});
