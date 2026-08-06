enum StatisticsPeriod {
  all,
  today,
  week,
  month,
  last3Months,
  last6Months,
  last12Months,
  thisYear,
  custom,
}

extension StatisticsPeriodExtension on StatisticsPeriod {
  String get label {
    switch (this) {
      case StatisticsPeriod.all:
        return "Vše";

      case StatisticsPeriod.today:
        return "Dnes";

      case StatisticsPeriod.week:
        return "Týden";

      case StatisticsPeriod.month:
        return "Měsíc";

      case StatisticsPeriod.last3Months:
        return "3 měsíce";

      case StatisticsPeriod.last6Months:
        return "6 měsíců";

      case StatisticsPeriod.last12Months:
        return "12 měsíců";

      case StatisticsPeriod.thisYear:
        return "Tento rok";

      case StatisticsPeriod.custom:
        return "Vlastní";
    }
  }
}

class StatisticsFilter {
  final int carId;

  final StatisticsPeriod period;

  final DateTime? from;

  final DateTime? to;

  StatisticsFilter({
    required this.carId,
    required this.period,
    this.from,
    this.to,
  });

  @override
  bool operator ==(Object other) {
    return other is StatisticsFilter &&
        other.carId == carId &&
        other.period == period &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode {
    return Object.hash(carId, period, from, to);
  }
}
