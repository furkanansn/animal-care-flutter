// To parse this JSON data, do
//
//     final noticeResponseModel = noticeResponseModelFromJson(jsonString);

import 'dart:convert';

NoticeResponseModel noticeResponseModelFromJson(String str) =>
    NoticeResponseModel.fromJson(json.decode(str));

String noticeResponseModelToJson(NoticeResponseModel data) =>
    json.encode(data.toJson());

class NoticeResponseModel {
  NoticeResponseModel({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  NoticeResponseModelData data;

  factory NoticeResponseModel.fromJson(Map<String, dynamic> json) =>
      NoticeResponseModel(
        error: json["error"] == null ? null : json["error"],
        errorMsg: json["errorMsg"],
        data: json["data"] == null
            ? null
            : NoticeResponseModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "errorMsg": errorMsg,
        "data": data == null ? null : data.toJson(),
      };
}

class NoticeResponseModelData {
  NoticeResponseModelData({
    this.data,
    this.msg,
  });

  DataData data;
  String msg;

  factory NoticeResponseModelData.fromJson(Map<String, dynamic> json) =>
      NoticeResponseModelData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "msg": msg == null ? null : msg,
      };
}

class DataData {
  DataData({
    this.districtId,
    this.image,
    this.sehirKey,
    this.ilceKey,
    this.title,
    this.content,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  dynamic districtId;
  String image;
  int sehirKey;
  int ilceKey;
  String title;
  String content;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        districtId: json["district_id"] == null ? null : json["district_id"],
        image: json["image"] == null ? null : json["image"],
        sehirKey: json["sehir_key"] == null ? null : json["sehir_key"],
        ilceKey: json["ilce_key"] == null ? null : json["ilce_key"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId == null ? null : districtId,
        "image": image == null ? null : image,
        "sehir_key": sehirKey == null ? null : sehirKey,
        "ilce_key": ilceKey == null ? null : ilceKey,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
