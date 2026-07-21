import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalFuelCostProvider = Provider.family<double, String>((ref, carId) {
  final fuels = ref.watch(fuelProvider).where((fuel) => fuel.carId == carId);

  return fuels.fold(0, (sum, fuel) => sum + fuel.price);
});

final totalServiceCostProvider = Provider.family<double, String>((ref, carId) {
  final services = ref
      .watch(serviceProvider)
      .where((service) => service.carId == carId);

  return services.fold(0, (sum, service) => sum + service.price);
});
