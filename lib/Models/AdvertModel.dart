// To parse this JSON data, do
//
//     final advertModel = advertModelFromJson(jsonString);

import 'dart:convert';

AdvertModel advertModelFromJson(String str) =>
    AdvertModel.fromJson(json.decode(str));

String advertModelToJson(AdvertModel data) => json.encode(data.toJson());

class AdvertModel {
  AdvertModel({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory AdvertModel.fromJson(Map<String, dynamic> json) => AdvertModel(
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

  List<Datum> data;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Datum {
  Datum(
      {this.id,
      this.content,
      this.age,
      this.image,
      this.typeId,
      this.animalId,
      this.animalType,
      this.animalKind,
      this.createdAt,
      this.updatedAt,
      this.districtId,
      this.ilceKey,
      this.sehirKey,
      this.cityName,
      this.countyName,
      this.streetName,
      this.city,
      this.county,
      this.district});

  int id;
  String content;
  dynamic age;
  String image;
  int typeId;
  dynamic animalId;
  dynamic animalType;
  int animalKind;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic districtId;
  dynamic ilceKey;
  dynamic sehirKey;
  String cityName;
  String countyName;
  String streetName;
  dynamic district;
  dynamic county;
  dynamic city;
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"] == null ? null : json["id"],
      content: json["content"] == null ? null : json["content"],
      age: json["age"] == null ? "" : json['age'],
      image: json["image"] == null ? "" : json["image"],
      typeId: json["type_id"] == null ? null : json["type_id"],
      animalId: json["animal_id"],
      animalType: json["animal_type"],
      animalKind: json["animal_kind"] == null ? null : json["animal_kind"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      districtId: json["district_id"],
      ilceKey: json["ilce_key"],
      sehirKey: json["sehir_key"] == null ? "" : json["sehir_key"],
      cityName: json["city_name"] == null ? "" : json["city_name"],
      countyName: json["county_name"] == null ? "" : json["county_name"],
      streetName: json["street_name"] == null ? "" : json["street_name"],
      district: json["district"] == null ? "" : json["district"],
      county: json["county"] == null ? "" : json["county"],
      city: json["city"] == null ? "" : json["city"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "content": content == null ? null : content,
        "age": age,
        "image": image == null ? null : image,
        "type_id": typeId == null ? null : typeId,
        "animal_id": animalId,
        "animal_type": animalType,
        "animal_kind": animalKind == null ? null : animalKind,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "district_id": districtId,
        "ilce_key": ilceKey,
        "sehir_key": sehirKey,
        "city_name": cityName == null ? null : cityName,
        "county_name": countyName == null ? null : countyName,
        "street_name": streetName == null ? null : streetName,
      };
}
