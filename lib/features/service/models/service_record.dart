import 'package:autolog/features/service/models/service_type.dart';
import 'package:isar/isar.dart';

part 'service_record.g.dart';

@collection
class ServiceRecord {
  Id id = Isar.autoIncrement;

  /// ID vozidla
  late int carId;

  /// Datum provedení servisu
  late DateTime date;

  /// Stav tachometru
  late int kilometers;

  /// Typ servisu
  @enumerated
  late ServiceType type;

  /// Vlastní název (pouze pokud type == custom)
  String? title;

  /// Cena
  late double price;

  /// Poznámka
  late String note;

  late bool reminderEnabled;

  /// Interval v kilometrech
  int? intervalKilometers;

  /// Interval v měsících
  int? intervalMonths;

  ServiceRecord({
    required this.carId,
    required this.date,
    required this.kilometers,
    required this.type,
    this.title,
    required this.price,
    required this.note,
    this.intervalKilometers,
    this.intervalMonths,
    required this.reminderEnabled,
  });

  String get displayName {
    if (type == ServiceType.custom && title != null && title!.isNotEmpty) {
      return title!;
    }

    return type.label;
  }
}
