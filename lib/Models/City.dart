// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory City.fromJson(Map<String, dynamic> json) => City(
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
    this.route,
  });

  List<Cities> data;
  String route;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<Cities>.from(json["data"].map((x) => Cities.fromJson(x))),
        route: json["route"] == null ? null : json["route"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "route": route == null ? null : route,
      };
}

class Cities {
  Cities({
    this.sehirId,
    this.sehirTitle,
    this.sehirKey,
  });

  int sehirId;
  String sehirTitle;
  int sehirKey;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        sehirId: json["sehir_id"] == null ? null : json["sehir_id"],
        sehirTitle: json["sehir_title"] == null ? null : json["sehir_title"],
        sehirKey: json["sehir_key"] == null ? null : json["sehir_key"],
      );

  Map<String, dynamic> toJson() => {
        "sehir_id": sehirId == null ? null : sehirId,
        "sehir_title": sehirTitle == null ? null : sehirTitle,
        "sehir_key": sehirKey == null ? null : sehirKey,
      };
}
