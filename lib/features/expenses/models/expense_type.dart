import 'package:flutter/material.dart';

enum ExpenseType { service, fuel, insurance, inspection, other }

extension ExpenseTypeExtension on ExpenseType {
  String get label {
    switch (this) {
      case ExpenseType.service:
        return "Servis";
      case ExpenseType.fuel:
        return "Tankování";
      case ExpenseType.insurance:
        return "Pojištění";
      case ExpenseType.inspection:
        return "STK";
      case ExpenseType.other:
        return "Ostatní";
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseType.service:
        return Icons.build;
      case ExpenseType.fuel:
        return Icons.local_gas_station;
      case ExpenseType.insurance:
        return Icons.security;
      case ExpenseType.inspection:
        return Icons.fact_check;
      case ExpenseType.other:
        return Icons.payments;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseType.service:
        return Colors.orange;
      case ExpenseType.fuel:
        return Colors.green;
      case ExpenseType.insurance:
        return Colors.blue;
      case ExpenseType.inspection:
        return Colors.deepPurple;
      case ExpenseType.other:
        return Colors.grey;
    }
  }
}
