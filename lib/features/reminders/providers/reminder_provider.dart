import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/reminders/models/reminder.dart';
import 'package:autolog/features/reminders/repositories/reminder_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderNotifier extends StateNotifier<List<Reminder>> {
  final ReminderRepository repository;

  ReminderNotifier(this.repository) : super(repository.getAll());

  void addReminder(Reminder reminder) {
    repository.add(reminder);

    state = repository.getAll();
  }

  void removeReminder(Reminder reminder) {
    repository.remove(reminder.id);

    state = repository.getAll();
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
    StateNotifierProvider<ReminderNotifier, List<Reminder>>((ref) {
      final repository = ref.read(reminderRepositoryProvider);

      return ReminderNotifier(repository);
    });
