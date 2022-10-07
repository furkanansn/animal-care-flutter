// To parse this JSON data, do
//
//     final Auth = AuthFromJson(jsonString);

import 'dart:convert';

Auth AuthFromJson(String str) => Auth.fromJson(json.decode(str));

String AuthToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.error,
    this.errorMsg,
    this.data,
  });

  bool error;
  dynamic errorMsg;
  Data data;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
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
  Data(
      {this.token,
      this.tokenType,
      this.expiresTime,
      this.user,
      this.msg,
      this.code});

  String token;
  String tokenType;
  DateTime expiresTime;
  User user;
  String msg;
  var code;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
        expiresTime: json["expires_time"] == null
            ? null
            : DateTime.parse(json["expires_time"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        msg: json["msg"] == null ? null : json["msg"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "token_type": tokenType == null ? null : tokenType,
        "expires_time":
            expiresTime == null ? null : expiresTime.toIso8601String(),
        "user": user == null ? null : user.toJson(),
        "msg": msg == null ? null : msg,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.questionsJson,
    this.districtId,
    this.taxOffice,
    this.taxNumber,
    this.address,
    this.isPersonal,
    this.authorizedPhone,
    this.workingHours,
    this.birthday,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String phoneNumber;
  dynamic questionsJson;
  int districtId;
  dynamic taxOffice;
  dynamic taxNumber;
  dynamic address;
  int isPersonal;
  dynamic authorizedPhone;
  dynamic workingHours;
  DateTime birthday;
  int isApproved;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        questionsJson: json["questions_json"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        taxOffice: json["tax_office"],
        taxNumber: json["tax_number"],
        address: json["address"],
        isPersonal: json["is_personal"] == null ? null : json["is_personal"],
        authorizedPhone: json["authorized_phone"],
        workingHours: json["working_hours"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "questions_json": questionsJson,
        "district_id": districtId == null ? null : districtId,
        "tax_office": taxOffice,
        "tax_number": taxNumber,
        "address": address,
        "is_personal": isPersonal == null ? null : isPersonal,
        "authorized_phone": authorizedPhone,
        "working_hours": workingHours,
        "birthday": birthday == null
            ? null
            : "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "is_approved": isApproved == null ? null : isApproved,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
