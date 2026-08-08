import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/cars/models/car.dart';
import 'package:autolog/features/cars/repositories/car_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarNotifier extends AsyncNotifier<List> {
  late CarRepository repository;

  @override
  Future<List> build() async {
    repository = await ref.watch(carRepositoryProvider.future);

    return await repository.getAll();
  }

  Future addCar(Car car) async {
    await repository.add(car);

    state = AsyncData(await repository.getAll());
  }

  Future removeCar(Car car) async {
    await repository.remove(car.id);

    state = AsyncData(await repository.getAll());
  }

  Future<Car?> getCarById(int id) async {
    return await repository.getById(id);
  }

  Future<void> updateKilometers(int carId, int kilometers) async {
    final repo = await repository;

    await repo.updateKilometers(carId, kilometers);

    state = AsyncData(await repo.getAll());
  }
}

final carProvider = AsyncNotifierProvider<CarNotifier, List>(CarNotifier.new);

final carByIdProvider = FutureProvider.family<Car?, int>((ref, id) async {
  ref.watch(carProvider);

  return await ref.read(carProvider.notifier).getCarById(id);
});
