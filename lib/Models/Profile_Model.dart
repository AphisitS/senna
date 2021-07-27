// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  ProfileModel({
    @required this.status,
    @required this.code,
    @required this.total,
    @required this.data,
  });

  String status;
  int code;
  int total;
  List<Datum> data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    @required this.title,
    @required this.description,
    @required this.url,
  });

  String title;
  String description;
  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    description: json["description"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "url": url,
  };
}
