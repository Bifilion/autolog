class Reminder {
  final String id;

  final String carId;

  final String title;

  // interval podle kilometrů
  final int? intervalKm;

  // interval podle času
  final Duration? intervalTime;

  // stav při posledním servisu
  final int? lastKilometres;

  final DateTime lastDate;

  Reminder({
    required this.id,

    required this.carId,

    required this.title,

    this.intervalKm,

    this.intervalTime,

    this.lastKilometres,

    required this.lastDate,
  });

  int? nextMileage() {
    if (intervalKm == null || lastKilometres == null) {
      return null;
    }

    return lastKilometres! + intervalKm!;
  }

  DateTime? nextDate() {
    if (intervalTime == null) {
      return null;
    }

    return lastDate.add(intervalTime!);
  }

  bool isKmDue(int currentMileage) {
    final next = nextMileage();

    if (next == null) {
      return false;
    }

    return currentMileage >= next;
  }

  bool isTimeDue(DateTime today) {
    final next = nextDate();

    if (next == null) {
      return false;
    }

    return today.isAfter(next);
  }
}
