import 'package:bi_pati/Models/Sectors.dart';
import 'package:bi_pati/Models/Store.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectorController extends GetxController {
  var sectors = [].obs;
  var selectedSector = 0.obs;
  var loadingSector = false.obs;
  var store = [].obs;
  var selectedStore = Stores().obs;
  getQueryModel(
      {int il_key, int ilce_key, int mahalle_key, int sector_id}) async {
    store.value.clear();
    Store storeModel = await QueryService().queryUsers(
        il_key: il_key,
        sector_id: sector_id,
        ilce_key: ilce_key,
        mahalle_key: mahalle_key);

    store.value = storeModel.data.data;
  }

  getSectors() async {
    sectors.value.clear();
    loadingSector.value = true;
    Sectors sectorData = new Sectors();
    sectorData.data = new Data();
    sectorData.data.data = [];
    sectorData.data.data.add(InstanceOfSector(name: "Sektör Seçiniz", id: 0));
    Sectors newsec = await QueryService().querySectors();
    newsec.data.data.forEach((element) {
      sectorData.data.data.add(element);
    });
    sectors.value = sectorData.data.data;
    loadingSector.value = false;
  }

  getSectorsWidget(context) {
    if (loadingSector.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Sektör seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Sektör seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          items: sectors.value.map((e) {
            return new DropdownMenuItem(
              child: Text(e.name),
              value: e.id,
            );
          }).toList(),
          onChanged: (val) {
            selectedSector.value = val;
          },
          value: (selectedSector?.value),
        ),
      );
    }
  }

  Map<String, String> getAssetImagePath() {
    String assetImagePath = "";
    String title = "";
    if (selectedSector.value == 6) {
      assetImagePath = "assets/icon/dernek.png";
      title = "Dernekler";
    } else if (selectedSector.value == 3) {
      assetImagePath = "assets/icon/veteriner.png";
      title = "Veteriner";
    } else if (selectedSector.value == 7) {
      assetImagePath = "assets/icon/barinak.png";
      title = "Barınaklar";
    } else if (selectedSector.value == 8) {
      assetImagePath = "assets/icon/kuafor.png";
      title = "Kuaförler";
    } else if (selectedSector.value == 4) {
      assetImagePath = "assets/icon/hayvanoteli.png";
      title = "Hayvan Otelleri";
    } else if (selectedSector.value == 9) {
      assetImagePath = "assets/icon/egitim.png";
      title = "Hayvan Eğitim Merkezleri";
    } else if (selectedSector.value == 10) {
      assetImagePath = "assets/icon/pettaxi.png";
      title = "Pet Taxiler";
    } else if (selectedSector.value == 11) {
      assetImagePath = "assets/icon/park.png";
      title = "Parklar";
    } else if (selectedSector.value == 12) {
      assetImagePath = "assets/icon/petshop.png";
      title = "Pet Shop";
    }
    return {"assetImagePath": assetImagePath, "title": title};
  }
}
