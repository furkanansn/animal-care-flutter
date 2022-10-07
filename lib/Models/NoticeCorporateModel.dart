// To parse this JSON data, do
//
//     final noticeCorporateModel = noticeCorporateModelFromJson(jsonString);

import 'dart:convert';

NoticeCorporateModel noticeCorporateModelFromJson(String str) =>
    NoticeCorporateModel.fromJson(json.decode(str));

String noticeCorporateModelToJson(NoticeCorporateModel data) =>
    json.encode(data.toJson());

class NoticeCorporateModel {
  NoticeCorporateModel({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory NoticeCorporateModel.fromJson(Map<String, dynamic> json) =>
      NoticeCorporateModel(
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
  Datum({
    this.id,
    this.animalId,
    this.userId,
    this.districtId,
    this.image,
    this.isNoticed,
    this.noticedTime,
    this.forwardWho,
    this.title,
    this.content,
    this.noticeTypeId,
    this.viewCount,
    this.createdAt,
    this.updatedAt,
    this.sehirKey,
    this.adres,
    this.ilceKey,
  });

  int id;
  int animalId;
  int userId;
  int districtId;
  String image;
  int isNoticed;
  dynamic noticedTime;
  int forwardWho;
  String title;
  String content;
  int noticeTypeId;
  int viewCount;
  String adres;
  dynamic createdAt;
  dynamic updatedAt;
  int sehirKey;
  int ilceKey;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        animalId: json["animal_id"] == null ? null : json["animal_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        image: json["image"] == null ? null : json["image"],
        isNoticed: json["is_noticed"] == null ? null : json["is_noticed"],
        noticedTime: json["noticed_time"] == null ? "" : json["noticed_time"],
        forwardWho: json["forward_who"] == null ? null : json["forward_who"],
        title: json["title"] == null ? null : json["title"],
        adres: json["address"] == null ? "" : json["address"],
        content: json["content"] == null ? null : json["content"],
        noticeTypeId:
            json["notice_type_id"] == null ? null : json["notice_type_id"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sehirKey: json["sehir_key"] == null ? null : json["sehir_key"],
        ilceKey: json["ilce_key"] == null ? null : json["ilce_key"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "animal_id": animalId == null ? null : animalId,
        "user_id": userId == null ? null : userId,
        "district_id": districtId == null ? null : districtId,
        "image": image == null ? null : image,
        "is_noticed": isNoticed == null ? null : isNoticed,
        "noticed_time": noticedTime,
        "forward_who": forwardWho == null ? null : forwardWho,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "notice_type_id": noticeTypeId == null ? null : noticeTypeId,
        "view_count": viewCount == null ? null : viewCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sehir_key": sehirKey == null ? null : sehirKey,
        "ilce_key": ilceKey == null ? null : ilceKey,
      };
}
