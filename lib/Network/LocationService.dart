import 'dart:convert';

import 'package:bi_pati/Models/City.dart';
import 'package:bi_pati/Models/County.dart';
import 'package:bi_pati/Models/Street.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<City> getCity() async {
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/cities/"),
      headers: {
        "Content-Type": "application/json",
        "manyPawKey" : "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );
    return City.fromJson(jsonDecode(response.body));
  }

  Future<County> getCounty({int key}) async {
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/cities/ilce/" + key.toString()),
      headers: {
        "Content-Type": "application/json",
        "manyPawKey" : "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );

    return County.fromJson(jsonDecode(response.body));
  }

  Future<Street> getStreet({int key}) async {
    final response = await http.get(
      Uri.parse(BASE_URL + "/api/v1/cities/mahalle/" + key.toString()),
      headers: {
        "Content-Type": "application/json",
        "manyPawKey" : "3ee#*qvsK^W!4cb85Sas6Z-#5+",
      },
    );

    return Street.fromJson(jsonDecode(response.body));
  }
}
