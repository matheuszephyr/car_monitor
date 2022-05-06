import 'dart:developer';

import 'package:carmonitor/business/vehicle/vehicle_edit_app.dart';
import 'package:carmonitor/models/vehicle-data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleDataEditForm extends StatefulWidget {
  int idVehicle;
  VehicleDataType type;
  String label;

  final TextEditingController kmController = TextEditingController();
  DateTime? dateSelected;
  final dateFormater = DateFormat('dd/MM/yyyy');

  SnackBar getSnackBar(String? text) {
    return SnackBar(
      content: Text(text ?? "Ocorreu uma falha interna!"),
      action: SnackBarAction(
        label: 'Fechar',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }

  void saveVehicleData(BuildContext buildContext) async {
    try {
      int newKm = int.parse(kmController.text != "" ? kmController.text : "0");
      DateTime? newDate;
      log("dateSel => " + dateSelected.toString());

      if (dateSelected != null) {
        newDate = dateSelected;
      }

      var result = await VehicleEditApp.updateVehicleDataByField(
          type, idVehicle, newKm, newDate);

      if (result) {
        Navigator.pop(buildContext);
      } else {
        throw "Falha ao atualizar dados. Verifique os campos informados!";
      }
    } catch (error) {
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(getSnackBar(error.toString()));
    }
  }

  void setDate(DateTime date) {
    log("date => " + date.toString());
    dateSelected = date;
  }

  VehicleDataEditForm(
      {Key? key,
      required this.idVehicle,
      required this.type,
      required this.label})
      : super(key: key);

  @override
  State<VehicleDataEditForm> createState() => _VehicleDataEditFormState();
}

class _VehicleDataEditFormState extends State<VehicleDataEditForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Atualizar ${widget.label}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      content: SizedBox(
        //width: 50,
        height: 150,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.type != VehicleDataType.calibration &&
                      widget.type != VehicleDataType.cooling
                  ? TextField(
                      onChanged: (value) {},
                      controller: widget.kmController,
                      decoration:
                          const InputDecoration(hintText: "Atualizar Km"),
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  : const SizedBox(width: 1),
              const SizedBox(width: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    //style: ButtonStyle(),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 10000)),
                        lastDate: DateTime.now().add(const Duration(days: 2)),
                        confirmText: "Salvar",
                        cancelText: "Cancelar",
                        fieldHintText: "Selecionar Data",
                        fieldLabelText: "Data",
                        helpText: "Selecione uma data",
                        //locale: Locale('pt', 'BR'),
                      ).then((dateValue) => {
                            if (dateValue != null)
                              {
                                setState(() {
                                  widget.setDate(dateValue);
                                })
                              }
                          });
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text('Atualizar Data'),
                  ),
                ],
              ),
              widget.dateSelected != null
                  ? Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Nova Data : ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                            widget.dateFormater.format(widget.dateSelected!),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(width: 1)
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Salvar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () => widget.saveVehicleData(context),
        ),
      ],
    );
  }
}
