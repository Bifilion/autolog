import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderNotifier extends StateNotifier<List<Reminder>> {
  ReminderNotifier() : super([]);

  void addReminder(Reminder reminder) {
    state = [...state, reminder];
  }

  void removeReminder(Reminder reminder) {
    state = state.where((r) => r.id != reminder.id).toList();
  }

  List<Reminder> getByCar(String carId) {
    return state.where((r) => r.carId == carId).toList();
  }

  List<Reminder> getDueReminders(
    String carId,
    int currentMileage,
    DateTime today,
  ) {
    return getByCar(carId)
        .where(
          (reminder) =>
              reminder.isKmDue(currentMileage) || reminder.isTimeDue(today),
        )
        .toList();
  }
}

final reminderProvider =
    StateNotifierProvider<ReminderNotifier, List<Reminder>>(
      (ref) => ReminderNotifier(),
    );
