import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../vehicle_view/vehicle_view_bloc.dart';
import '../vehicle_edit_app.dart';


class VehicleOdometerEditModal {

  final TextEditingController odometerController = TextEditingController();

  Future<void> displayTextInputDialog(BuildContext context, int idVehicle) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar Odômetro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: TextField(
              onChanged: (value) {},
              controller: odometerController,
              decoration: InputDecoration(hintText: "Km"),
              keyboardType: TextInputType.number
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(                
                child: Text('Salvar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () async{
                  int value = int.parse(odometerController.text);
                  var result = await VehicleEditApp.updateVehicleOdometer(idVehicle, value);

                  if(result.id > 0) {
                    Navigator.pop(context);
                  }
                  else {
                    log('deuruiom');
                  }
                },
              ),
            ],
          );
        });
  }
}