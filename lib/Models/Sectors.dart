// To parse this JSON data, do
//
//     final sectors = sectorsFromJson(jsonString);

import 'dart:convert';

Sectors sectorsFromJson(String str) => Sectors.fromJson(json.decode(str));

String sectorsToJson(Sectors data) => json.encode(data.toJson());

class Sectors {
  Sectors({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory Sectors.fromJson(Map<String, dynamic> json) => Sectors(
        error: json["error"] == null ? null : json["error"],
        errorMsg: json["errorMsg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "errorMsg": errorMsg,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.data,
    this.count,
  });

  List<InstanceOfSector> data;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<InstanceOfSector>.from(
                json["data"].map((x) => InstanceOfSector.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class InstanceOfSector {
  InstanceOfSector({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory InstanceOfSector.fromJson(Map<String, dynamic> json) =>
      InstanceOfSector(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
