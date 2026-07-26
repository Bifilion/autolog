import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestServiceProvider = FutureProvider.family<ServiceRecord?, int>((
  ref,
  carId,
) async {
  final services = await ref.read(serviceProvider.notifier).getByCar(carId);

  if (services.isEmpty) {
    return null;
  }

  services.sort((a, b) => b.date.compareTo(a.date));

  return services.first;
});

final totalServiceCostProvider = FutureProvider.family<double, int>((
  ref,
  carId,
) async {
  final services = await ref.read(serviceProvider.notifier).getByCar(carId);

  return services.fold<double>(0.0, (sum, service) => sum + service.price);
});
