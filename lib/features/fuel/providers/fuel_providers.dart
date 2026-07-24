import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/repositories/fuel_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelNotifier extends StateNotifier<List<FuelRecord>> {
  final FuelRepository repository;

  FuelNotifier(this.repository) : super(repository.getAll());

  void addFuel(FuelRecord fuel) {
    repository.add(fuel);

    state = repository.getAll();
  }

  void removeFuel(FuelRecord fuel) {
    repository.remove(fuel.id);

    state = repository.getAll();
  }

  double calculateConsumption(String carId) {
    final carFuel = state.where((fuel) => fuel.carId == carId).toList();

    if (carFuel.length < 2) {
      return 0;
    }

    carFuel.sort((a, b) => a.kilometres.compareTo(b.kilometres));

    final first = carFuel.first;
    final last = carFuel.last;
    final distance = last.kilometres - first.kilometres;

    if (distance <= 0) {
      return 0;
    }
    return (last.liters / distance) * 100;
  }
}

final fuelProvider = StateNotifierProvider<FuelNotifier, List<FuelRecord>>((
  ref,
) {
  final repository = ref.read(fuelRepositoryProvider);

  return FuelNotifier(repository);
});
