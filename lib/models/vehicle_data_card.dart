import 'package:flutter/material.dart';

class VehicleDataCardModel{
  IconData icon;
  String label;
  DateTime? lastDate;
  DateTime? nextDate;
  int? lastKm;
  int? nextKm;

  VehicleDataCardModel({Key? key, required this.icon, required this.label, this.lastDate, this.nextDate, this.lastKm, this.nextKm});

}