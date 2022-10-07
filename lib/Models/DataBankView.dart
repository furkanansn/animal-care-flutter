// To parse this JSON data, do
//
//     final dataBankModel = dataBankModelFromJson(jsonString);

import 'dart:convert';

DataBankModel dataBankModelFromJson(String str) => DataBankModel.fromJson(json.decode(str));

String dataBankModelToJson(DataBankModel data) => json.encode(data.toJson());

class DataBankModel {
    DataBankModel({
        this.error,
        this.errorMsg,
        this.data,
    });

    bool error;
    dynamic errorMsg;
    Data data;

    factory DataBankModel.fromJson(Map<String, dynamic> json) => DataBankModel(
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

    List<DataBank> data;
    int count;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? null : List<DataBank>.from(json["data"].map((x) => DataBank.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
    };
}

class DataBank {
    DataBank({
        this.id,
        this.title,
        this.content,
        this.viewCount,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String title;
    String content;
    int viewCount;
    int categoryId;
    dynamic createdAt;
    dynamic updatedAt;

    factory DataBank.fromJson(Map<String, dynamic> json) => DataBank(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "view_count": viewCount == null ? null : viewCount,
        "category_id": categoryId == null ? null : categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
