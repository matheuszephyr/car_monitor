import 'dart:convert';
import 'dart:developer';
import 'package:carmonitor/models/vehicle.dart';
import 'package:http/http.dart';

import '../models/vehicle-data.dart';

class VehicleService {
  static String baseUri = '10.0.2.2:3000';

  static Future<List<Vehicle>> listVehicles() async {
    final uri = Uri.http(baseUri, '/vehicle');
    final response = await get(uri);

    log("responseStatus => ${response.statusCode} => ${response.request.toString()} ");
    if (response.statusCode == 200) {
      return Vehicle.fromJsonList(response.body);
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  static Future<Vehicle> getVehicle(int id) async {
    final uri = Uri.http(baseUri, '/vehicle/$id');
    final response = await get(uri);

    log("responseStatus => ${response.statusCode} => ${response.request.toString()} => ${response.body} ");
    if (response.statusCode == 200) {
      return Vehicle.fromJsonString(response.body);
    } else {
      return Vehicle();
    }
  }

  static Future<int> postVehicle(Vehicle vehicle) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      String jsonBody = jsonEncode(vehicle);
      final encoding = Encoding.getByName('utf-8');
      final uri = Uri.http(baseUri, '/vehicle');

      Response response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      log("responseStatus => ${response.statusCode} => ${response.request.toString()} => ${response.body} ");
      return response.statusCode;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static Future<int> putVehicle(Vehicle vehicle) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      String jsonBody = jsonEncode(vehicle);
      final encoding = Encoding.getByName('utf-8');
      final uri = Uri.http(baseUri, '/vehicle/${vehicle.id}');

      Response response = await put(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      log("responseStatus => ${response.statusCode} => ${response.request.toString()} => ${response.body} ");
      return response.statusCode;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static Future<VehicleData?> getVehicleData(int idVehicle) async {
    try {
      final queryParameters = {
        'idVehicle': idVehicle.toString(),
      };

      final uri = Uri.http(baseUri, '/status', queryParameters);
      final response = await get(uri);

      log("responseStatus => ${response.statusCode} => ${response.request.toString()} => ${response.body} ");
      if (response.statusCode == 200) {
        var result = VehicleData.fromJsonList(response.body);
        if (result.isNotEmpty) {
          return result.first;
        } else {
          return VehicleData();
        }
      } else {
        throw Exception('Failed to load VehicleData with code => ' +
            response.statusCode.toString());
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static Future<int> postVehicleData(VehicleData vehicleData) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      String jsonBody = jsonEncode(vehicleData);
      final encoding = Encoding.getByName('utf-8');
      final uri = Uri.http(baseUri, '/status');

      Response response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      log("responseStatus => ${response.statusCode} => ${response.request.toString()} ");
      return response.statusCode;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  static Future<int> putVehicleData(VehicleData vehicleData) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      String jsonBody = jsonEncode(vehicleData);
      final encoding = Encoding.getByName('utf-8');      
      final uri = Uri.http(baseUri, '/status/${vehicleData.id}');

      Response response = await put(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      log("responseStatus => ${response.statusCode} => ${response.request.toString()} ");
      return response.statusCode;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
