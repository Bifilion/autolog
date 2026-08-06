import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:autolog/features/statistics/models/statistics_filter.dart';
import 'package:flutter/foundation.dart';
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

  final int fuelCount;
  final int serviceCount;

  final DateTime? firstDate;
  final DateTime? lastDate;

  final int firstKilometers;
  final int lastKilometers;
  double get averageMonthlyCost {
    if (monthlyCosts.isEmpty) {
      return 0;
    }

    return totalCost / monthlyCosts.length;
  }

  String get biggestExpense {
    if (fuelCost > serviceCost) {
      return "Palivo";
    }

    if (serviceCost > fuelCost) {
      return "Servis";
    }

    return "-";
  }

  StatisticsData({
    required this.fuelCost,
    required this.serviceCost,
    required this.monthlyCosts,
    required this.fuelCount,
    required this.serviceCount,
    required this.firstDate,
    required this.lastDate,
    required this.firstKilometers,
    required this.lastKilometers,
  });

  double get totalCost => fuelCost + serviceCost;

  int get totalRecords => fuelCount + serviceCount;

  double get costPerKm {
    final km = lastKilometers - firstKilometers;

    if (km <= 0) {
      return 0;
    }

    return totalCost / km;
  }
}

final statisticsProvider =
    FutureProvider.family<StatisticsData, StatisticsFilter>((
      ref,
      filter,
    ) async {
      debugPrint("STATISTICS START carId=${filter.carId}");

      try {
        final fuels = await ref.watch(fuelProvider.future);

        debugPrint("Fuel records: ${fuels.length}");

        final services = await ref.watch(serviceProvider.future);

        debugPrint("Service records: ${services.length}");

        final carFuel = fuels
            .where((f) => f.carId == filter.carId)
            .where((f) => _isInPeriod(f.date, filter))
            .toList();

        final carServices = services
            .where((s) => s.carId == filter.carId)
            .where((s) => _isInPeriod(s.date, filter))
            .toList();

        debugPrint(
          "Filtered fuel=${carFuel.length} service=${carServices.length}",
        );

        final fuelCost = carFuel.fold<double>(
          0,
          (sum, item) => sum + item.price,
        );

        final serviceCost = carServices.fold<double>(
          0,
          (sum, item) => sum + item.price,
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

        final monthlyCosts = monthly.entries.map((e) {
          final parts = e.key.split("-");

          return MonthlyCost(month: "${parts[1]}/${parts[0]}", cost: e.value);
        }).toList();

        final allKm = [
          ...carFuel.map((e) => e.kilometers),

          ...carServices.map((e) => e.kilometers),
        ];

        allKm.sort();

        return StatisticsData(
          fuelCost: fuelCost,

          serviceCost: serviceCost,

          monthlyCosts: monthlyCosts,

          fuelCount: carFuel.length,

          serviceCount: carServices.length,

          firstDate: null,

          lastDate: null,

          firstKilometers: allKm.isEmpty ? 0 : allKm.first,

          lastKilometers: allKm.isEmpty ? 0 : allKm.last,
        );
      } catch (e, stack) {
        debugPrint("STATISTICS ERROR: $e");

        debugPrintStack(stackTrace: stack);

        rethrow;
      }
    });

bool _isInPeriod(DateTime date, StatisticsFilter filter) {
  final now = DateTime.now();

  switch (filter.period) {
    case StatisticsPeriod.all:
      return true;

    case StatisticsPeriod.today:
      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

    case StatisticsPeriod.week:
      return date.isAfter(now.subtract(const Duration(days: 7)));

    case StatisticsPeriod.month:
      return date.year == now.year && date.month == now.month;

    case StatisticsPeriod.last3Months:
      return date.isAfter(DateTime(now.year, now.month - 3, now.day));

    case StatisticsPeriod.last6Months:
      return date.isAfter(DateTime(now.year, now.month - 6, now.day));

    case StatisticsPeriod.last12Months:
      return date.isAfter(DateTime(now.year, now.month - 12, now.day));

    case StatisticsPeriod.thisYear:
      return date.year == now.year;

    case StatisticsPeriod.custom:
      if (filter.from == null || filter.to == null) {
        return false;
      }

      return date.isAfter(filter.from!.subtract(const Duration(days: 1))) &&
          date.isBefore(filter.to!.add(const Duration(days: 1)));
  }
}
