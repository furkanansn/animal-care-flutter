import 'dart:convert';
import 'dart:developer';

import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:http/http.dart' as http;

import '../Utilities/Constants.dart';
import '../Utilities/LocalUtil.dart';

class AuthService {
  Future<Auth> login({String email, String password}) async {
    final response = await http.post(Uri.parse(BASE_URL + "/api/v1/auth/login"),
        headers: {
          "Content-Type": "application/json",
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        },
        body: jsonEncode({"email": email, "password": password}));
    print(response.body.toString());
    Auth loginModel = Auth.fromJson(jsonDecode(response.body));
    if (!loginModel.error) {
      await LocalUtil()
          .addLocalData(key: "token", value: "Bearer " + loginModel.data.token);
      await LocalUtil()
          .addLocalData(key: "user", value: AuthToJson(loginModel));
    }
    return loginModel;
  }

  Future<Auth> register(
      {String name,
      String email,
      String password,
      String phoneNumber,
      String questionsJson,
      String districtId,
      String ilce_key,
      String sehir_key,
      String taxOffice,
      String taxNumber,
      String adress,
      bool isPersonal,
      String authorizedPhone,
      String workingHours,
      String birthday,
      int sectorId,
      street,
      streetNo}) async {
    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/auth/register"),
            headers: {
              "Content-Type": "application/json",
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
            },
            body: jsonEncode({
              "name": name,
              "email": email,
              "password": password,
              "phone_number": phoneNumber,
              "questions_json": questionsJson,
              "district_id": districtId,
              "ilce_key": ilce_key,
              "sehir_key": sehir_key,
              "sector_id": sectorId,
              "tax_office": taxOffice,
              "tax_number": taxNumber,
              "address": adress,
              "is_personal": isPersonal,
              "authorized_phone": authorizedPhone,
              "working_hours": workingHours,
              "birthday": birthday,
              "street": street,
              "street_no": streetNo,
            }));
    print(response.body);
    Auth registerModel = Auth.fromJson(jsonDecode(response.body));
    if (!registerModel.error) {
      await LocalUtil().addLocalData(
          key: "isApproved",
          value: registerModel.data.user?.isApproved?.toString());
      await LocalUtil()
          .addLocalData(key: "user", value: AuthToJson(registerModel));
      await LocalUtil().addLocalData(
          key: "id", value: registerModel.data.user.id.toString());
      await LocalUtil().addLocalData(
          key: "token", value: "Bearer " + registerModel.data.token.toString());
    }
    return registerModel;
  }

  Future<void> veriftOtp() async {
    final response = await http.post(
        Uri.parse(BASE_URL + "/api/v1/auth/approve"),
        headers: {
          "Content-Type": "application/json",
          "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        },
        body: jsonEncode({"id": await LocalUtil().getLocalData(key: "id")}));
  }

  Future<Auth> resetPassword({String password}) async {
    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/auth/reset-password"),
            headers: {
              "Content-Type": "application/json",
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
            },
            body: jsonEncode({"password": password}));
    log(response.body.toString());
    Auth loginModel = Auth.fromJson(jsonDecode(response.body));
    if (!loginModel.error) {
      await LocalUtil()
          .addLocalData(key: "token", value: loginModel.data.token);
      await LocalUtil()
          .addLocalData(key: "user", value: AuthToJson(loginModel));
    }
    return loginModel;
  }
}
