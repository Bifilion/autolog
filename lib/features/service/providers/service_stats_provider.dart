import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestServiceProvider = Provider.family<ServiceRecord?, String>((
  ref,
  carId,
) {
  final services = ref
      .watch(serviceProvider)
      .where((service) => service.carId == carId)
      .toList();

  if (services.isEmpty) {
    return null;
  }

  services.sort((a, b) => b.date.compareTo(a.date));

  return services.first;
});
