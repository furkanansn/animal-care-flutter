import 'dart:convert';

import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Models/CategoryModel.dart';
import 'package:bi_pati/Models/DataBankView.dart';
import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataController extends GetxController {
  var events = [].obs;
  var dataBank = [].obs;
  var dataBankList = [].obs;
  var animalsPet = [].obs;
  var animalsStreet = [].obs;
  var annocements = [].obs;
  var etkinliklerHome = [].obs;
  var bagislarHome = [].obs;
  var ihbarlarHome = [].obs;

  Future<void> getHome() async {
    var data = await QueryService().getHome();
    etkinliklerHome.value = data["etkinlikler"];
    bagislarHome.value = data["bagislar"];
    ihbarlarHome.value = data["ihbarlar"];
  }

  Future<void> getEvents() async {
    EventModel data = await QueryService().getEvents();
    events.value = data.data.data;
  }

  Future<void> getDataBank({id}) async {
    DataBankModel data = await QueryService().getDatabank(id: id);
    print(data);
    dataBankList.value = data.data.data;
  }

  Future<void> getDataBankCategory() async {
    CategoryModel data = await QueryService().getDatabankCategory();
    dataBank.value = data.data.data;
  }
}
