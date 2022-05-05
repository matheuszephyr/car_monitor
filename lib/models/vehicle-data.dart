import 'dart:convert';

class VehicleData {
  int id = 0;
  int idVehicle = 0;

  DateTime? lastRevisionDate;
  DateTime? nextRevisionDate; //6 meses
  int lastRevisionKm = 0;
  int nextRevisionKm = 0; //10.000km

  DateTime? lastOilDate;
  DateTime? nextOilDate; //1 ano
  int lastOilKm = 0;
  int nextOilKm = 0; //10.000Km

  DateTime? lastOilFilterDate;
  DateTime? nextOilFilterDate; //2 ano
  int lastOilFilterKm = 0;
  int nextOilFilterKm = 0; //15.000Km

  DateTime? lastEngineAirFilterDate;
  DateTime? nextEngineAirFilterDate; //1 ano
  int lastEngineAirFilterKm = 0;
  int nextEngineAirFilterKm = 0; //10.000Km

  DateTime? lastInternalAirFilterDate;
  DateTime? nextInternalAirFilterDate; //1 ano
  int lastInternalAirFilterKm = 0;
  int nextInternalAirFilterKm = 0; //15.000K

  DateTime? lastTireDate;
  DateTime? nextTireDate; //5 anos
  int lastTireKm = 0;
  int nextTireKm = 0; //45.000Km

  DateTime? lastTireCalibrationDate;
  DateTime? nextTireCalibrationDate; //2 semanas

  DateTime? lastCoolingDate; //2 anos
  DateTime? nextCoolingDate;

  VehicleData({
    this.id = 0,
    this.idVehicle = 0,
    this.lastCoolingDate,
    this.nextCoolingDate,
    this.lastTireCalibrationDate,
    this.nextTireCalibrationDate,
    this.lastTireKm = 0,
    this.nextTireKm = 0,
    this.lastTireDate,
    this.nextTireDate,
    this.lastInternalAirFilterKm = 0,
    this.nextInternalAirFilterKm = 0,
    this.lastInternalAirFilterDate,
    this.nextInternalAirFilterDate,
    this.lastEngineAirFilterKm = 0,
    this.nextEngineAirFilterKm = 0,
    this.lastEngineAirFilterDate,
    this.nextEngineAirFilterDate,
    this.lastOilFilterKm = 0,
    this.nextOilFilterKm = 0,
    this.lastOilFilterDate,
    this.nextOilFilterDate,
    this.lastOilKm = 0,
    this.nextOilKm = 0,
    this.lastOilDate,
    this.nextOilDate,
    this.lastRevisionKm = 0,
    this.nextRevisionKm = 0,
    this.lastRevisionDate,
    this.nextRevisionDate,
  });

  static fromJsonString(String text) {

    var json = jsonDecode(text);
    return VehicleData(
      id: json['id'],
      idVehicle: json['idVehicle'],
      lastCoolingDate: json['lastCoolingDate'],
      lastEngineAirFilterKm: json['lastEngineAirFilterKm'],
      lastEngineAirFilterDate: json['lastEngineAirFilterDate'],
      lastInternalAirFilterDate: json['lastInternalAirFilterDate'],
      lastInternalAirFilterKm: json['lastInternalAirFilterKm'],
      lastOilDate: json['lastOilDate'],
      lastOilFilterDate: json['lastOilFilterDate'],
      lastOilFilterKm: json['lastOilFilterKm'],
      lastOilKm: json['lastOilKm'],
      lastRevisionDate: json['lastRevisionDate'],
      lastRevisionKm: json['lastRevisionKm'],
      lastTireCalibrationDate: json['lastTireCalibrationDate'],
      lastTireDate: json['lastTireDate'],
      lastTireKm: json['lastTireKm'],
      nextCoolingDate: json['nextCoolingDate'],
      nextEngineAirFilterDate: json['nextEngineAirFilterDate'],
      nextEngineAirFilterKm: json['nextEngineAirFilterKm'],
      nextInternalAirFilterDate: json['nextInternalAirFilterDate'],
      nextInternalAirFilterKm: json['nextInternalAirFilterKm'],
      nextOilDate: json['nextOilDate'],
      nextOilFilterDate: json['nextOilFilterDate'],
      nextOilFilterKm: json['nextOilFilterKm'],
      nextOilKm: json['nextOilKm'],
      nextRevisionDate: json['nextRevisionDate'],
      nextRevisionKm: json['nextRevisionKm'],
      nextTireCalibrationDate: json['nextTireCalibrationDate'],
      nextTireDate: json['nextTireDate'],
      nextTireKm: json['nextTireKm'],
    );
  }

  static VehicleData fromJson(Map<String, dynamic> json) {
    return VehicleData(
      id: json['id'],
      idVehicle: json['idVehicle'],
      lastCoolingDate: json['lastCoolingDate'],
      lastEngineAirFilterKm: json['lastEngineAirFilterKm'],
      lastEngineAirFilterDate: json['lastEngineAirFilterDate'],
      lastInternalAirFilterDate: json['lastInternalAirFilterDate'],
      lastInternalAirFilterKm: json['lastInternalAirFilterKm'],
      lastOilDate: json['lastOilDate'],
      lastOilFilterDate: json['lastOilFilterDate'],
      lastOilFilterKm: json['lastOilFilterKm'],
      lastOilKm: json['lastOilKm'],
      lastRevisionDate: json['lastRevisionDate'],
      lastRevisionKm: json['lastRevisionKm'],
      lastTireCalibrationDate: json['lastTireCalibrationDate'],
      lastTireDate: json['lastTireDate'],
      lastTireKm: json['lastTireKm'],
      nextCoolingDate: json['nextCoolingDate'],
      nextEngineAirFilterDate: json['nextEngineAirFilterDate'],
      nextEngineAirFilterKm: json['nextEngineAirFilterKm'],
      nextInternalAirFilterDate: json['nextInternalAirFilterDate'],
      nextInternalAirFilterKm: json['nextInternalAirFilterKm'],
      nextOilDate: json['nextOilDate'],
      nextOilFilterDate: json['nextOilFilterDate'],
      nextOilFilterKm: json['nextOilFilterKm'],
      nextOilKm: json['nextOilKm'],
      nextRevisionDate: json['nextRevisionDate'],
      nextRevisionKm: json['nextRevisionKm'],
      nextTireCalibrationDate: json['nextTireCalibrationDate'],
      nextTireDate: json['nextTireDate'],
      nextTireKm: json['nextTireKm'],
    );
  }

  static List<VehicleData> fromJsonList(String text) {
    try {

      List<dynamic> body = jsonDecode(text);

      List<VehicleData> vehicles = body
          .map(
            (dynamic item) => VehicleData.fromJson(item),
      )
          .toList();

      return vehicles;
    } catch (ex) {
      rethrow;
    }
  }
}
