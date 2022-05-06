import 'dart:ui';

import 'package:carmonitor/business/vehicle/vehicle_edit_app.dart';
import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/util/alerts.dart';
import 'package:flutter/material.dart';

class VehicleAddPage extends StatefulWidget {
  const VehicleAddPage({Key? key}) : super(key: key);

  @override
  State<VehicleAddPage> createState() => _VehicleAddPageState();
}

class _VehicleAddPageState extends State<VehicleAddPage> {
  TextEditingController modelController = TextEditingController();
  TextEditingController fabricatorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController odometerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Veículo"),
      ),
      body: Container(
        height: Size.infinite.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Informe os dados do veículo",
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                ),
                Text(
                  "Todos os campos são obrigatórios!",
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 15),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: modelController,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    labelText: "Modelo",
                    hintText: "Ex: Fusion",
                    labelStyle:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                    helperStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                      //borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: fabricatorController,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    labelText: "Fabricante",
                    hintText: "Ex: Ford",
                    labelStyle:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                    helperStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: yearController,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    labelText: "Ano",
                    hintText: "Ex: 2022",
                    labelStyle:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                    helperStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: odometerController,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    labelText: "Odômetro",
                    hintText: "",
                    suffixText: "Km",
                    labelStyle:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                    helperStyle: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  //style: ButtonStyle(),
                  onPressed: () async {
                    int year = 0;
                    int odometer = 0;

                    if (modelController.text == "") {
                      Alerts.showTextSnackBar(
                          context, "Informe o modelo do veículo.");
                      return;
                    }
                    if (fabricatorController.text == "") {
                      Alerts.showTextSnackBar(
                          context, "Informe o fabricante do veículo.");
                      return;
                    }
                    if (yearController.text == "") {
                      Alerts.showTextSnackBar(
                          context, "Informe o ano do veículo.");
                      return;
                    }
                    if (odometerController.text == "") {
                      Alerts.showTextSnackBar(
                          context, "Informe o odômetro do veículo.");
                      return;
                    }

                    year = int.parse(yearController.text);
                    odometer = int.parse(odometerController.text);

                    if (year < 1900 || year > DateTime.now().year + 1) {
                      Alerts.showTextSnackBar(
                          context, "Ano informado inválido.");
                      return;
                    }

                    Vehicle newVehicle = Vehicle(
                      model: modelController.text,
                      fabricator: fabricatorController.text,
                      year: year,
                      odometer: odometer,
                      image: "",
                      warning: true
                    );

                    var resultAdd = await VehicleEditApp.addNewVehicle(newVehicle);

                    if(resultAdd){
                      Navigator.pop(context);
                    }
                    else{
                      Alerts.showTextSnackBar(
                          context, "Falha ao inserir novo veículo.");
                    }
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    size: 35,
                  ),
                  label: const Text(
                    'Adicionar Veículo',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
