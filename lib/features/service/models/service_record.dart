class ServiceRecord {
  final String id;
  final String carId;
  final DateTime date;
  final int kilometers;
  final String title;
  final double price;
  final String note;

  ServiceRecord({
    required this.id,
    required this.carId,
    required this.date,
    required this.kilometers,
    required this.title,
    required this.price,
    required this.note,
  });
}
