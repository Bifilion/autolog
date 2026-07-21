import 'package:autolog/features/cars/models/car.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarNotifier extends StateNotifier<List<Car>> {
  CarNotifier() : super([]);

  Car? getCarById(String id) {
    try {
      return state.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  void addCar(Car car) {
    state = [...state, car];
  }

  void removeCar(Car car) {
    state = state.where((c) => c != car).toList();
  }
}

final carProvider = StateNotifierProvider<CarNotifier, List<Car>>(
  (ref) => CarNotifier(),
);
