import 'dart:developer';

import 'package:carmonitor/service/vehicle-service.dart';

import '../../models/vehicle.dart';

class VehicleEditApp {



  static Future<Vehicle> updateVehicleOdometer(int idVehicle, int newOdometer) async{

    Vehicle result = Vehicle();

    var responseVehicle = await VehicleService.getVehicle(idVehicle);

    if(responseVehicle.id > 0){
      responseVehicle.odometer = newOdometer;

      var responseUpdate = await VehicleService.putVehicle(responseVehicle);

      log("responseUpdate =>" + responseUpdate.toString());
      return responseVehicle;
    }

    return result;    
  }

}