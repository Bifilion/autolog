import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/fuel/models/fuel_record.dart';
import 'package:autolog/features/fuel/repositories/fuel_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelNotifier extends AsyncNotifier<List<FuelRecord>> {
  FuelRepository? _repository;

  Future<FuelRepository> get repository async {
    if (_repository != null) {
      return _repository!;
    }

    _repository = await ref.read(fuelRepositoryProvider.future);

    return _repository!;
  }

  @override
  Future<List<FuelRecord>> build() async {
    final repo = await repository;

    return await repo.getAll();
  }

  Future<void> addFuel(FuelRecord fuel) async {
    final repo = await repository;

    await repo.add(fuel);

    state = AsyncData(await repo.getAll());
  }

  Future<void> removeFuel(FuelRecord fuel) async {
    final repo = await repository;

    await repo.remove(fuel.id);

    state = AsyncData(await repo.getAll());
  }

  Future<List<FuelRecord>> getByCar(int carId) async {
    final repo = await repository;

    return await repo.getByCar(carId);
  }

  Future<FuelRecord?> getLatestByCar(int carId) async {
    final repo = await repository;

    return await repo.getLatestByCar(carId);
  }

  Future<double> calculateConsumption(int carId) async {
    final repo = await repository;

    final carFuel = await repo.getByCar(carId);

    if (carFuel.length < 2) {
      return 0;
    }

    carFuel.sort((a, b) => a.kilometers.compareTo(b.kilometers));

    final first = carFuel.first;
    final last = carFuel.last;

    final distance = last.kilometers - first.kilometers;

    if (distance <= 0) {
      return 0;
    }

    return (last.liters / distance) * 100;
  }
}

final fuelProvider = AsyncNotifierProvider<FuelNotifier, List<FuelRecord>>(
  FuelNotifier.new,
);
