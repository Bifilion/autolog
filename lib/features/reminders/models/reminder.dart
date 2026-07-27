import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'reminder.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;

  late int carId;

  @enumerated
  late ReminderType type;

  /// Interval podle kilometrů
  int? intervalKilometers;

  /// Interval podle času ve dnech
  int? intervalDays;

  DateTime? lastDate;

  String? title;

  int? lastKilometers;

  late bool enabled;

  Reminder({
    required this.carId,
    required this.type,
    this.intervalKilometers,
    this.intervalDays,
    this.lastDate,
    this.title,
    this.lastKilometers,
    this.enabled = true,
  });

  bool isKmDue(int currentKilometers) {
    if (intervalKilometers == null || lastKilometers == null) {
      return false;
    }

    return currentKilometers >= lastKilometers! + intervalKilometers!;
  }

  bool isTimeDue(DateTime today) {
    if (intervalDays == null || lastDate == null) {
      return false;
    }

    final difference = today.difference(lastDate!).inDays;

    return difference >= intervalDays!;
  }

  String kmStatus(int currentKilometers) {
    if (intervalKilometers == null || lastKilometers == null) {
      return "";
    }

    final nextKm = lastKilometers! + intervalKilometers!;

    final remaining = nextKm - currentKilometers;

    if (remaining <= 0) {
      return "⚠️ Překročeno o ${remaining.abs()} km";
    }

    return "Zbývá $remaining km";
  }

  String timeStatus(DateTime today) {
    if (intervalDays == null || lastDate == null) {
      return "";
    }

    final nextDate = lastDate!.add(Duration(days: intervalDays!));

    final remaining = nextDate.difference(today).inDays;

    if (remaining <= 0) {
      return "⚠️ Po termínu o ${remaining.abs()} dní";
    }

    return "Zbývá $remaining dní";
  }

  Color statusColor(int currentKilometers, DateTime today) {
    bool overdue = isKmDue(currentKilometers) || isTimeDue(today);

    if (overdue) {
      return Colors.red;
    }

    if (intervalKilometers != null && lastKilometers != null) {
      final nextKm = lastKilometers! + intervalKilometers!;

      final remaining = nextKm - currentKilometers;

      if (remaining < intervalKilometers! * 0.2) {
        return Colors.orange;
      }
    }

    if (intervalDays != null && lastDate != null) {
      final nextDate = lastDate!.add(Duration(days: intervalDays!));

      final remainingDays = nextDate.difference(today).inDays;

      if (remainingDays < intervalDays! * 0.2) {
        return Colors.orange;
      }
    }

    return Colors.green;
  }
}
