import 'dart:developer';

import 'package:carmonitor/models/vehicle-data.dart';
import 'package:carmonitor/util/alerts.dart';
import 'package:carmonitor/util/validation.dart';
import 'package:carmonitor/widgets/vehicle_edit/vehicle_data/vehicle_data_edit.dart';
import 'package:flutter/material.dart';

/*
class VehicleDataCard extends StatefulWidget {
  

  @override
  State<VehicleDataCard> createState() => _VehicleDataCardState();
}*/

// ignore: must_be_immutable
class VehicleDataCard extends StatelessWidget {
  int idVehicle;
  VehicleDataType type;
  IconData icon;
  String label;
  DateTime? lastDate;
  DateTime? nextDate;
  int odometer;
  int? lastKm;
  int? nextKm;  
  EStatusAlert alert = EStatusAlert.undefined;
  Color alertColor = Colors.green;
  double progressValue = 0;

  VehicleDataCard(
      {Key? key,
      required this.idVehicle,
      required this.type,
      required this.icon,
      required this.label,
      required this.odometer,
      this.lastDate,
      this.nextDate,
      this.lastKm,
      this.nextKm})
      : super(key: key) {
    progressValue = _setProgressValue();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.deepPurple, size: 30),
                      const SizedBox(width: 5.0),
                      Text(
                        label,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async => {
                    await VehicleDataEditModal().displayVehicleDataEditDialog(context, idVehicle, type, label)
                  },
                  icon: const Icon(Icons.edit),
                  splashColor: Colors.deepPurple,
                  focusColor: Colors.deepPurple,
                  color: Colors.green,
                  iconSize: 30,
                ),
              ],
            ),
            lastDate != null && nextDate != null
                ? Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Atual : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            "${lastDate?.day}/${lastDate?.month.toString()}/${lastDate?.year.toString()}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      Row(
                        children: [
                          const Text(
                            "Próxima : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            "${nextDate?.day}/${nextDate?.month.toString()}/${nextDate?.year.toString()}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: alertColor),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(width: 2.0),
            (nextKm ?? 0) > 0
                ? Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Atual (Km): ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            "${lastKm?.toString()}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      Row(
                        children: [
                          const Text(
                            "Próxima (Km): ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            "${nextKm?.toString()}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: alertColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(height: 2.0),
            const SizedBox(height: 5.0),
            LinearProgressIndicator(
              value: progressValue,
              semanticsLabel: 'Progresso restante',
              valueColor: AlwaysStoppedAnimation<Color>(alertColor),
              backgroundColor: Colors.grey,
              minHeight: 10,
              //semanticsValue: "sss",
            ),
          ],
        ),
      ),
    );
  }

  double _setProgressValue() {
    double percentDate = 0;
    double percentKm = 0;

    if (lastDate != null && nextDate != null) {
      percentDate = Validation.getPercentValueDate(lastDate, nextDate);
    }
    if ((nextKm ?? 0) > 0) {
      double lastPercentKm = 0;
      double actualPercentKm = 0;

      actualPercentKm = Validation.getPercentValueInt(nextKm!, odometer);
      if(lastKm != null){
        lastPercentKm = Validation.getPercentValueInt(nextKm!, lastKm!);
      }
      
      percentKm = actualPercentKm > lastPercentKm ? actualPercentKm : lastPercentKm;
    }

    double result = percentKm > percentDate ? percentKm : percentDate;
    result = double.parse((result).toStringAsFixed(2));

    if (result > 1.0) {
      _setStatusAlert(EStatusAlert.critical);
    } else if (result > 0.7) {
      _setStatusAlert(EStatusAlert.warning);
    } else if (result >= 0) {
      _setStatusAlert(EStatusAlert.ok);
    }

    return result;
  }

  void _setStatusAlert(EStatusAlert status) {
    if (status == EStatusAlert.ok) {
      alertColor = Colors.green;
    }
    if (status == EStatusAlert.warning) {
      alertColor = Colors.orangeAccent;
    }
    if (status == EStatusAlert.critical) {
      alertColor = Colors.redAccent;
    }
    alert = status;
  }
}

enum EStatusAlert { undefined, ok, warning, critical }
