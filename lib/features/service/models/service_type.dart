import 'package:autolog/features/reminders/models/reminder_type.dart';
import 'package:flutter/material.dart';

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
        return ReminderType.transmissionOil;

      case ServiceType.annualService:
        return ReminderType.annualService;
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceType.oil:
        return Icons.oil_barrel;

      case ServiceType.airFilter:
      case ServiceType.cabinFilter:
      case ServiceType.fuelFilter:
        return Icons.filter_alt;

      case ServiceType.brakes:
      case ServiceType.brakeFluid:
        return Icons.car_repair;

      case ServiceType.coolant:
        return Icons.thermostat;

      case ServiceType.transmissionOil:
        return Icons.settings;

      case ServiceType.timingBelt:
        return Icons.settings_applications;

      case ServiceType.tires:
        return Icons.tire_repair;

      case ServiceType.battery:
        return Icons.battery_full;

      case ServiceType.inspection:
        return Icons.fact_check;

      case ServiceType.insurance:
        return Icons.security;

      case ServiceType.annualService:
        return Icons.build_circle;

      case ServiceType.custom:
        return Icons.build;
    }
  }

  Color get color {
    switch (this) {
      case ServiceType.oil:
        return Colors.orange;

      case ServiceType.brakes:
      case ServiceType.brakeFluid:
        return Colors.red;

      case ServiceType.coolant:
        return Colors.blue;

      case ServiceType.tires:
        return Colors.brown;

      case ServiceType.battery:
        return Colors.green;

      case ServiceType.inspection:
        return Colors.deepPurple;

      case ServiceType.insurance:
        return Colors.teal;

      default:
        return Colors.blueGrey;
    }
  }
}

extension ServiceTypeDefaults on ServiceType {
  int? get defaultIntervalKm {
    switch (this) {
      case ServiceType.oil:
        return 15000;

      case ServiceType.airFilter:
        return 30000;

      case ServiceType.cabinFilter:
        return 15000;

      case ServiceType.fuelFilter:
        return 60000;

      case ServiceType.brakes:
        return null;

      case ServiceType.brakeFluid:
        return null;

      case ServiceType.coolant:
        return 60000;

      case ServiceType.transmissionOil:
        return 60000;

      case ServiceType.timingBelt:
        return 90000;

      case ServiceType.tires:
        return 40000;

      case ServiceType.battery:
        return null;

      case ServiceType.inspection:
        return null;

      case ServiceType.insurance:
        return null;

      case ServiceType.annualService:
        return 15000;

      case ServiceType.custom:
        return null;
    }
  }

  int? get defaultIntervalMonths {
    switch (this) {
      case ServiceType.oil:
        return 12;

      case ServiceType.airFilter:
        return 24;

      case ServiceType.cabinFilter:
        return 12;

      case ServiceType.fuelFilter:
        return 48;

      case ServiceType.brakes:
        return 24;

      case ServiceType.brakeFluid:
        return 24;

      case ServiceType.coolant:
        return 60;

      case ServiceType.transmissionOil:
        return 60;

      case ServiceType.timingBelt:
        return 60;

      case ServiceType.tires:
        return 48;

      case ServiceType.battery:
        return 60;

      case ServiceType.inspection:
        return 24;

      case ServiceType.insurance:
        return 12;

      case ServiceType.annualService:
        return 12;

      case ServiceType.custom:
        return null;
    }
  }
}
