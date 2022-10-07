import 'dart:convert';
import 'dart:developer';

import 'package:bi_pati/Models/AdvertModel.dart';
import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Models/CategoryModel.dart';
import 'package:bi_pati/Models/City.dart';
import 'package:bi_pati/Models/DataBankView.dart';
import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/Models/NoticeCorporateModel.dart';
import 'package:bi_pati/Models/NoticeResponseModel.dart';
import 'package:bi_pati/Models/Sectors.dart';
import 'package:bi_pati/Models/Store.dart';
import 'package:bi_pati/Network/LocationService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/LoadingIndicator.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueryService {
  Future<dynamic> noticesUpdate({id}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    final response = await http.post(
        Uri.parse(BASE_URL + "/api/v1/notices/update/" + id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        },
        body: jsonEncode({"is_noticed": 1}));
  }

  Future<dynamic> videoDonation({city, county, street, type}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    String userJson = await LocalUtil().getLocalData(key: "user");
    Auth auth = AuthFromJson(userJson);
    print(jsonEncode({
      "sehir_key": city,
      "ilce_key": county,
      "is_donated": false,
      "money_count": 0,
      "district_id": street,
      "animal_type_id": type
    }));
    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/donations/create"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": token,
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
            },
            body: jsonEncode({
              "sehir_key": city,
              "ilce_key": county,
              "district_id": street,
              "animal_type_id": type,
              "is_donated": false,
              "money_count": 0,
              "user_id": auth.data.user.id
            }));
    print(response.body);
  }

  Future<dynamic> updateUser({noticeNotification, donateNotification}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    String userJson = await LocalUtil().getLocalData(key: "user");
    Auth auth = AuthFromJson(userJson);

    final response = await http.post(
        Uri.parse(
            BASE_URL + "/api/v1/users/update/" + auth.data.user.id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        },
        body: jsonEncode({
          "notice_notification": noticeNotification,
          "announcement_notification": donateNotification
        }));
  }

  Future<dynamic> getUser() async {
    String token = await LocalUtil().getLocalData(key: "token");
    String userJson = await LocalUtil().getLocalData(key: "user");
    Auth auth = AuthFromJson(userJson);
    final response = await http.get(
        Uri.parse(
            BASE_URL + "/api/v1/users/get/" + auth.data.user.id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        });
    int noticeNotification =
        jsonDecode(response.body)["data"]["data"]["notice_notification"];
    int donateNotification =
        jsonDecode(response.body)["data"]["data"]["announcement_notification"];
    return {
      "noticeNotification": noticeNotification == 1 ? true : false,
      "donateNotification": donateNotification == 1 ? true : false
    };
  }

  Future<dynamic> getHome() async {
    String token = await LocalUtil().getLocalData(key: "token");

    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/home/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    City city = await LocationService().getCity();
    List<Cities> citys = city.data.data;
    citys[0].sehirKey;
    List<dynamic> ihbarlar = jsonDecode(response.body)["data"][0];
    ihbarlar.forEach((ihbar) {
      citys.forEach((city) {
        if (ihbar["sehir_key"].toString() == city.sehirKey.toString()) {
          ihbar["sehir"] = city.sehirTitle;
        }
      });
    });
    List<dynamic> bagislar = jsonDecode(response.body)["data"][1];
    bagislar.forEach((bagis) {
      citys.forEach((city) {
        if (bagis["sehir_key"].toString() == city.sehirKey.toString()) {
          bagis["sehir"] = city.sehirTitle;
        }
      });
    });
    List<dynamic> etkinlikler = jsonDecode(response.body)["data"][2];
    etkinlikler.forEach((etkinlik) {
      citys.forEach((city) {
        if (etkinlik["location"].toString() == city.sehirKey.toString()) {
          etkinlik["sehir"] = city.sehirTitle;
        }
      });
    });
    return {
      "ihbarlar": ihbarlar,
      "bagislar": bagislar,
      "etkinlikler": etkinlikler
    };
  }

  Future<Sectors> querySectors() async {
    String token = await LocalUtil().getLocalData(key: "token");

    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/sectors/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    print(response.body);
    return Sectors.fromJson(jsonDecode(response.body));
  }

  Future<Store> queryUsers(
      {int il_key, int ilce_key, int mahalle_key, int sector_id}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Map<String, dynamic> map = new Map();
    if (il_key != null && il_key != 0) {
      map["sehir_key"] = il_key.toString();
    }
    if (ilce_key != null && ilce_key != 0) {
      map["ilce_key"] = ilce_key.toString();
    }
    if (mahalle_key != null && mahalle_key != 0) {
      map["district_id"] = mahalle_key.toString();
    }
    if (sector_id != null) {
      map["sector_id"] = sector_id.toString();
    }
    Uri uri = new Uri(
        scheme: "http",
        host: "167.99.137.5",
        path: "/api/v1/users",
        queryParameters: map);
    print(uri.toString());
    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    return Store.fromJson(jsonDecode(response.body));
  }

  Future<NoticeResponseModel> addNotice(
      {context,
      sehir_key,
      ilce_key,
      int districtId,
      image,
      imageName,
      title,
      animal_id,
      content,
      city,
      county,
      notice_type_id,
      street}) async {
    if (sehir_key == 0) {
      sehir_key = null;
    }
    String token = await LocalUtil().getLocalData(key: "token");
    String userJson = await LocalUtil().getLocalData(key: "user");
    Auth auth = AuthFromJson(userJson);
    loading(context);
    if (street == null) {
      final response =
          await http.post(Uri.parse(BASE_URL + "/api/v1/notices/create"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token,
                "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
              },
              body: jsonEncode({
                "district_id": districtId,
                //"district_name": street,
                "ext": imageName == null ? "a" : imageName,
                "image": image == null ? "a" : image,
                "animal_id": animal_id,
                "sehir_key": sehir_key,
                "ilce_key": ilce_key,
                "user_id": auth.data.user.id,
                "title": title,
                "content": content,
                //"city_name": city,
                //"county_name": county,
                "notice_type_id": notice_type_id
              }));
      Navigator.pop(context);
      print(token);
      return NoticeResponseModel.fromJson(jsonDecode(response.body));
    } else {
      final response =
          await http.post(Uri.parse(BASE_URL + "/api/v1/notices/create"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token,
                "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
              },
              body: jsonEncode({
                "district_id": districtId,
                "district_name": street,
                "ext": imageName == null ? "a" : imageName,
                "image": image == null ? "a" : image,
                "animal_id": animal_id,
                "sehir_key": sehir_key,
                "ilce_key": ilce_key,
                "title": title,
                "content": content,
                "user_id": auth.data.user.id,
                "city_name": city,
                "county_name": county,
                "notice_type_id": notice_type_id
              }));
      Navigator.pop(context);
      print(token);
      return NoticeResponseModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<EventModel> getEvents() async {
    String token = await LocalUtil().getLocalData(key: "token");
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/events/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    return EventModel.fromJson(jsonDecode(response.body));
  }

  Future<DataBankModel> getDatabank({id}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/databank?category_id=$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    return DataBankModel.fromJson(jsonDecode(response.body));
  }

  Future<CategoryModel> getDatabankCategory() async {
    String token = await LocalUtil().getLocalData(key: "token");
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/categories/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );

    return CategoryModel.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> getAnnouncements() async {
    String token = await LocalUtil().getLocalData(key: "token");
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/announcements/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );

    return CategoryModel.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateFcm(fcm) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    if (auth != null) {
      final response = await http.post(
        Uri.parse(
            BASE_URL + "/api/v1/users/update/" + auth.data.user.id.toString()),
        body: jsonEncode({"fcm_token": fcm}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        },
      );
      print(response.statusCode.toString());
    }
  }

  Future<NoticeCorporateModel> getNotice() async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/notices/my-notices"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    print(response.body);
    return NoticeCorporateModel.fromJson(jsonDecode(response.body));
  }

  Future<NoticeResponseModel> addannouncement(
      {sehir_key,
      context,
      ilce_key,
      districtId,
      image,
      imageName,
      age,
      content,
      city,
      title,
      county,
      street,
      type_id,
      animal_id,
      animal_kind}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    if (sehir_key == 0) {
      sehir_key = null;
    }
    print({
      "district_id": districtId,
      "ext": imageName,
      "image": image,
      "animal_id": animal_id,
      "sehir_key": sehir_key,
      "ilce_key": ilce_key,
      "title": title,
      //"age": age,
      "content": content,
      "city_name": city,
      "county_name": county,
      "street_name": street,
      "notice_type_id": type_id,
      "animal_kind": animal_kind
    });
    loading(context);
    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/announcements/create"),
            headers: {
              "Authorization": token,
              "Content-Type": "application/json",
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
            },
            body: jsonEncode({
              "district_id": districtId,
              "ext": imageName,
              "image": image,
              "animal_id": animal_id,
              "sehir_key": sehir_key,
              "ilce_key": ilce_key,
              "age": age,
              "content": content,
              "city_name": city,
              "age": 0,
              "county_name": county,
              "street_name": street,
              "type_id": type_id,
              "animal_kind": animal_kind
            }));
    Navigator.pop(context);
    return NoticeResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<AdvertModel> queryAnnouncements(
      {int il_key, int ilce_key, int mahalle_key, int type_id}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Map<String, dynamic> map = new Map();
    if (il_key != null && il_key != 0) {
      map["sehir_key"] = il_key.toString();
    }
    if (ilce_key != null && ilce_key != 0) {
      map["ilce_key"] = ilce_key.toString();
    }
    if (mahalle_key != null && mahalle_key != 0) {
      map["district_id"] = mahalle_key.toString();
    }

    if (type_id != null) {
      map["notice_type_id"] = type_id.toString();
    }
    Uri uri = new Uri(
        scheme: "http",
        host: "167.99.137.5",
        path: "/api/v1/announcements",
        queryParameters: map);
    print(uri.toString());
    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    return AdvertModel.fromJson(jsonDecode(response.body));
  }
}
