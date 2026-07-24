import 'package:autolog/features/reminders/models/reminder.dart';

class ReminderRepository {
  final List<Reminder> _reminders = [];

  List<Reminder> getAll() {
    return List.unmodifiable(_reminders);
  }

  void add(Reminder reminder) {
    _reminders.add(reminder);
  }

  void remove(String id) {
    _reminders.removeWhere((reminder) => reminder.id == id);
  }

  List<Reminder> getByCar(String carId) {
    return _reminders.where((reminder) => reminder.carId == carId).toList();
  }
}
