import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/service/models/service_record.dart';
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

  Future<void> addService(ServiceRecord service) async {
    final repo = await repository;

    await repo.add(service);

    state = AsyncData(await repo.getAll());
  }

  Future<void> removeService(ServiceRecord service) async {
    final repo = await repository;

    await repo.remove(service.id);

    state = AsyncData(await repo.getAll());
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
