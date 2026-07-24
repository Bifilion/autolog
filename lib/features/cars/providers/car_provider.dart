import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/cars/repositories/car_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarNotifier extends StateNotifier<List<Car>> {
  final CarRepository repository;

  CarNotifier(this.repository) : super(repository.getAll());

  Car? getCarById(String id) {
    try {
      return state.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  void addCar(Car car) {
    repository.add(car);

    state = repository.getAll();
  }

  void removeCar(Car car) {
    repository.remove(car.id);

    state = repository.getAll();
  }
}

final carProvider = StateNotifierProvider<CarNotifier, List<Car>>((ref) {
  final repository = ref.read(carRepositoryProvider);

  return CarNotifier(repository);
});
