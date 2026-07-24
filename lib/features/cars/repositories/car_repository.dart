import 'package:autolog/features/cars/models/car.dart';

class CarRepository {
  final List<Car> _cars = [];

  List<Car> getAll() {
    return List.unmodifiable(_cars);
  }

  void add(Car car) {
    _cars.add(car);
  }

  void remove(String id) {
    _cars.removeWhere((car) => car.id == id);
  }

  Car? getById(String id) {
    try {
      return _cars.firstWhere((car) => car.id == id);
    } catch (_) {
      return null;
    }
  }
}
