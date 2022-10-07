// To parse this JSON data, do
//
//     final county = countyFromJson(jsonString);

import 'dart:convert';

County countyFromJson(String str) => County.fromJson(json.decode(str));

String countyToJson(County data) => json.encode(data.toJson());

class County {
  County({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory County.fromJson(Map<String, dynamic> json) => County(
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

  List<Counties> data;
  String route;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<Counties>.from(
                json["data"].map((x) => Counties.fromJson(x))),
        route: json["route"] == null ? null : json["route"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "route": route == null ? null : route,
      };
}

class Counties {
  Counties({
    this.ilceId,
    this.ilceTitle,
    this.ilceKey,
    this.ilceSehirkey,
  });

  int ilceId;
  String ilceTitle;
  int ilceKey;
  int ilceSehirkey;

  factory Counties.fromJson(Map<String, dynamic> json) => Counties(
        ilceId: json["ilce_id"] == null ? null : json["ilce_id"],
        ilceTitle: json["ilce_title"] == null ? null : json["ilce_title"],
        ilceKey: json["ilce_key"] == null ? null : json["ilce_key"],
        ilceSehirkey:
            json["ilce_sehirkey"] == null ? null : json["ilce_sehirkey"],
      );

  Map<String, dynamic> toJson() => {
        "ilce_id": ilceId == null ? null : ilceId,
        "ilce_title": ilceTitle == null ? null : ilceTitle,
        "ilce_key": ilceKey == null ? null : ilceKey,
        "ilce_sehirkey": ilceSehirkey == null ? null : ilceSehirkey,
      };
}
