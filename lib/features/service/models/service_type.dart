import 'package:autolog/features/reminders/models/reminder_type.dart';

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

  ReminderType toReminderType() {
    switch (this) {
      case ServiceType.oil:
        return ReminderType.oil;

      case ServiceType.airFilter:
        return ReminderType.airFilter;

      case ServiceType.cabinFilter:
        return ReminderType.cabinFilter;

      case ServiceType.fuelFilter:
        return ReminderType.fuelFilter;

      case ServiceType.brakes:
        return ReminderType.brakes;

      case ServiceType.brakeFluid:
        return ReminderType.brakeFluid;

      case ServiceType.coolant:
        return ReminderType.coolant;

      case ServiceType.timingBelt:
        return ReminderType.timingBelt;

      case ServiceType.tires:
        return ReminderType.tires;

      case ServiceType.battery:
        return ReminderType.battery;

      case ServiceType.inspection:
        return ReminderType.inspection;

      case ServiceType.insurance:
        return ReminderType.insurance;

      case ServiceType.custom:
        return ReminderType.custom;

      case ServiceType.transmissionOil:
        return ReminderType.custom;

      case ServiceType.annualService:
        return ReminderType.custom;
    }
  }
}
