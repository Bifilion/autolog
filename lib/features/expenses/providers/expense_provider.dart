import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalFuelCostProvider = FutureProvider.family<double, int>((
  ref,
  carId,
) async {
  final fuels = await ref.read(fuelProvider.notifier).getByCar(carId);

  return fuels.fold<double>(0.0, (sum, fuel) => sum + fuel.price);
});

final totalServiceCostProvider = FutureProvider.family<double, int>((
  ref,
  carId,
) async {
  final services = await ref.read(serviceProvider.notifier).getByCar(carId);

  return services.fold<double>(0.0, (sum, service) => sum + service.price);
});
