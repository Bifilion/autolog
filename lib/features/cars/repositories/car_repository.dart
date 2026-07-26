import 'package:autolog/features/cars/models/car.dart';
import 'package:isar/isar.dart';

class CarRepository {
  final Isar isar;

  CarRepository(this.isar);

  Future<List<Car>> getAll() async {
    return await isar.cars.where().findAll();
  }

  Future<void> add(Car car) async {
    await isar.writeTxn(() async {
      await isar.cars.put(car);
    });
  }

  Future<void> remove(int id) async {
    await isar.writeTxn(() async {
      await isar.cars.delete(id);
    });
  }

  Future<Car?> getById(int id) async {
    return await isar.cars.get(id);
  }
}
