// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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

  List<Event> data;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Event {
  Event({
    this.id,
    this.title,
    this.content,
    this.eventDate,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  int id;
  String title;
  String content;
  String eventDate;
  String location;
  dynamic createdAt;
  dynamic updatedAt;
  List<Gallery> galleries;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        eventDate:
            json["event_date"] == null ? null : json["event_date"].toString(),
        location: json["location"] == null ? null : json["location"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        galleries: json["galleries"] == null
            ? null
            : List<Gallery>.from(
                json["galleries"].map((x) => Gallery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "event_date": eventDate == null ? null : eventDate.toString(),
        "location": location == null ? null : location,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "galleries": galleries == null
            ? null
            : List<dynamic>.from(galleries.map((x) => x.toJson())),
      };
}

String getDateString(String date) {}

class Gallery {
  Gallery({
    this.id,
    this.photo,
    this.noticeId,
    this.animalId,
    this.blogId,
    this.createdAt,
    this.updatedAt,
    this.eventId,
  });

  int id;
  String photo;
  dynamic noticeId;
  dynamic animalId;
  dynamic blogId;
  dynamic createdAt;
  dynamic updatedAt;
  int eventId;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        noticeId: json["notice_id"],
        animalId: json["animal_id"],
        blogId: json["blog_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        eventId: json["event_id"] == null ? null : json["event_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "notice_id": noticeId,
        "animal_id": animalId,
        "blog_id": blogId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "event_id": eventId == null ? null : eventId,
      };
}
