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
    return VehicleData.fromJson(json);
  }

  static VehicleData fromJson(Map<String, dynamic> json) {
    return VehicleData(
      id: json['id'] as int,
      idVehicle: json['idVehicle'] as int,
      lastCoolingDate: DateTime.parse(json['lastCoolingDate']),
      lastEngineAirFilterKm: json['lastEngineAirFilterKm'] as int,
      lastEngineAirFilterDate: DateTime.parse(json['lastEngineAirFilterDate']),
      lastInternalAirFilterDate: DateTime.parse(json['lastInternalAirFilterDate']),
      lastInternalAirFilterKm: json['lastInternalAirFilterKm'] as int,
      lastOilDate: DateTime.parse(json['lastOilDate']),
      lastOilFilterDate: DateTime.parse(json['lastOilFilterDate']),
      lastOilFilterKm: json['lastOilFilterKm'] as int,
      lastOilKm: json['lastOilKm'] as int,
      lastRevisionDate: DateTime.parse(json['lastRevisionDate']),
      lastRevisionKm: json['lastRevisionKm'] as int,
      lastTireCalibrationDate: DateTime.parse(json['lastTireCalibrationDate']),
      lastTireDate: DateTime.parse(json['lastTireDate']),
      lastTireKm: json['lastTireKm'] as int,
      nextCoolingDate: DateTime.parse(json['nextCoolingDate']),
      nextEngineAirFilterDate: DateTime.parse(json['nextEngineAirFilterDate']),
      nextEngineAirFilterKm: json['nextEngineAirFilterKm'] as int,
      nextInternalAirFilterDate: DateTime.parse(json['nextInternalAirFilterDate']),
      nextInternalAirFilterKm: json['nextInternalAirFilterKm'] as int,
      nextOilDate: DateTime.parse(json['nextOilDate']),
      nextOilFilterDate: DateTime.parse(json['nextOilFilterDate']),
      nextOilFilterKm: json['nextOilFilterKm'] as int,
      nextOilKm: json['nextOilKm'] as int,
      nextRevisionDate: DateTime.parse(json['nextRevisionDate']),
      nextRevisionKm: json['nextRevisionKm'] as int,
      nextTireCalibrationDate: DateTime.parse(json['nextTireCalibrationDate']),
      nextTireDate: DateTime.parse(json['nextTireDate']),
      nextTireKm: json['nextTireKm'] as int,
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

  Map toJson() => {
        'id': id,
        'idVehicle': idVehicle,
        'lastCoolingDate': lastCoolingDate.toString(),
        'lastEngineAirFilterKm': lastEngineAirFilterKm,
        'lastEngineAirFilterDate': lastEngineAirFilterDate.toString(),
        'lastInternalAirFilterDate': lastInternalAirFilterDate.toString(),
        'lastInternalAirFilterKm': lastInternalAirFilterKm,
        'lastOilDate': lastOilDate.toString(),
        'lastOilFilterDate': lastOilFilterDate.toString(),
        'lastOilFilterKm': lastOilFilterKm,
        'lastOilKm': lastOilKm,
        'lastRevisionDate': lastRevisionDate.toString(),
        'lastRevisionKm': lastRevisionKm,
        'lastTireCalibrationDate': lastTireCalibrationDate.toString(),
        'lastTireDate': lastTireDate.toString(),
        'lastTireKm': lastTireKm,
        'nextCoolingDate': nextCoolingDate.toString(),
        'nextEngineAirFilterDate': nextEngineAirFilterDate.toString(),
        'nextEngineAirFilterKm': nextEngineAirFilterKm,
        'nextInternalAirFilterDate': nextInternalAirFilterDate.toString(),
        'nextInternalAirFilterKm': nextInternalAirFilterKm,
        'nextOilDate': nextOilDate.toString(),
        'nextOilFilterDate': nextOilFilterDate.toString(),
        'nextOilFilterKm': nextOilFilterKm,
        'nextOilKm': nextOilKm,
        'nextRevisionDate': nextRevisionDate.toString(),
        'nextRevisionKm': nextRevisionKm,
        'nextTireCalibrationDate': nextTireCalibrationDate.toString(),
        'nextTireDate': nextTireDate.toString(),
        'nextTireKm': nextTireKm,
      };
}

enum VehicleDataType{
  calibration,
  revision,
  cooling,
  internalAirFilter,
  engineAirFilter,
  tire,
  oilFilter,
  oil
}
