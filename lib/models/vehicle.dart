import 'dart:convert';

class Vehicle {
  int id = 0;
  String fabricator = "";
  String model = "";
  int year = 0000;
  int odometer = 0;
  String image = "";
  bool warning = false;

  Vehicle(
      {this.id = 0,
      this.fabricator = "",
      this.model = "",
      this.year = 0,
      this.odometer = 0,
      this.image = "",
      this.warning = false});

  static List<Vehicle> fromJsonList(String text) {
    try {
      //var json = jsonDecode(text);
      //Iterable list = json.decode(text);
      //List<Vehicle> vehicles = List<Vehicle>.from(list.map((model)=> Vehicle.fromJson(model)));

      List<dynamic> body = jsonDecode(text);

      List<Vehicle> vehicles = body
          .map(
            (dynamic item) => Vehicle.fromJson(item),
          )
          .toList();

      return vehicles;
    } catch (ex) {
      rethrow;
    }
  }

  static Vehicle fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      odometer: json['odometer'] ?? 0,
      image: json['image'],
      fabricator: json['fabricator'],
      model: json['model'],
      year: json['year'],
      warning: json['warning'] ?? false,
    );
  }


  static Vehicle fromJsonString(String text) {
    var json = jsonDecode(text);
    return Vehicle(
      id: json['id'],
      odometer: json['odometer'],
      image: json['image'],
      fabricator: json['fabricator'],
      model: json['model'],
      year: json['year'],
    );
  }

  Map toJson() => {
      'id': id,
      'odometer': odometer,
      'image': image,
      'fabricator': fabricator,
      'model': model,
      'year': year,
      'warning': warning,
  };
  
}

enum fuelType { flex, gasoline, ethanol }
