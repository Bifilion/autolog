import 'package:autolog/features/service/models/service_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceNotifier extends StateNotifier<List<ServiceRecord>> {
  ServiceNotifier() : super([]);

  void addService(ServiceRecord service) {
    state = [...state, service];
  }

  void removeService(ServiceRecord service) {
    state = [...state, service];
  }

  List<ServiceRecord> getByCar(String carId) {
    return state.where((service) => service.carId == carId).toList();
  }
}

final serviceProvider =
    StateNotifierProvider<ServiceNotifier, List<ServiceRecord>>(
      (ref) => ServiceNotifier(),
    );
