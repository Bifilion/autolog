import 'package:isar/isar.dart';

part 'fuel_record.g.dart';

@collection
class FuelRecord {
  Id id = Isar.autoIncrement;

  /// ID auta
  late int carId;

  /// Datum tankování
  late DateTime date;

  /// Stav tachometru
  late int kilometers;

  /// Počet litrů
  late double liters;

  /// Celková cena
  late double price;

  /// Poznámka
  String? note;

  FuelRecord({
    required this.carId,
    required this.date,
    required this.kilometers,
    required this.liters,
    required this.price,
    this.note,
  });

  double get pricePerLiter {
    if (liters == 0) {
      return 0;
    }

    return price / liters;
  }
}
