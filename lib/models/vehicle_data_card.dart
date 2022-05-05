import 'package:carmonitor/models/vehicle-data.dart';
import 'package:flutter/material.dart';

class VehicleDataCardModel{
  VehicleDataType type;
  IconData icon;
  String label;
  DateTime? lastDate;
  DateTime? nextDate;
  int? lastKm;
  int? nextKm;

  VehicleDataCardModel({Key? key, required this.type, required this.icon, required this.label, this.lastDate, this.nextDate, this.lastKm, this.nextKm});

}