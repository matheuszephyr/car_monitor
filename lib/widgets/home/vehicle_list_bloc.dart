import 'dart:async';
import 'dart:developer';
import 'package:carmonitor/models/vehicle.dart';
import 'package:carmonitor/service/vehicle-service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicle_list_event.dart';

part 'vehicle_list_state.dart';

class VehicleListBloc extends Bloc<VehicleListEvent, VehicleListState> {
  VehicleListBloc() : super(VehicleListInitialState(List.empty(growable: true))) {
    on<VehicleListLoad>(_loadVehicleList);
  }

  Future<void> _loadVehicleList(
      VehicleListLoad event, Emitter<VehicleListState> emit) async {

    emit(VehicleListLoadingState());

    List<Vehicle> loadedList = await VehicleService.listVehicles();

    emit(VehicleListInitialState(loadedList));

  }
}
