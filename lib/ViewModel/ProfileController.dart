import 'dart:convert';
import 'dart:developer';

import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Models/DumpData.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:bi_pati/Widgets/CustomDetailView.dart';
import 'package:bi_pati/Widgets/MultiSelectDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProfileController extends GetxController {
  var animals = List<Animal>().obs;
  var petAnimalList = [].obs;
  var streetAnimalList = [].obs;
  var selectedAnimal = Animal().obs;
  var cityList = [].obs;
  var townList = [].obs;
  var neighborhoodList = [].obs;
  var diseasesList = [].obs;
  var medicinesList = [].obs;
  var surgeryList = [].obs;
  var weightList = [].obs;
  var typeInt = 0.obs;
  var type = "".obs;
  var kg = 0.obs;
  var openHour = 0.obs;
  var closeHour = 0.obs;
  var weight = "".obs;
  var weightId = 0.obs;
  var age = "".obs;
  var ageId = 0.obs;
  var user = Auth().obs;
  var diseaseSavedList = List<Disease>().obs;
  var surgerySavedList = List<Disease>().obs;
  var medicineSavedList = List<Disease>().obs;
  var diseaseEditList = List<Disease>().obs;
  var surgeryEditList = List<Disease>().obs;
  var medicineEditList = List<Disease>().obs;
  List<String> listOFSelectedItemDisease = [];
  List<dynamic> listOfBeginDatesDisease = [];
  List<dynamic> listOfFinishDatesDisease = [];
  List<dynamic> listOfIsContinueDisease = [];

  List<String> listOFSelectedItemSurgery = [];
  List<dynamic> listOfBeginDatesSurgery = [];
  List<dynamic> listOfFinishDatesSurgery = [];
  List<dynamic> listOfIsContinueSurgery = [];

  List<String> listOFSelectedItemMedicine = [];
  List<dynamic> listOfBeginDatesMedicine = [];
  List<dynamic> listOfFinishDatesMedicine = [];
  List<dynamic> listOfIsContinueMedicine = [];

  addAnimal(Animal animal) {
    if (animal.isPet) {
      petAnimalList.value.add(animal);
    } else {
      streetAnimalList.value.add(animal);
    }
  }

  getUser() async {
    user.value =
        Auth.fromJson(jsonDecode(await LocalUtil().getLocalData(key: "user")));
  }

  deleteAnimal(Animal animal) {
    if (animal.isPet) {
      petAnimalList.value.remove(animal);
    } else {
      streetAnimalList.value.remove(animal);
    }
  }

  Future<void> getAnimals() async {
    List<Animal> animalList = await AnimalService().getAnimals();
    animals.value.clear();
    petAnimalList.value.clear();
    streetAnimalList.value.clear();
    animals.value.add(Animal(id: "10000", name: "Hayvan Seçiniz"));
    await animalList.forEach((element) async {
      animals.value.add(element);
      print(element.name + " hayvan adı");
      if (element.isPet) {
        print(element.name);
        petAnimalList.value.add(element);
        print(petAnimalList.value.length.toString());
      } else {
        streetAnimalList.value.add(element);
      }
    });
  }

  getWorkingWidget(context) {
    List<DumpData> openHoursDataList = [
      new DumpData.name("Açılış Saati seçiniz", 0),
      new DumpData.name("01.00", 1),
      new DumpData.name("01.30", 2),
      new DumpData.name("02.00", 3),
      new DumpData.name("02.30", 4),
      new DumpData.name("03.00", 5),
      new DumpData.name("03.30", 6),
      new DumpData.name("04.30", 7),
      new DumpData.name("05.00", 8),
      new DumpData.name("05.30", 9),
      new DumpData.name("06.00", 10),
      new DumpData.name("06.30", 11),
      new DumpData.name("07.00", 12),
      new DumpData.name("07.30", 13),
      new DumpData.name("08.00", 14),
      new DumpData.name("08.30", 15),
      new DumpData.name("09.00", 16),
      new DumpData.name("09.30", 17),
      new DumpData.name("10.00", 18),
      new DumpData.name("10.30", 19),
      new DumpData.name("11.00", 20),
      new DumpData.name("11.30", 21),
      new DumpData.name("12.00", 22),
      new DumpData.name("12.30", 23),
      new DumpData.name("13.00", 24),
      new DumpData.name("13.30", 25),
      new DumpData.name("14.00", 26),
      new DumpData.name("14.30", 27),
      new DumpData.name("15.00", 28),
      new DumpData.name("15.30", 29),
      new DumpData.name("16.00", 30),
      new DumpData.name("16.30", 31),
      new DumpData.name("17.00", 33),
      new DumpData.name("17.30", 34),
      new DumpData.name("18.00", 35),
      new DumpData.name("18.30", 36),
      new DumpData.name("19.00", 37),
      new DumpData.name("19.30", 38),
      new DumpData.name("20.00", 39),
      new DumpData.name("20.30", 40),
      new DumpData.name("21.00", 41),
      new DumpData.name("21.30", 42),
      new DumpData.name("22.00", 43),
      new DumpData.name("22.30", 44),
      new DumpData.name("23.00", 45),
      new DumpData.name("23.30", 46),
      new DumpData.name("00.00", 47),
    ];

    List<DumpData> closeHoursdataList = [
      new DumpData.name("Kapanış Saati seçiniz", 0),
      new DumpData.name("01.00", 1),
      new DumpData.name("01.30", 2),
      new DumpData.name("02.00", 3),
      new DumpData.name("02.30", 4),
      new DumpData.name("03.00", 5),
      new DumpData.name("03.30", 6),
      new DumpData.name("04.30", 7),
      new DumpData.name("05.00", 8),
      new DumpData.name("05.30", 9),
      new DumpData.name("06.00", 10),
      new DumpData.name("06.30", 11),
      new DumpData.name("07.00", 12),
      new DumpData.name("07.30", 13),
      new DumpData.name("08.00", 14),
      new DumpData.name("08.30", 15),
      new DumpData.name("09.00", 16),
      new DumpData.name("09.30", 17),
      new DumpData.name("10.00", 18),
      new DumpData.name("10.30", 19),
      new DumpData.name("11.00", 20),
      new DumpData.name("11.30", 21),
      new DumpData.name("12.00", 22),
      new DumpData.name("12.30", 23),
      new DumpData.name("13.00", 24),
      new DumpData.name("13.30", 25),
      new DumpData.name("14.00", 26),
      new DumpData.name("14.30", 27),
      new DumpData.name("15.00", 28),
      new DumpData.name("15.30", 29),
      new DumpData.name("16.00", 30),
      new DumpData.name("16.30", 31),
      new DumpData.name("17.00", 33),
      new DumpData.name("17.30", 34),
      new DumpData.name("18.00", 35),
      new DumpData.name("18.30", 36),
      new DumpData.name("19.00", 37),
      new DumpData.name("19.30", 38),
      new DumpData.name("20.00", 39),
      new DumpData.name("20.30", 40),
      new DumpData.name("21.00", 41),
      new DumpData.name("21.30", 42),
      new DumpData.name("22.00", 43),
      new DumpData.name("22.30", 44),
      new DumpData.name("23.00", 45),
      new DumpData.name("23.30", 46),
      new DumpData.name("00.00", 47),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Çalışma Saatleri",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: kBoxDecorationStyle,
              child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                    "Açılış Saati",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  dropdownColor: Colors.black,
                  focusColor: Colors.black,
                  items: openHoursDataList.map((e) {
                    return new DropdownMenuItem(
                      child: Text(e.hastalikTitle),
                      value: e.hastalikId,
                    );
                  }).toList(),
                  onChanged: (val) {
                    openHour.value = val;
                  },
                  value: openHour.value),
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: kBoxDecorationStyle,
              child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                    "Kapanış Saati",
                    style: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: Colors.black,
                  focusColor: Colors.black,
                  style: TextStyle(color: Colors.white),
                  items: closeHoursdataList.map((e) {
                    return new DropdownMenuItem(
                      child: Text(e.hastalikTitle),
                      value: e.hastalikId,
                    );
                  }).toList(),
                  onChanged: (val) {
                    closeHour.value = val;
                  },
                  value: closeHour.value),
            ))
          ],
        ),
      ],
    );
  }

  getDiseaseSurgeryMedicine() async {
    diseasesList.value = await AnimalService().getDiseaseSurgeyMedicine(0);
    surgeryList.value = await AnimalService().getDiseaseSurgeyMedicine(1);
    medicinesList.value = await AnimalService().getDiseaseSurgeyMedicine(2);
  }

  getDiseaseSurgeryMedicineWidget(context, int type) {
    if (type == 0) {
      if (diseaseEditList.value.isNotEmpty &&
          listOFSelectedItemDisease.isEmpty) {
        diseaseEditList.forEach((element) {
          listOFSelectedItemDisease.add(element.name);
          listOfBeginDatesDisease.add(element.beginDate);
          listOfFinishDatesDisease.add(element.endDate);
          listOfIsContinueDisease.add(element.isContinue);
        });
      } else {
        if (diseasesList.value.isNotEmpty) {
          diseasesList.value.forEach((element) {
            listOfBeginDatesDisease.add("");
            listOfFinishDatesDisease.add("");
            listOfIsContinueDisease.add(false);
          });
        }
      }

      return MultiselectDropDown(
        context: context,
        listOfBeginDates: listOfBeginDatesDisease,
        listOfFinishDates: listOfFinishDatesDisease,
        listOfIsContinue: listOfIsContinueDisease,
        listOfSelectedItem: listOFSelectedItemDisease,
        name: "Hastalıklar",
        selectedList: (value) {
          if (diseaseEditList.value.isNotEmpty) {
            diseaseEditList.value = value;
          } else {
            diseaseSavedList.value = value;
          }
        },
      );
    } else if (type == 1) {
      if (surgeryEditList.value.isNotEmpty &&
          listOFSelectedItemSurgery.isEmpty) {
        surgeryEditList.forEach((element) {
          listOFSelectedItemSurgery.add(element.name);
          listOfBeginDatesSurgery.add(element.beginDate);
          listOfFinishDatesSurgery.add(element.endDate);
          listOfIsContinueSurgery.add(element.isContinue);
        });
      } else {
        if (surgeryList.value.isNotEmpty) {
          surgeryList.value.forEach((element) {
            listOfBeginDatesSurgery.add("");
            listOfFinishDatesSurgery.add("");
            listOfIsContinueSurgery.add(false);
          });
        }
      }
      return MultiselectDropDown(
        context: context,
        listOfBeginDates: listOfBeginDatesSurgery,
        listOfFinishDates: listOfFinishDatesSurgery,
        listOfIsContinue: listOfIsContinueSurgery,
        listOfSelectedItem: listOFSelectedItemSurgery,
        name: "Ameliyatlar",
        selectedList: (value) {
          if (surgeryEditList.value.isNotEmpty) {
            surgeryEditList.value = value;
          } else {
            surgerySavedList.value = value;
          }
        },
      );
    } else {
      if (medicineEditList.value.isNotEmpty &&
          listOFSelectedItemMedicine.isEmpty) {
        medicineEditList.forEach((element) {
          listOFSelectedItemMedicine.add(element.name);
          listOfBeginDatesMedicine.add(element.beginDate);
          listOfFinishDatesMedicine.add(element.endDate);
          listOfIsContinueMedicine.add(element.isContinue);
        });
      } else {
        if (medicinesList.value.isNotEmpty) {
          medicinesList.value.forEach((element) {
            listOfBeginDatesMedicine.add("");
            listOfFinishDatesMedicine.add("");
            listOfIsContinueMedicine.add(false);
          });
        }
      }
      return MultiselectDropDown(
        context: context,
        listOfBeginDates: listOfBeginDatesMedicine,
        listOfFinishDates: listOfFinishDatesMedicine,
        listOfIsContinue: listOfIsContinueMedicine,
        listOfSelectedItem: listOFSelectedItemMedicine,
        name: "İlaçlar",
        selectedList: (value) {
          if (medicineEditList.value.isNotEmpty) {
            medicineEditList.value = value;
          } else {
            medicineSavedList.value = value;
          }
        },
      );
    }
  }

  getAgeWidget(context) {
    List<DumpData> turler = [];
    DumpData a = new DumpData();
    a.hastalikTitle = "Yaş Seçiniz";
    a.hastalikId = 0;
    DumpData d = new DumpData();
    d.hastalikTitle = "0-2";
    d.hastalikId = 1;
    DumpData d1 = new DumpData();
    d1.hastalikTitle = "2-4";
    d1.hastalikId = 2;
    DumpData d2 = new DumpData();
    d2.hastalikTitle = "4-6";
    d2.hastalikId = 3;
    DumpData d3 = new DumpData();
    d3.hastalikTitle = "6+";
    d3.hastalikId = 4;
    turler.add(a);
    turler.add(d);
    turler.add(d1);
    turler.add(d2);
    turler.add(d3);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //decoration: kBoxDecorationStyle,
      child: DropdownButton(
        style: TextStyle(color: Colors.white),
        isExpanded: true,
        hint: Text(
          "Yaş Seçiniz",
          style: TextStyle(color: Colors.white),
        ),
        items: turler.map((e) {
          return new DropdownMenuItem(
            child: Text(
              e.hastalikTitle,
              style: TextStyle(color: Colors.black),
            ),
            value: e.hastalikId,
          );
        }).toList(),
        onChanged: (val) {
          ageId.value = val;
          turler.forEach((element) {
            if (element.hastalikId == val) {
              age.value = element.hastalikTitle;
            }
          });
        },
        value: ageId.value,
      ),
    );
  }

  GetWeightOfAnimal(String weight) {
    List<DumpData> turler = [];
    DumpData a = new DumpData();
    a.hastalikTitle = "Kilo Seçiniz";
    a.hastalikId = 0;
    DumpData d = new DumpData();
    d.hastalikTitle = "0-2";
    d.hastalikId = 1;
    DumpData d1 = new DumpData();
    d1.hastalikTitle = "2-4";
    d1.hastalikId = 2;
    DumpData d2 = new DumpData();
    d2.hastalikTitle = "4-6";
    d2.hastalikId = 3;
    DumpData d3 = new DumpData();
    d3.hastalikTitle = "6-8";
    d3.hastalikId = 4;
    DumpData d4 = new DumpData();
    d4.hastalikTitle = "8-10";
    d4.hastalikId = 5;
    DumpData d5 = new DumpData();
    d5.hastalikTitle = "10+";
    d5.hastalikId = 6;
    turler.add(a);
    turler.add(d);
    turler.add(d1);
    turler.add(d2);
    turler.add(d3);
    turler.add(d4);
    turler.add(d5);
    turler.forEach((element) {
      if (element.hastalikTitle == weight) {
        weightId.value = element.hastalikId;
        weight = element.hastalikTitle;
      }
    });
  }

  getWeightWidget(context) {
    List<DumpData> turler = [];
    DumpData a = new DumpData();
    a.hastalikTitle = "Kilo Seçiniz";
    a.hastalikId = 0;
    DumpData d = new DumpData();
    d.hastalikTitle = "0-2";
    d.hastalikId = 1;
    DumpData d1 = new DumpData();
    d1.hastalikTitle = "2-4";
    d1.hastalikId = 2;
    DumpData d2 = new DumpData();
    d2.hastalikTitle = "4-6";
    d2.hastalikId = 3;
    DumpData d3 = new DumpData();
    d3.hastalikTitle = "6-8";
    d3.hastalikId = 4;
    DumpData d4 = new DumpData();
    d4.hastalikTitle = "8-10";
    d4.hastalikId = 5;
    DumpData d5 = new DumpData();
    d5.hastalikTitle = "10+";
    d5.hastalikId = 6;
    turler.add(a);
    turler.add(d);
    turler.add(d1);
    turler.add(d2);
    turler.add(d3);
    turler.add(d4);
    turler.add(d5);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //decoration: kBoxDecorationStyle,
      child: DropdownButton(
        style: TextStyle(color: Colors.white),
        isExpanded: true,
        hint: Text(
          "Kilo Seçiniz",
          style: TextStyle(color: Colors.white),
        ),
        items: turler.map((e) {
          return new DropdownMenuItem(
            child: Text(
              e.hastalikTitle,
              style: TextStyle(color: Colors.black),
            ),
            value: e.hastalikId,
          );
        }).toList(),
        onChanged: (val) {
          weightId.value = val;
          turler.forEach((element) {
            if (element.hastalikId == val) {
              weight.value = element.hastalikTitle;
            }
          });
        },
        value: weightId.value,
      ),
    );
  }

  getAnimalTypesWidget(context, {value}) {
    List<DumpData> turler = [];
    DumpData a = new DumpData();
    a.hastalikTitle = "Tür Seçiniz";
    a.hastalikId = 0;
    DumpData d = new DumpData();
    d.hastalikTitle = "Köpek";
    d.hastalikId = 1;
    DumpData d1 = new DumpData();
    d1.hastalikTitle = "Kedi";
    d1.hastalikId = 2;
    turler.add(a);
    turler.add(d);
    turler.add(d1);
    if (value != null) {
      print(value.toString() + "hayvan türü");
      if (value is String) {
        typeInt.value = int.tryParse(value);
      } else {
        typeInt.value = value;
      }

      turler.forEach((element) {
        if (element.hastalikId == value) {
          type.value = element.hastalikId.toString();
          print(type.value + " hayvan");
        }
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //decoration: kBoxDecorationStyle,
      child: DropdownButton(
        style: TextStyle(color: Colors.white),
        isExpanded: true,
        hint: Text(
          "Tür Seçiniz",
          style: TextStyle(color: Colors.white),
        ),
        items: turler.map((e) {
          return new DropdownMenuItem(
            child: Text(
              e.hastalikTitle,
              style: TextStyle(color: Colors.black),
            ),
            value: e.hastalikId,
          );
        }).toList(),
        onChanged: (val) {
          typeInt.value = val;
          turler.forEach((element) {
            if (element.hastalikId == val) {
              type.value = element.hastalikId.toString();
            }
          });
        },
        value: typeInt.value,
      ),
    );
  }
}
