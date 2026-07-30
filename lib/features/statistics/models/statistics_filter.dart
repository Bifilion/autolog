enum StatisticsPeriod { all, thisYear, last12Months }

extension StatisticsPeriodExtension on StatisticsPeriod {
  String get label {
    switch (this) {
      case StatisticsPeriod.all:
        return "Celé období";

      case StatisticsPeriod.thisYear:
        return "Tento rok";

      case StatisticsPeriod.last12Months:
        return "Posledních 12 měsíců";
    }
  }
}

class StatisticsFilter {
  final int carId;

  final StatisticsPeriod period;

  StatisticsFilter({required this.carId, required this.period});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is StatisticsFilter &&
        other.carId == carId &&
        other.period == period;
  }

  @override
  int get hashCode => Object.hash(carId, period);
}
