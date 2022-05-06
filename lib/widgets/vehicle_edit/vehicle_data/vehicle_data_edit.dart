import 'package:carmonitor/models/vehicle-data.dart';
import 'package:carmonitor/widgets/vehicle_edit/vehicle_data/vehicle_data_edit_form.dart';
import 'package:flutter/material.dart';

class VehicleDataEditModal {
  

  Future<void> displayVehicleDataEditDialog(BuildContext buildContext,
      int idVehicle, VehicleDataType type, String label) async {
    return showDialog(
        context: buildContext,
        builder: (context) {
          return VehicleDataEditForm(idVehicle: idVehicle, type: type, label: label);
        });
  }

  
}
