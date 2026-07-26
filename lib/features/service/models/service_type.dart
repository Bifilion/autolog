enum ServiceType {
  oil,
  airFilter,
  cabinFilter,
  fuelFilter,
  brakes,
  brakeFluid,
  coolant,
  transmissionOil,
  timingBelt,
  tires,
  battery,
  inspection,
  insurance,
  annualService,
  custom,
}

extension ServiceTypeExtension on ServiceType {
  String get label {
    switch (this) {
      case ServiceType.oil:
        return "Výměna oleje";
      case ServiceType.airFilter:
        return "Vzduchový filtr";
      case ServiceType.cabinFilter:
        return "Kabinový filtr";
      case ServiceType.fuelFilter:
        return "Palivový filtr";
      case ServiceType.brakes:
        return "Brzdy";
      case ServiceType.brakeFluid:
        return "Brzdová kapalina";
      case ServiceType.coolant:
        return "Chladicí kapalina";
      case ServiceType.transmissionOil:
        return "Převodový olej";
      case ServiceType.timingBelt:
        return "Rozvody";
      case ServiceType.tires:
        return "Pneumatiky";
      case ServiceType.battery:
        return "Baterie";
      case ServiceType.inspection:
        return "Technická kontrola";
      case ServiceType.insurance:
        return "Pojištění";
      case ServiceType.annualService:
        return "Roční servis";
      case ServiceType.custom:
        return "Vlastní servis";
    }
  }
}
