import 'package:autolog/features/cars/repositories/car_repository.dart';
import 'package:autolog/features/fuel/repositories/fuel_repository.dart';
import 'package:autolog/features/reminders/repositories/reminder_repository.dart';
import 'package:autolog/features/service/repositories/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carRepositoryProvider = Provider<CarRepository>((ref) {
  return CarRepository();
});

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return ServiceRepository();
});

final fuelRepositoryProvider = Provider<FuelRepository>((ref) {
  return FuelRepository();
});

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository();
});
