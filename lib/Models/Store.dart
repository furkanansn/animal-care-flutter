// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  StoreData data;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        error: json["error"] == null ? null : json["error"],
        errorMsg: json["errorMsg"],
        data: json["data"] == null ? null : StoreData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "errorMsg": errorMsg,
        "data": data == null ? null : data.toJson(),
      };
}

class StoreData {
  StoreData({
    this.data,
    this.count,
  });

  List<Stores> data;
  int count;

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
        data: json["data"] == null
            ? null
            : List<Stores>.from(json["data"].map((x) => Stores.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Stores {
  Stores(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.phoneNumber,
      this.questionsJson,
      this.districtId,
      this.ilceKey,
      this.sehirKey,
      this.taxOffice,
      this.taxNumber,
      this.address,
      this.isPersonal,
      this.authorizedPhone,
      this.workingHours,
      this.birthday,
      this.isApproved,
      this.deletedAt,
      this.lastActivity,
      this.registerIp,
      this.lastLoginIp,
      this.userAgent,
      this.lastLoginTime,
      this.fcmToken,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.sectorId,
      this.street,
      this.streetNo});

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String phoneNumber;
  dynamic questionsJson;
  int districtId;
  int ilceKey;
  String street;
  String streetNo;
  String lat;
  String lng;
  int sehirKey;
  String taxOffice;
  String taxNumber;
  String address;
  int isPersonal;
  String authorizedPhone;
  String workingHours;
  dynamic birthday;
  int isApproved;
  dynamic deletedAt;
  String lastActivity;
  String registerIp;
  String lastLoginIp;
  dynamic userAgent;
  String lastLoginTime;
  dynamic fcmToken;
  DateTime createdAt;
  DateTime updatedAt;
  int sectorId;

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        questionsJson: json["questions_json"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        sehirKey: json["sehir_key"] == null ? null : json["sehir_key"],
        ilceKey: json["ilce_key"] == null ? null : json["ilce_key"],
        street: json["street"] == null ? null : json["street"],
        streetNo: json["street_no"] == null ? null : json["street_no"],
        taxOffice: json["tax_office"] == null ? null : json["tax_office"],
        taxNumber: json["tax_number"] == null ? null : json["tax_number"],
        address: json["address"] == null ? null : json["address"],
        isPersonal: json["is_personal"] == null ? null : json["is_personal"],
        authorizedPhone:
            json["authorized_phone"] == null ? null : json["authorized_phone"],
        workingHours:
            json["working_hours"] == null ? null : json["working_hours"],
        birthday: json["birthday"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
        deletedAt: json["deleted_at"],
        lastActivity:
            json["last_activity"] == null ? null : json["last_activity"],
        registerIp: json["register_ip"] == null ? null : json["register_ip"],
        lastLoginIp:
            json["last_login_ip"] == null ? null : json["last_login_ip"],
        userAgent: json["user_agent"],
        lastLoginTime:
            json["last_login_time"] == null ? null : json["last_login_time"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sectorId: json["sector_id"] == null ? null : json["sector_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "questions_json": questionsJson,
        "district_id": districtId == null ? null : districtId,
        "tax_office": taxOffice == null ? null : taxOffice,
        "tax_number": taxNumber == null ? null : taxNumber,
        "address": address == null ? null : address,
        "is_personal": isPersonal == null ? null : isPersonal,
        "authorized_phone": authorizedPhone == null ? null : authorizedPhone,
        "working_hours": workingHours == null ? null : workingHours,
        "birthday": birthday,
        "is_approved": isApproved == null ? null : isApproved,
        "deleted_at": deletedAt,
        "last_activity": lastActivity == null ? null : lastActivity,
        "register_ip": registerIp == null ? null : registerIp,
        "last_login_ip": lastLoginIp == null ? null : lastLoginIp,
        "user_agent": userAgent,
        "last_login_time": lastLoginTime == null ? null : lastLoginTime,
        "fcm_token": fcmToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "sector_id": sectorId == null ? null : sectorId,
      };
}
