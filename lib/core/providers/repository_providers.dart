import 'package:autolog/core/database/isar_database.dart';
import 'package:autolog/features/cars/repositories/car_repository.dart';
import 'package:autolog/features/fuel/repositories/fuel_repository.dart';
import 'package:autolog/features/reminders/repositories/reminder_repository.dart';
import 'package:autolog/features/service/repositories/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isarProvider = FutureProvider((ref) async {
  return await IsarDatabase.getInstance();
});

final carRepositoryProvider = FutureProvider<CarRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);

  return CarRepository(isar);
});

final serviceRepositoryProvider = FutureProvider<ServiceRepository>((
  ref,
) async {
  final isar = await ref.watch(isarProvider.future);

  return ServiceRepository(isar);
});

final fuelRepositoryProvider = FutureProvider<FuelRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);

  return FuelRepository(isar);
});

final reminderRepositoryProvider = FutureProvider<ReminderRepository>((
  ref,
) async {
  return ReminderRepository();
});
