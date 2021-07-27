// To parse this JSON data, do
//
//     final addressModels = addressModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AddressModels> addressModelsFromJson(String str) => List<AddressModels>.from(json.decode(str).map((x) => AddressModels.fromJson(x)));

String addressModelsToJson(List<AddressModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModels {
  AddressModels({
    @required this.status,
    @required this.code,
    @required this.total,
    @required this.data,
  });

  String status;
  int code;
  int total;
  List<Datum> data;

  factory AddressModels.fromJson(Map<String, dynamic> json) => AddressModels(
    status: json["status"],
    code: json["code"],
    total: json["total"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    @required this.street,
    @required this.streetName,
    @required this.buildingNumber,
    @required this.city,
    @required this.zipcode,
    @required this.country,
    @required this.countyCode,
    @required this.latitude,
    @required this.longitude,
  });

  String street;
  String streetName;
  String buildingNumber;
  String city;
  String zipcode;
  String country;
  String countyCode;
  double latitude;
  double longitude;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    street: json["street"],
    streetName: json["streetName"],
    buildingNumber: json["buildingNumber"],
    city: json["city"],
    zipcode: json["zipcode"],
    country: json["country"],
    countyCode: json["county_code"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "streetName": streetName,
    "buildingNumber": buildingNumber,
    "city": city,
    "zipcode": zipcode,
    "country": country,
    "county_code": countyCode,
    "latitude": latitude,
    "longitude": longitude,
  };
}
