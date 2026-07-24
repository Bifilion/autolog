import 'package:autolog/features/fuel/models/fuel_record.dart';

class FuelRepository {
  final List<FuelRecord> _fuelRecords = [];

  List<FuelRecord> getAll() {
    return List.unmodifiable(_fuelRecords);
  }

  void add(FuelRecord fuel) {
    _fuelRecords.add(fuel);
  }

  void remove(String id) {
    _fuelRecords.removeWhere((fuel) => fuel.id == id);
  }

  List<FuelRecord> getByCar(String carId) {
    return _fuelRecords.where((fuel) => fuel.carId == carId).toList();
  }
}
