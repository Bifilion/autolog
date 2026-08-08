import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/cars/providers/car_provider.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/providers/service_stats_provider.dart';
import 'package:autolog/features/service/repositories/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceNotifier extends AsyncNotifier<List<ServiceRecord>> {
  ServiceRepository? _repository;

  Future<ServiceRepository> get repository async {
    if (_repository != null) {
      return _repository!;
    }

    _repository = await ref.read(serviceRepositoryProvider.future);

    return _repository!;
  }

  @override
  Future<List<ServiceRecord>> build() async {
    final repo = await repository;

    return await repo.getAll();
  }

  // Future<void> addService(ServiceRecord service) async {
  //   final repo = await repository;

  //   await repo.add(service);

  //   state = AsyncData(await repo.getAll());

  //   ref.invalidate(totalServiceCostProvider(service.carId));
  //   ref.invalidate(latestServiceProvider(service.carId));
  // }

  Future addService(ServiceRecord service) async {
    final repo = await repository;

    await repo.add(service);

    state = AsyncData(await repo.getAll());

    // Aktualizace kilometrů auta
    await ref
        .read(carProvider.notifier)
        .updateKilometers(service.carId, service.kilometers);

    ref.invalidate(totalServiceCostProvider(service.carId));
    ref.invalidate(latestServiceProvider(service.carId));
  }

  Future<void> removeService(ServiceRecord service) async {
    final repo = await repository;

    await repo.remove(service.id);

    state = AsyncData(await repo.getAll());
  }

  Future<void> updateService(ServiceRecord service) async {
    final repo = await repository;

    await repo.update(service);

    state = AsyncData(await repo.getAll());

    ref.invalidate(totalServiceCostProvider(service.carId));
    ref.invalidate(latestServiceProvider(service.carId));
  }

  Future<List<ServiceRecord>> getByCar(int carId) async {
    final repo = await repository;

    return await repo.getByCar(carId);
  }

  Future<ServiceRecord?> getLatestByCar(int carId) async {
    final repo = await repository;

    return await repo.getLatestByCar(carId);
  }
}

final serviceProvider =
    AsyncNotifierProvider<ServiceNotifier, List<ServiceRecord>>(
      ServiceNotifier.new,
    );
