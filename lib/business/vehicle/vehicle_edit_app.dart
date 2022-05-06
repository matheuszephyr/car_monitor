import 'dart:developer';

import 'package:carmonitor/models/vehicle-data.dart';
import 'package:carmonitor/service/vehicle-service.dart';

import '../../models/vehicle.dart';

class VehicleEditApp {
  static Future<Vehicle> updateVehicleOdometer(
      int idVehicle, int newOdometer) async {
    Vehicle result = Vehicle();

    var responseVehicle = await VehicleService.getVehicle(idVehicle);

    if (responseVehicle.id > 0) {
      responseVehicle.odometer = newOdometer;

      var responseUpdate = await VehicleService.putVehicle(responseVehicle);

      log("responseUpdate =>" + responseUpdate.toString());
      return responseVehicle;
    }

    return result;
  }

  static Future<bool> updateVehicleDataByField(VehicleDataType type,
      int idVehicle, int? newLastKm, DateTime? newLastDate) async {
    var responseGet = await VehicleService.getVehicleData(idVehicle);

    newLastKm = newLastKm ?? 0;

    if (responseGet!.id <= 0 || (newLastKm <= 0 && newLastDate == null)) {
      return false;
    }    

    switch (type) {
      case VehicleDataType.calibration:
        responseGet.lastTireCalibrationDate = newLastDate ?? responseGet.lastTireCalibrationDate;
        break;
      case VehicleDataType.revision:
        responseGet.lastRevisionKm = newLastKm > 0 ? newLastKm : responseGet.lastRevisionKm;
        responseGet.lastRevisionDate = newLastDate ?? responseGet.lastRevisionDate;
        // TODO: Handle this case.
        break;
      case VehicleDataType.cooling:
        responseGet.lastCoolingDate = newLastDate ?? responseGet.lastCoolingDate;
        // TODO: Handle this case.
        break;
      case VehicleDataType.internalAirFilter:
        responseGet.lastInternalAirFilterKm = newLastKm > 0 ? newLastKm : responseGet.lastInternalAirFilterKm;
        responseGet.lastInternalAirFilterDate = newLastDate ?? responseGet.lastInternalAirFilterDate;
        // TODO: Handle this case.
        break;
      case VehicleDataType.engineAirFilter:
        responseGet.lastEngineAirFilterKm = newLastKm > 0 ? newLastKm : responseGet.lastEngineAirFilterKm;
        responseGet.lastEngineAirFilterDate = newLastDate ?? responseGet.lastEngineAirFilterDate;
        break;
      case VehicleDataType.tire:
        responseGet.lastTireKm = newLastKm > 0 ? newLastKm : responseGet.lastTireKm;
        responseGet.lastTireDate = newLastDate ?? responseGet.lastTireDate;
        // TODO: Handle this case.
        break;
      case VehicleDataType.oilFilter:
        responseGet.lastOilFilterKm = newLastKm > 0 ? newLastKm : responseGet.lastOilFilterKm;
        responseGet.lastOilFilterDate = newLastDate ?? responseGet.lastOilFilterDate;
        // TODO: Handle this case.
        break;
        case VehicleDataType.oil:
        responseGet.lastOilKm = newLastKm > 0 ? newLastKm : responseGet.lastOilKm;
        responseGet.lastOilDate = newLastDate ?? responseGet.lastOilDate;
        // TODO: Handle this case.
        break;
    }

    var responsePut = await VehicleService.putVehicleData(responseGet);

    if(responsePut != 200){
      return false;
    }

    return true;
  }
  
  static Future<bool> addNewVehicle(Vehicle vehicle) async{
    var responsePost = await VehicleService.postVehicle(vehicle);
    log("responsePostVehicle => " + responsePost.toString());
    return responsePost == 200 || responsePost == 201;
  }
}
