import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelNotifier extends StateNotifier<List<FuelRecord>> {
  FuelNotifier() : super([]);

  void addFuel(FuelRecord fuel) {
    state = [...state, fuel];
  }

  void removeFuel(FuelRecord fuel) {
    state = state.where((f) => f.id != fuel.id).toList();
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

final fuelProvider = StateNotifierProvider<FuelNotifier, List<FuelRecord>>(
  (ref) => FuelNotifier(),
);
