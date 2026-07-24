import 'package:autolog/features/service/models/service_record.dart';

class ServiceRepository {
  final List<ServiceRecord> _services = [];

  List<ServiceRecord> getAll() {
    return List.unmodifiable(_services);
  }

  void add(ServiceRecord service) {
    _services.add(service);
  }

  void remove(String id) {
    _services.removeWhere((service) => service.id == id);
  }

  List<ServiceRecord> getByCar(String carId) {
    return _services.where((service) => service.carId == carId).toList();
  }
}
