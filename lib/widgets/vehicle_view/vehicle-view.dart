import 'dart:developer';

import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/models/vehicle-data.dart';
import 'package:carmonitor/models/vehicle_data_card.dart';
import 'package:carmonitor/widgets/vehicle_edit/vehicle_odometer/vehicle_odometer_edit.dart';
import 'package:carmonitor/widgets/vehicle_view/vehicle_profile.dart';
import 'package:carmonitor/widgets/vehicle_view/vehicle_view_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../util/validation.dart';

class VehicleView extends StatefulWidget {
  final Vehicle vehicle;
  //VehicleData? vehicleData;
  //List<VehicleDataCardModel> vehicleCards = List.empty(growable: true);

  const VehicleView({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<VehicleView> createState() => _VehicleViewState();

}

class _VehicleViewState extends State<VehicleView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehicleViewBloc(widget.vehicle.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Diagnóstico"),
        ),
        body: VehicleProfile(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => {
            await VehicleOdometerEditModal().displayTextInputDialog(context, widget.vehicle.id)
          } ,
          child: const Icon(Icons.speed_sharp),
        ),
      ),
    );
  }
}
