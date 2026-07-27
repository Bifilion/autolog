import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/providers/fuel_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestFuelProvider = FutureProvider.family<FuelRecord?, int>((
  ref,
  carId,
) async {
  return await ref.read(fuelProvider.notifier).getLatestByCar(carId);
});
