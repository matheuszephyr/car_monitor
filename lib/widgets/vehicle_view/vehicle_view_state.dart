part of 'vehicle_view_bloc.dart';

abstract class VehicleViewState {

  int idVehicle = 0;
  Vehicle vehicle = Vehicle();
  VehicleData vehicleData = VehicleData();
  List<VehicleDataCardModel> vehicleDataCards = List.empty(growable: true);

  String error = "Ocorreu uma falha interna !";

}

class VehicleViewInitialState extends VehicleViewState {

  VehicleViewInitialState(int _idVehicle){
    idVehicle = _idVehicle;
  }
}

class VehicleViewPopulateState extends VehicleViewState{
  VehicleViewPopulateState(Vehicle _vehicle,VehicleData _vehicleData, List<VehicleDataCardModel> _vehicleDataCards){
    vehicle = _vehicle;
    vehicleData = _vehicleData;
    vehicleDataCards = _vehicleDataCards;
  }
}

class VehicleViewValidatingState extends VehicleViewState{

}

class VehicleViewLoadingState extends VehicleViewState{

}

class VehicleViewErrorState extends VehicleViewState{

  VehicleViewErrorState(String _error){
    error = _error;
  }
}
