// To parse this JSON data, do
//
//     final companyModels = companyModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompanyModels companyModelsFromJson(String str) => CompanyModels.fromJson(json.decode(str));

String companyModelsToJson(CompanyModels data) => json.encode(data.toJson());

class CompanyModels {
  CompanyModels({
    @required this.status,
    @required this.code,
    @required this.total,
    @required this.data,
  });

  String status;
  int code;
  int total;
  List<Datum> data;

  factory CompanyModels.fromJson(Map<String, dynamic> json) => CompanyModels(
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
    @required this.name,
    @required this.email,
    @required this.vat,
    @required this.phone,
    @required this.country,
    @required this.addresses,
    @required this.website,
    @required this.image,
    @required this.contact,
  });

  String name;
  String email;
  String vat;
  String phone;
  String country;
  List<Address> addresses;
  String website;
  String image;
  Contact contact;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    email: json["email"],
    vat: json["vat"],
    phone: json["phone"],
    country: json["country"],
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    website: json["website"],
    image: json["image"],
    contact: Contact.fromJson(json["contact"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "vat": vat,
    "phone": phone,
    "country": country,
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
    "website": website,
    "image": image,
    "contact": contact.toJson(),
  };
}

class Address {
  Address({
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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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

class Contact {
  Contact({
    @required this.firstname,
    @required this.lastname,
    @required this.email,
    @required this.phone,
    @required this.birthday,
    @required this.gender,
    @required this.address,
    @required this.website,
    @required this.image,
  });

  String firstname;
  String lastname;
  String email;
  String phone;
  DateTime birthday;
  String gender;
  Address address;
  String website;
  String image;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"],
    address: Address.fromJson(json["address"]),
    website: json["website"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "address": address.toJson(),
    "website": website,
    "image": image,
  };
}
