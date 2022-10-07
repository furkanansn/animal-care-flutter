// To parse this JSON data, do
//
//     final animalModel = animalModelFromJson(jsonString);

import 'dart:convert';

import 'package:bi_pati/Utilities/ImageUtil.dart';

AnimalModel animalModelFromJson(String str) =>
    AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) => json.encode(data.toJson());

class AnimalModel {
  AnimalModel({
    this.animals,
  });

  List<Animal> animals;

  factory AnimalModel.fromJson(Map<String, dynamic> json) => AnimalModel(
        animals: json["animals"] == null
            ? null
            : List<Animal>.from(json["animals"].map((x) => Animal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "animals": animals == null
            ? null
            : List<dynamic>.from(animals.map((x) => x.toJson())),
      };
}

class Animal {
  Animal(
      {this.id,
      this.sehir_key,
      this.ilce_key,
      this.streetId,
      this.takeOwnership,
      this.imageModel,
      this.wetNurse,
      this.image,
      this.ext,
      this.weight,
      this.name,
      this.type,
      this.birthday,
      this.isPet,
      this.diseases,
      this.medicines,
      this.surgeries,
      this.report,
      this.passport,
      this.mahalle_key,
      this.others,
      this.uuid,
      this.kind});
  String id;
  int takeOwnership;
  ImageModel imageModel;
  int wetNurse;
  String image;
  String ext;
  String weight;
  String name;
  dynamic kind;
  dynamic type;
  String birthday;
  String streetId;
  String uuid;
  bool isPet;
  String sehir_key;
  String ilce_key;
  String mahalle_key;
  List<Disease> diseases;
  List<Disease> medicines;
  List<Disease> surgeries;
  List<Other> report;
  List<Other> passport;
  List<Other> others;

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        sehir_key: json["sehir_key"].toString(),
        ilce_key: json["ilce_key"].toString(),
        mahalle_key:json["mahalle_key"].toString(),
        streetId: json["district_id"].toString(),
        id: json["id"] == null ? null : json["id"].toString(),
        takeOwnership:
            json["takeOwnerShip"] == null ? null : json["takeOwnership"],
        wetNurse: json["wetNurse"] == null ? null : json["wetNurse"],
        image: json["image"] == null ? null : json["image"],
        ext: json["ext"] == null ? null : json["ext"],
        weight: json["weight"] == null ? null : json["weight"],
        name: json["name"] == null ? null : json["name"],
        type: json["kind"] == null ? null : json["kind"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        kind: json["kind"] == null ? null : json["kind"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        isPet: json["is_pet"] == 1 ? true : false,
        diseases: json["sickness_json"] == null
            ? null
            : List<Disease>.from(
                json["sickness_json"].map((x) => Disease.fromJson(x))),
        medicines: json["drugs_used_json"] == null
            ? null
            : List<Disease>.from(
                json["drugs_used_json"].map((x) => Disease.fromJson(x))),
        surgeries: json["surgeries_json"] == null
            ? null
            : List<Disease>.from(
                json["surgeries_json"].map((x) => Disease.fromJson(x))),
        report: json["report_sheet_json"] == null
            ? null
            : List<Other>.from(
                json["report_sheet_json"].map((x) => Other.fromJson(x))),
        passport: json["passport_sheet_json"] == null
            ? null
            : List<Other>.from(
                json["passport_sheet_json"].map((x) => Other.fromJson(x))),
        others: json["other_docs_json"] == null
            ? null
            : List<Other>.from(
                json["other_docs_json"].map((x) => Other.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "takeOwnerShip": takeOwnership == null ? null : takeOwnership,
        "wetNurse": wetNurse == null ? null : wetNurse,
        "image": image == null ? null : image,
        "ext": ext == null ? null : ext,
        "mahalle_key" : mahalle_key == null ? null : mahalle_key,
        "weight": weight == null ? null : weight,
        "name": name == null ? null : name,
        "sehir_key": sehir_key == null ? null : sehir_key,
        "ilce_key": ilce_key == null ? null : ilce_key,
        "district_id": streetId == null ? null : streetId,
        "kind": type == null ? null : type,
        "birthday": birthday == null ? null : birthday,
        "is_pet": isPet == null ? null : isPet,
        "sickness_json": diseases == null
            ? null
            : List<dynamic>.from(diseases.map((x) => x.toJson())),
        "drugs_used_json": medicines == null
            ? null
            : List<dynamic>.from(medicines.map((x) => x.toJson())),
        "surgeries_json": surgeries == null
            ? null
            : List<dynamic>.from(surgeries.map((x) => x.toJson())),
        "report_sheet_json": report == null
            ? null
            : List<dynamic>.from(report.map((x) => x.toJson())),
        "passport_sheet_json": passport == null
            ? null
            : List<dynamic>.from(passport.map((x) => x.toJson())),
        "other_docs_json": others == null
            ? null
            : List<dynamic>.from(others.map((x) => x.toJson())),
      };
}

class Disease {
  Disease({this.name, this.beginDate, this.endDate, this.isContinue});

  String name;
  String beginDate;
  String endDate;
  bool isContinue;

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        name: json["name"] == null ? "" : json["name"],
        beginDate: json["beginDate"] == null ? "" : json["beginDate"],
        endDate: json["endDate"] == null ? "" : json["endDate"],
        isContinue: json["isContinue"] == null ? false : json["isContinue"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "beginDate": beginDate == null ? null : beginDate,
        "endDate": endDate == null ? null : endDate,
        "isContinue": isContinue == null ? null : isContinue,
      };
}

class Other {
  Other({
    this.image,
    this.ext,
  });

  String image;
  String ext;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        image: json["imageUrl"] == null ? null : json["imageUrl"],
        ext: json["ext"] == null ? null : json["ext"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "ext": ext == null ? null : ext,
      };
}
