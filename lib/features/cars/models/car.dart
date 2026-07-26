import 'package:isar/isar.dart';

part 'car.g.dart';

@collection
class Car {
  Id id = Isar.autoIncrement;

  late String brand;

  late String model;

  late int year;

  late int kilometers;

  Car({
    required this.brand,

    required this.model,

    required this.year,

    required this.kilometers,
  });
}
