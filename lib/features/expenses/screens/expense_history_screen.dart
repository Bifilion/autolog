import 'package:autolog/features/expenses/models/expense_type.dart';
import 'package:autolog/features/expenses/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseHistoryScreen extends ConsumerWidget {
  final String carId;

  const ExpenseHistoryScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expenseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Historie nákladů")),

      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (_, _) => const Center(child: Text("Chyba načtení nákladů")),

        data: (expenses) {
          final list = expenses
              .where((e) => e.carId == int.parse(carId))
              .toList();

          list.sort((a, b) => b.date.compareTo(a.date));

          if (list.isEmpty) {
            return const Center(child: Text("Žádné náklady"));
          }

          return ListView.builder(
            itemCount: list.length,

            itemBuilder: (context, index) {
              final expense = list[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: ListTile(
                  leading: Icon(expense.type.icon, color: expense.type.color),

                  title: Text(expense.title ?? expense.type.label),

                  subtitle: Text(
                    "${expense.date.day}.${expense.date.month}.${expense.date.year}",
                  ),

                  trailing: Text(
                    "${expense.amount.toStringAsFixed(0)} Kč",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
