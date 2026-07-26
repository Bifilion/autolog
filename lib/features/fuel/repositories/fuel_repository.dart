import 'package:isar/isar.dart';
import 'package:autolog/features/fuel/models/fuel_record.dart';

class FuelRepository {
  final Isar isar;

  FuelRepository(this.isar);

  Future<List<FuelRecord>> getAll() async {
    return await isar.fuelRecords.where().findAll();
  }

  Future<void> add(FuelRecord fuel) async {
    await isar.writeTxn(() async {
      await isar.fuelRecords.put(fuel);
    });
  }

  Future<void> remove(int id) async {
    await isar.writeTxn(() async {
      await isar.fuelRecords.delete(id);
    });
  }

  Future<List<FuelRecord>> getByCar(int carId) async {
    return await isar.fuelRecords.filter().carIdEqualTo(carId).findAll();
  }

  Future<FuelRecord?> getLatestByCar(int carId) async {
    return await isar.fuelRecords
        .filter()
        .carIdEqualTo(carId)
        .sortByDateDesc()
        .findFirst();
  }
}
