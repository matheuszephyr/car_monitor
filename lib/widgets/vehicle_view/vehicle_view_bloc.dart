import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/models/vehicle-data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/vehicle_data_card.dart';
import '../../service/vehicle-service.dart';
import '../../util/validation.dart';

part 'vehicle_view_event.dart';

part 'vehicle_view_state.dart';

class VehicleViewBloc extends Bloc<VehicleViewEvent, VehicleViewState> {
  VehicleViewBloc(int idVehicle) : super(VehicleViewInitialState(idVehicle)) {
    on<VehicleViewLoadEvent>(_loadVehicleViewData);
  }

  Future<void> _loadVehicleViewData(VehicleViewLoadEvent event, Emitter<VehicleViewState> emitter) async{
    log("state.idvehicle =>> "+state.idVehicle.toString());

    if (state != VehicleViewLoadingState){

      int idVehicle = state.idVehicle;

      emit(VehicleViewLoadingState());

      Vehicle vehicleResponse = await VehicleService.getVehicle(idVehicle);

      if (vehicleResponse.id > 0){
        VehicleData? vehicleDataResponse = await VehicleService.getVehicleData(idVehicle);
        log("dataResp => " + jsonEncode(vehicleDataResponse));

        vehicleDataResponse = validateData(vehicleResponse, vehicleDataResponse);
        List<VehicleDataCardModel> vehicleCards = validateDataCards(vehicleDataResponse);

        emit(VehicleViewPopulateState(vehicleResponse, vehicleDataResponse, vehicleCards));
      }
      else{
        emit(VehicleViewErrorState("Veículo não encontrado !"));
      }
      
    }

  }


  VehicleData validateData(Vehicle vehicle, VehicleData? vehicleData) {
    var result = vehicleData ?? VehicleData(idVehicle: 0);
    result.idVehicle = vehicle.id;

    var validateRevisionDate = Validation.validateNextDate(vehicle.year, 182, result.lastRevisionDate);
    var validateRevisionKm = Validation.validateNextKm(vehicle.odometer, 10000, result.lastRevisionKm);    
    var validateOilDate = Validation.validateNextDate(vehicle.year, 365, result.lastOilDate);
    var validateOilKm = Validation.validateNextKm(vehicle.odometer, 10000, result.lastOilKm);
    var validateOilFilterDate = Validation.validateNextDate(vehicle.year, 730, result.lastOilFilterDate);
    var validateOilFilterKm = Validation.validateNextKm(vehicle.odometer, 15000, result.lastOilFilterKm);
    var validateEngineAirFilterDate = Validation.validateNextDate(vehicle.year, 365, result.lastEngineAirFilterDate);
    var validateEngineAirFilterKm = Validation.validateNextKm(vehicle.odometer, 10000, result.lastEngineAirFilterKm);
    var validateInternalAirFilterDate = Validation.validateNextDate(vehicle.year, 365, result.lastInternalAirFilterDate);
    var validateInternalAirFilterKm = Validation.validateNextKm(vehicle.odometer, 15000, result.lastInternalAirFilterKm);
    var validateTireDate = Validation.validateNextDate(vehicle.year, 1825, result.lastTireDate);
    var validateTireKm = Validation.validateNextKm(vehicle.odometer, 45000, result.lastTireKm);
    var validateTireCalibrationDate = Validation.validateNextDate(vehicle.year, 15, result.lastTireCalibrationDate);
    var validateCoolingDate = Validation.validateNextDate(vehicle.year, 730, result.lastCoolingDate);

    result.lastRevisionDate = validateRevisionDate[0];
    result.nextRevisionDate = validateRevisionDate[1];
    result.lastRevisionKm = validateRevisionKm[0];
    result.nextRevisionKm = validateRevisionKm[1];
    
    result.lastOilDate = validateOilDate[0];
    result.nextOilDate = validateOilDate[1];
    result.lastOilKm = validateOilKm[0];
    result.nextOilKm = validateOilKm[1];
    
    result.lastOilFilterDate = validateOilFilterDate[0];
    result.nextOilFilterDate = validateOilFilterDate[1];
    result.lastOilFilterKm = validateOilFilterKm[0];
    result.nextOilFilterKm = validateOilFilterKm[1];

    result.lastEngineAirFilterDate = validateEngineAirFilterDate[0];
    result.nextEngineAirFilterDate = validateEngineAirFilterDate[1];
    result.lastEngineAirFilterKm = validateEngineAirFilterKm[0];
    result.nextEngineAirFilterKm = validateEngineAirFilterKm[1];

    result.lastInternalAirFilterDate = validateInternalAirFilterDate[0];
    result.nextInternalAirFilterDate = validateInternalAirFilterDate[1];
    result.lastInternalAirFilterKm = validateInternalAirFilterKm[0];
    result.nextInternalAirFilterKm = validateInternalAirFilterKm[1];

    result.lastTireDate = validateTireDate[0];
    result.nextTireDate = validateTireDate[1];
    result.lastTireKm = validateTireKm[0];
    result.nextTireKm = validateTireKm[1];

    result.lastTireCalibrationDate = validateTireCalibrationDate[0];
    result.nextTireCalibrationDate = validateTireCalibrationDate[1];

    result.lastCoolingDate = validateCoolingDate[0];
    result.nextCoolingDate = validateCoolingDate[1];

    

    return result;
  }

  List<VehicleDataCardModel> validateDataCards(VehicleData vehicleData){

    List<VehicleDataCardModel> vehicleCards = List.empty(growable: true);

    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.tire_repair,
        label: "Calibragem",
        lastDate: vehicleData.lastTireCalibrationDate,
        nextDate: vehicleData.nextTireCalibrationDate));
    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.remove_red_eye,
        label: "Revisão",
        lastDate: vehicleData.lastRevisionDate,
        nextDate: vehicleData.nextRevisionDate,
        lastKm: vehicleData.lastRevisionKm,
        nextKm: vehicleData.nextRevisionKm));
    vehicleCards.add(VehicleDataCardModel(
      icon: Icons.water,
      label: "Arrefecimento ",
      lastDate: vehicleData.lastCoolingDate,
      nextDate: vehicleData.nextCoolingDate,
    ));
    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.ac_unit,
        label: "Filtro de Ar Interno",
        lastDate: vehicleData.lastInternalAirFilterDate,
        nextDate: vehicleData.nextInternalAirFilterDate,
        lastKm: vehicleData.lastInternalAirFilterKm,
        nextKm: vehicleData.nextInternalAirFilterKm));
    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.air,
        label: "Filtro de Ar Motor",
        lastDate: vehicleData.lastEngineAirFilterDate,
        nextDate: vehicleData.nextEngineAirFilterDate,
        lastKm: vehicleData.lastEngineAirFilterKm,
        nextKm: vehicleData.nextEngineAirFilterKm));
    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.add_road_rounded,
        label: "Pneu",
        lastDate: vehicleData.lastTireDate,
        nextDate: vehicleData.nextTireDate,
        lastKm: vehicleData.lastTireKm,
        nextKm: vehicleData.nextTireKm));
    vehicleCards.add(VehicleDataCardModel(
        icon: Icons.wash,
        label: "Filtro de Óleo",
        lastDate: vehicleData.lastOilFilterDate,
        nextDate: vehicleData.nextOilFilterDate,
        lastKm: vehicleData.lastOilFilterKm,
        nextKm: vehicleData.nextOilFilterKm));

    return vehicleCards;
  }
}
