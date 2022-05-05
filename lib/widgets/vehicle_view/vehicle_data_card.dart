import 'dart:developer';

import 'package:carmonitor/util/validation.dart';
import 'package:flutter/material.dart';

/*
class VehicleDataCard extends StatefulWidget {
  

  @override
  State<VehicleDataCard> createState() => _VehicleDataCardState();
}*/

// ignore: must_be_immutable
class VehicleDataCard extends StatelessWidget {
  IconData icon;
  String label;
  DateTime? lastDate;
  DateTime? nextDate;
  int? lastKm;
  int? nextKm;
  EStatusAlert alert = EStatusAlert.undefined;
  Color alertColor = Colors.greenAccent;

  VehicleDataCard(
      {Key? key,
      required this.icon,
      required this.label,
      this.lastDate,
      this.nextDate,
      this.lastKm,
      this.nextKm})
      : super(key: key);

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
                  onPressed: () => {},
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
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
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
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(height: 2.0),
            const SizedBox(height: 5.0),
            LinearProgressIndicator(
              value: getPercentValue(lastDate, nextDate, lastKm, nextKm),
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

  double getPercentValue(
      DateTime? lastDate, DateTime? nextDate, int? lastKm, int? nextKm) {
    double percentDate = 0;
    double percentKm = 0;

    if (lastDate != null && nextDate != null) {
      percentDate = Validation.getPercentValueDate(lastDate, nextDate);
    }
    if (lastKm != null && nextKm! > 0) {
      percentKm = Validation.getPercentValueInt(nextKm, lastKm);
    }

    double retorno = percentKm > percentDate ? percentKm : percentDate;
    retorno = double.parse((retorno).toStringAsFixed(2));

    if (retorno > 1.0) {
      _setStatusAlert(EStatusAlert.critical);
    } else if (retorno > 0.7) {
      _setStatusAlert(EStatusAlert.warning);
    } else if (retorno >= 0) {
      _setStatusAlert(EStatusAlert.ok);
    }

    return retorno;
  }

  void _setStatusAlert(EStatusAlert status) {
    if (status == EStatusAlert.ok) {
      alertColor = Colors.greenAccent;
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
