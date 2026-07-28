import 'package:autolog/core/database/isar_database.dart';
import 'package:isar/isar.dart';

import '../models/service_record.dart';

class ServiceRepository {
  final Isar isar;

  ServiceRepository(this.isar);

  Future<List<ServiceRecord>> getAll() async {
    return await isar.serviceRecords.where().findAll();
  }

  Future<void> add(ServiceRecord service) async {
    await isar.writeTxn(() async {
      await isar.serviceRecords.put(service);
    });
  }

  Future<void> remove(int id) async {
    await isar.writeTxn(() async {
      await isar.serviceRecords.delete(id);
    });
  }

  Future<void> update(ServiceRecord service) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      await isar.serviceRecords.put(service);
    });
  }

  Future<List<ServiceRecord>> getByCar(int carId) async {
    return await isar.serviceRecords.filter().carIdEqualTo(carId).findAll();
  }

  Future<ServiceRecord?> getLatestByCar(int carId) async {
    return await isar.serviceRecords
        .filter()
        .carIdEqualTo(carId)
        .sortByDateDesc()
        .findFirst();
  }
}
