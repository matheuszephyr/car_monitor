import 'dart:developer';

import 'package:carmonitor/business/vehicle/vehicle_edit_app.dart';
import 'package:carmonitor/models/vehicle-data.dart';
import 'package:flutter/material.dart';

class VehicleDataEditModal {
  final TextEditingController kmController = TextEditingController();
  DateTime? dateSelected;

  SnackBar getSnackBar(String? text) {
    return SnackBar(
      content: Text(text ?? "Ocorreu uma falha interna!"),
      action: SnackBarAction(
        label: 'X',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }

  Future<void> displayVehicleDataEditDialog(BuildContext buildContext,
      int idVehicle, VehicleDataType type, String label) async {
    return showDialog(
        context: buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text("Atualizar $label",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  type != VehicleDataType.calibration &&
                          type != VehicleDataType.cooling
                      ? TextField(
                          onChanged: (value) {},
                          controller: kmController,
                          decoration: const InputDecoration(hintText: "Km"),
                          keyboardType: TextInputType.number,
                        )
                      : const SizedBox(width: 1),
                  InputDatePickerFormField(
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 10)),
                    onDateSubmitted: (dateSub) => {dateSelected = dateSub},
                    onDateSaved: (dateSav) => {dateSelected = dateSav},
                    errorInvalidText: "Data inválida",
                    errorFormatText: "Data inválida",
                    fieldHintText: "Insira a ultima data",
                    fieldLabelText: "Ultima Data",
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Salvar',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  try {
                    int newKm = int.parse(
                        kmController.text != "" ? kmController.text : "0");
                    DateTime? newDate;

                    if (dateSelected != null) {
                      newDate = dateSelected;
                    }

                    var result = await VehicleEditApp.updateVehicleDataByField(
                        type, idVehicle, newKm, newDate);

                    if (result) {
                      Navigator.pop(context);
                    } else {
                      throw "Falha ao atualizar dados. Verifique os campos informados!";
                    }
                  } catch (error) {
                    ScaffoldMessenger.of(buildContext)
                        .showSnackBar(getSnackBar(error.toString()));
                  }
                },
              ),
            ],
          );
        });
  }
}
