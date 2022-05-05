part of 'vehicle_list_bloc.dart';

abstract class VehicleListState {

  List<Vehicle> vehicles = List.empty(growable: true);

}

class VehicleListInitialState extends VehicleListState {

  VehicleListInitialState(List<Vehicle> vehicleList){
   vehicles = vehicleList;
  }

}

class VehicleListLoadingState extends VehicleListState{

}
