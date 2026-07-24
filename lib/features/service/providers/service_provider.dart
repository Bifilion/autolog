import 'package:autolog/core/providers/repository_providers.dart';
import 'package:autolog/features/service/models/service_record.dart';
import 'package:autolog/features/service/repositories/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceNotifier extends StateNotifier<List<ServiceRecord>> {
  final ServiceRepository repository;

  ServiceNotifier(this.repository) : super(repository.getAll());

  void addService(ServiceRecord service) {
    repository.add(service);

    state = repository.getAll();
  }

  void removeService(ServiceRecord service) {
    repository.remove(service.id);

    state = repository.getAll();
  }

  List<ServiceRecord> getByCar(String carId) {
    return state.where((service) => service.carId == carId).toList();
  }
}

final serviceProvider =
    StateNotifierProvider<ServiceNotifier, List<ServiceRecord>>((ref) {
      final repository = ref.read(serviceRepositoryProvider);

      return ServiceNotifier(repository);
    });
