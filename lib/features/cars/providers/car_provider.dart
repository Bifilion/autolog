import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/cars/repositories/car_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarNotifier extends AsyncNotifier<List<Car>> {
  late CarRepository repository;

  @override
  Future<List<Car>> build() async {
    repository = await ref.watch(carRepositoryProvider.future);

    return await repository.getAll();
  }

  Future<void> addCar(Car car) async {
    await repository.add(car);

    state = AsyncData(await repository.getAll());
  }

  Future<void> removeCar(Car car) async {
    await repository.remove(car.id);

    state = AsyncData(await repository.getAll());
  }

  Future<Car?> getCarById(int id) async {
    return await repository.getById(id);
  }
}

final carProvider = AsyncNotifierProvider<CarNotifier, List<Car>>(
  CarNotifier.new,
);
