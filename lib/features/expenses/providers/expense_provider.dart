import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/expenses/models/expense.dart';
import 'package:autolog/features/expenses/repositories/expense_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends AsyncNotifier<List<Expense>> {
  ExpenseRepository? _repository;

  Future<ExpenseRepository> get repository async {
    if (_repository != null) {
      return _repository!;
    }

    _repository = await ref.read(expenseRepositoryProvider.future);

    return _repository!;
  }

  @override
  Future<List<Expense>> build() async {
    final repo = await repository;

    return await repo.getAll();
  }

  Future<void> addExpense(Expense expense) async {
    final repo = await repository;

    await repo.add(expense);

    state = AsyncData(await repo.getAll());
  }

  Future<void> removeExpense(Expense expense) async {
    final repo = await repository;

    await repo.remove(expense.id);

    state = AsyncData(await repo.getAll());
  }

  Future<List<Expense>> getByCar(int carId) async {
    final repo = await repository;

    return await repo.getByCar(carId);
  }
}

final expenseProvider = AsyncNotifierProvider<ExpenseNotifier, List<Expense>>(
  ExpenseNotifier.new,
);
