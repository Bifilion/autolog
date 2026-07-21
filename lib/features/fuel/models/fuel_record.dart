class FuelRecord {
  final String id;

  final String carId;

  final DateTime date;

  final int kilometres;

  final double liters;

  final double price;

  FuelRecord({
    required this.id,

    required this.carId,

    required this.date,

    required this.kilometres,

    required this.liters,

    required this.price,
  });

  double get pricePerLiter {
    if (liters == 0) {
      return 0;
    }

    return price / liters;
  }
}
