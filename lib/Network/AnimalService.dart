import 'dart:convert';

import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:bi_pati/Utilities/LogUtil.dart';
import 'package:http/http.dart' as http;

class AnimalService {
  Future<void> addAnimal({String animalModel}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    print("Add Animal");
    print(animalModel);

    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/animals/create"),
            headers: {
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
              "Content-Type": "application/json",
              "Authorization": token
            },
            body: animalModel);

    logger.i(response.body);
    print(response.body);
  }

  Future<void> updateAnimal({String animalModel, id}) async {
    String token = await LocalUtil().getLocalData(key: "token");
    print(animalModel);
    final response =
        await http.post(Uri.parse(BASE_URL + "/api/v1/animals/update/" + id),
            headers: {
              "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
              "Content-Type": "application/json",
              "Authorization": token
            },
            body: animalModel);

    logger.i(response.body);
    print(response.body);
  }

  Future<void> deleteAnimal({id}) async {
    String token = await LocalUtil().getLocalData(key: "token");

    final response = await http.delete(
      Uri.parse(BASE_URL + "/api/v1/animals/delete/" + id),
      headers: {
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        "Content-Type": "application/json",
        "Authorization": token
      },
    );
    print(response);
  }

  Future<List<Animal>> getAnimals() async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    final response = await http.get(
      Uri.parse(
          BASE_URL + "/api/v1/animals?user_id=" + auth.data.user.id.toString()),
      headers: {
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        "Content-Type": "application/json",
        "Authorization": token
      },
    );

    var res = jsonDecode(response.body);
    res = res['data']['data'];
    return (res as List).map((e) => Animal.fromJson(e)).toList();
  }

  Future<Animal> getAnimalById(int id) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/animals/get/" + id.toString()),
      headers: {
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        "Content-Type": "application/json",
        "Authorization": token
      },
    );

    var res = jsonDecode(response.body);
    res = res['data']['data'];
    return Animal.fromJson(res);
  }

  Future<List<dynamic>> getDiseaseSurgeyMedicine(int type) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    String url = "";
    if (type == 0) {
      url = "diseases";
    } else if (type == 1) {
      url = "operations";
    } else {
      url = "medicines";
    }
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/" + url),
      headers: {
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        "Content-Type": "application/json",
        "Authorization": token
      },
    );
    print(response.body);
    var res = jsonDecode(response.body);
    var res1 = res['data']['data'];
    int count = res["data"]["count"];
    List<dynamic> list = [];
    for (int i = 0; i < count; i++) {
      list.add(res1[i]["name"]);
    }

    //return (res as List).map((e) => Animal.fromJson(e)).toList();
    return list;
  }

  Future<String> addAnimalWithQr(String uuid) async {
    String token = await LocalUtil().getLocalData(key: "token");
    Auth auth =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/animals/getAnimal/" + uuid),
      headers: {
        "manyPawKey": "3ee#*qvsK^W!4cb85Sas6Z-#5+",
        "Content-Type": "application/json",
        "Authorization": token
      },
    );
    print(response.body);
  }
}
