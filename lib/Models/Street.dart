// To parse this JSON data, do
//
//     final street = streetFromJson(jsonString);

import 'dart:convert';

Street streetFromJson(String str) => Street.fromJson(json.decode(str));

String streetToJson(Street data) => json.encode(data.toJson());

class Street {
  Street({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
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
  });

  List<Streeties> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<Streeties>.from(
                json["data"].map((x) => Streeties.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Streeties {
  Streeties({
    this.mahalleId,
    this.mahalleTitle,
    this.mahalleKey,
    this.mahalleIlcekey,
  });

  int mahalleId;
  String mahalleTitle;
  int mahalleKey;
  int mahalleIlcekey;

  factory Streeties.fromJson(Map<String, dynamic> json) => Streeties(
        mahalleId: json["mahalle_id"] == null ? null : json["mahalle_id"],
        mahalleTitle:
            json["mahalle_title"] == null ? null : json["mahalle_title"],
        mahalleKey: json["mahalle_key"] == null ? null : json["mahalle_key"],
        mahalleIlcekey:
            json["mahalle_ilcekey"] == null ? null : json["mahalle_ilcekey"],
      );

  Map<String, dynamic> toJson() => {
        "mahalle_id": mahalleId == null ? null : mahalleId,
        "mahalle_title": mahalleTitle == null ? null : mahalleTitle,
        "mahalle_key": mahalleKey == null ? null : mahalleKey,
        "mahalle_ilcekey": mahalleIlcekey == null ? null : mahalleIlcekey,
      };
}
