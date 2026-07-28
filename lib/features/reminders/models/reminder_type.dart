import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

@enumerated
enum ReminderType {
  oil,
  oilFilter,
  airFilter,
  cabinFilter,
  fuelFilter,
  brakeFluid,
  coolant,
  sparkPlugs,
  timingBelt,
  accessoryBelt,
  brakes,
  tires,
  battery,
  inspection,
  emissions,
  insurance,
  transmissionOil,
  annualService,
  custom,
}

extension ReminderTypeExtension on ReminderType {
  String get label {
    switch (this) {
      case ReminderType.oil:
        return "Výměna oleje";

      case ReminderType.oilFilter:
        return "Olejový filtr";

      case ReminderType.airFilter:
        return "Vzduchový filtr";

      case ReminderType.cabinFilter:
        return "Pylový filtr";

      case ReminderType.fuelFilter:
        return "Palivový filtr";

      case ReminderType.brakeFluid:
        return "Brzdová kapalina";

      case ReminderType.coolant:
        return "Chladicí kapalina";

      case ReminderType.sparkPlugs:
        return "Zapalovací svíčky";

      case ReminderType.timingBelt:
        return "Rozvody";

      case ReminderType.accessoryBelt:
        return "Řemen příslušenství";

      case ReminderType.brakes:
        return "Brzdy";

      case ReminderType.tires:
        return "Pneumatiky";

      case ReminderType.battery:
        return "Akumulátor";

      case ReminderType.inspection:
        return "STK";

      case ReminderType.emissions:
        return "Emise";

      case ReminderType.insurance:
        return "Povinné ručení";

      case ReminderType.transmissionOil:
        return "Převodový olej";

      case ReminderType.annualService:
        return "Roční servis";

      case ReminderType.custom:
        return "Vlastní";
    }
  }

  IconData get icon {
    switch (this) {
      case ReminderType.oil:
      case ReminderType.oilFilter:
        return Icons.oil_barrel;

      case ReminderType.airFilter:
      case ReminderType.cabinFilter:
      case ReminderType.fuelFilter:
        return Icons.filter_alt;

      case ReminderType.brakeFluid:
      case ReminderType.brakes:
        return Icons.car_repair;

      case ReminderType.coolant:
        return Icons.thermostat;

      case ReminderType.sparkPlugs:
        return Icons.flash_on;

      case ReminderType.timingBelt:
      case ReminderType.accessoryBelt:
        return Icons.settings;

      case ReminderType.tires:
        return Icons.tire_repair;

      case ReminderType.battery:
        return Icons.battery_full;

      case ReminderType.inspection:
        return Icons.fact_check;

      case ReminderType.emissions:
        return Icons.eco;

      case ReminderType.insurance:
        return Icons.security;

      case ReminderType.transmissionOil:
        return Icons.settings;

      case ReminderType.annualService:
        return Icons.build;

      case ReminderType.custom:
        return Icons.notifications;
    }
  }

  Color get color {
    switch (this) {
      case ReminderType.oil:
      case ReminderType.oilFilter:
        return Colors.orange;

      case ReminderType.brakeFluid:
      case ReminderType.brakes:
        return Colors.red;

      case ReminderType.coolant:
        return Colors.blue;

      case ReminderType.tires:
        return Colors.brown;

      case ReminderType.inspection:
      case ReminderType.emissions:
        return Colors.deepPurple;

      case ReminderType.insurance:
        return Colors.green;

      default:
        return Colors.blueGrey;
    }
  }
}
