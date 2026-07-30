import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthlyCost {
  final String month;
  final double cost;

  MonthlyCost({required this.month, required this.cost});
}

class StatisticsData {
  final double fuelCost;
  final double serviceCost;
  final List<MonthlyCost> monthlyCosts;

  double get totalCost => fuelCost + serviceCost;

  StatisticsData({
    required this.fuelCost,
    required this.serviceCost,
    required this.monthlyCosts,
  });
}

final statisticsProvider =
    FutureProvider.family<StatisticsData, StatisticsFilter>((
      ref,
      filter,
    ) async {
      final carId = filter.carId;

      final fuelsAsync = ref.watch(fuelProvider);
      final servicesAsync = ref.watch(serviceProvider);

      if (fuelsAsync.isLoading || servicesAsync.isLoading) {
        throw Exception("Data se ještě načítají");
      }

      final fuels = fuelsAsync.value ?? [];

      final services = servicesAsync.value ?? [];

      final carFuel = fuels
          .where((f) => f.carId == carId)
          .where((f) => _isInPeriod(f.date, filter.period))
          .toList();

      final carServices = services
          .where((s) => s.carId == carId)
          .where((s) => _isInPeriod(s.date, filter.period))
          .toList();

      final fuelCost = carFuel.fold<double>(0, (sum, fuel) => sum + fuel.price);

      final serviceCost = carServices.fold<double>(
        0,
        (sum, service) => sum + service.price,
      );

      final Map<String, double> monthly = {};

      for (final fuel in carFuel) {
        final key = "${fuel.date.year}-${fuel.date.month}";

        monthly[key] = (monthly[key] ?? 0) + fuel.price;
      }

      for (final service in carServices) {
        final key = "${service.date.year}-${service.date.month}";

        monthly[key] = (monthly[key] ?? 0) + service.price;
      }

      final monthlyCosts = monthly.entries.map((entry) {
        final parts = entry.key.split("-");

        final month = "${parts[1]}/${parts[0]}";

        return MonthlyCost(month: month, cost: entry.value);
      }).toList();

      monthlyCosts.sort((a, b) => a.month.compareTo(b.month));

      return StatisticsData(
        fuelCost: fuelCost,

        serviceCost: serviceCost,

        monthlyCosts: monthlyCosts,
      );
    });

bool _isInPeriod(DateTime date, StatisticsPeriod period) {
  final now = DateTime.now();

  switch (period) {
    case StatisticsPeriod.all:
      return true;

    case StatisticsPeriod.thisYear:
      return date.year == now.year;

    case StatisticsPeriod.last12Months:
      final start = DateTime(now.year, now.month - 12, now.day);

      return date.isAfter(start);
  }
}
