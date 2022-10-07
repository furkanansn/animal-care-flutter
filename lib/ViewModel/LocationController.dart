import 'package:bi_pati/Models/City.dart';
import 'package:bi_pati/Models/County.dart';
import 'package:bi_pati/Models/Street.dart';
import 'package:bi_pati/Network/LocationService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var cities = [].obs;
  var selectedCity = 0.obs;
  var county = [].obs;
  var selectedCounty;
  var street = [].obs;
  var selectedStreet;
  var loadingCity = false.obs;
  var loadingCounty = false.obs;
  var loadingStreet = false.obs;
  var stringCity = "".obs;
  var stringCounty = "".obs;
  var stringStreet = "".obs;

  Future<void> getCities({edit, editCounty, editStreet}) async {
    loadingCity.value = true;
    cities.value = [];
    print("şehir başlangıç: " + cities.value.length.toString());
    City city = await LocationService().getCity();
    cities.value
        .add(new Cities(sehirId: 0, sehirKey: 0, sehirTitle: "İl Seçiniz"));
    city.data.data.forEach((element) {
      cities.value.add(element);
    });
    print("şehir bitiş: " + cities.value.length.toString());
    selectedCity = 0.obs;
    if (edit != null) {
      int sehirKey = int.parse(edit);
      selectedCity.value = sehirKey;
      city.data.data.forEach((element) {
        if (element.sehirKey == sehirKey) {
          stringCity.value = element.sehirKey.toString();
        }
      });

      getCounty(edit: editCounty, editStreet: editStreet);
    }

    loadingCity.value = false;
  }

  Future<void> getCounty({edit, editStreet}) async {
    loadingCounty.value = true;
    county.value.clear();
    County countyData = await LocationService().getCounty(
      key: selectedCity.value,
    );
    county.value.add(new Counties(
        ilceId: 0, ilceKey: 0, ilceSehirkey: 0, ilceTitle: "İlçe Seçiniz"));
    countyData.data.data.forEach((element) {
      county.value.add(element);
    });
    selectedCounty = 0.obs;
    if (edit != null) {
      selectedCounty.value = int.parse(edit);
      Counties city =
          county.value.firstWhere((element) => element.ilce_key == edit);
      stringCounty.value = city.ilceTitle;
      selectedCounty.value = city.ilceKey;
      getStreet(edit: editStreet);
    }
    loadingCounty.value = false;
  }

 Future<void> getStreet({edit}) async {
    loadingStreet.value = true;
    street.value.clear();
    Street streetData = await LocationService().getStreet(
      key: selectedCounty.value,
    );
    street.value.add(new Streeties(
        mahalleId: 0,
        mahalleIlcekey: 0,
        mahalleKey: 0,
        mahalleTitle: "Mahalle Seçiniz"));
    streetData.data.data.forEach((element) {
      street.value.add(element);
    });
    selectedStreet = 0.obs;
    if (edit != null) {
      selectedStreet.value = int.parse(edit);
    }
    loadingStreet.value = false;
  }

  clearData() {
    county.value = null;
    selectedCounty.value = null;
    street.value = null;
    selectedStreet.value = null;
  }

  getCitiesWidget(context) {
    if (loadingCity.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'İl Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
          isExpanded: true,
          hint: Text(
            "İl Seçiniz",
            style: TextStyle(color: Colors.white),
          ),
          dialogBox: true,
          style: TextStyle(color: Colors.white),
          items: cities.value.map((e) {
            return new DropdownMenuItem(
              child: Text(e.sehirTitle),
              value: e.sehirTitle,
            );
          }).toList(),
          isCaseSensitiveSearch: false,
          onChanged: (val) {
            loadingStreet.value = true;
            Cities city =
                cities.value.firstWhere((element) => element.sehirTitle == val);
            stringCity.value = city.sehirTitle;
            selectedCity.value = city.sehirKey;
            getCounty();
          },
        ),
      );
    }
  }

  getCountyWidget(context) {
    if (loadingCounty.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'İlçe Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
          isExpanded: true,
          hint: Text(
            "İlçe Seçiniz",
            style: TextStyle(color: Colors.white),
          ),
          dialogBox: true,
          style: TextStyle(color: Colors.white),
          items: county.value.map((e) {
            return new DropdownMenuItem(
              child: Text(e.ilceTitle),
              value: e.ilceTitle,
            );
          }).toList(),
          isCaseSensitiveSearch: false,
          onChanged: (val) {
            Counties city =
                county.value.firstWhere((element) => element.ilceTitle == val);
            stringCounty.value = city.ilceTitle;
            selectedCounty.value = city.ilceKey;
            getStreet();
          },
        ),
      );
    }
  }

  getStreetWidget(context) {
    if (loadingStreet.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Mahalle Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
          isExpanded: true,
          hint: Text(
            "Mahalle Seçiniz",
            style: TextStyle(color: Colors.white),
          ),
          dialogBox: true,
          style: TextStyle(color: Colors.white),
          items: street.value.map((e) {
            return new DropdownMenuItem(
              child: Text(e.mahalleTitle),
              value: e.mahalleTitle,
            );
          }).toList(),
          isCaseSensitiveSearch: false,
          onChanged: (val) {
            Streeties city = street.value
                .firstWhere((element) => element.mahalleTitle == val);
            stringStreet.value = city.mahalleTitle;
            selectedStreet.value = city.mahalleKey;
          },
        ),
      );
    }
  }

  getCitiesEditWidget(context) {
    if (loadingCity.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'İl Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
            isExpanded: true,
            hint: Text(
              "İl Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dialogBox: true,
            style: TextStyle(color: Colors.white),
            items: cities.value.map((e) {
              return new DropdownMenuItem(
                child: Text(e.sehirTitle),
                value: e.sehirTitle,
              );
            }).toList(),
            isCaseSensitiveSearch: false,
            onChanged: (val) {
              loadingStreet.value = true;
           
              Cities city = cities.value
                  .firstWhere((element) => element.sehirTitle == val);
              stringCity.value = city.sehirTitle;
              selectedCity.value = city.sehirKey;
              getCounty();
            },
            ),
      );
    }
  }

  getCountyEditWidget(context) {
    if (loadingCounty.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'İlçe Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
            isExpanded: true,
            hint: Text(
              "İlçe Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dialogBox: true,
            style: TextStyle(color: Colors.white),
            items: county.value.map((e) {
              return new DropdownMenuItem(
                child: Text(e.ilceTitle),
                value: e.ilceTitle,
              );
            }).toList(),
            isCaseSensitiveSearch: false,
            onChanged: (val) {
              Counties city = county.value
                  .firstWhere((element) => element.ilceTitle == val);
              stringCounty.value = city.ilceTitle;
              selectedCounty.value = city.ilceKey;
              getStreet();
            },
           ),
      );
    }
  }

  getStreetEditWidget(context) {
    if (loadingStreet.value) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Mahalle Seçiniz',
            style: TextStyle(color: Colors.white),
          ),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: SearchableDropdown.single(
            isExpanded: true,
            hint: Text(
              "Mahalle Seçiniz",
              style: TextStyle(color: Colors.white),
            ),
            dialogBox: true,
            style: TextStyle(color: Colors.white),
            items: street.value.map((e) {
              return new DropdownMenuItem(
                child: Text(e.mahalleTitle),
                value: e.mahalleTitle,
              );
            }).toList(),
            isCaseSensitiveSearch: false,
            onChanged: (val) {
              Streeties city = street.value
                  .firstWhere((element) => element.mahalleTitle == val);
              stringStreet.value = city.mahalleTitle;
              selectedStreet.value = city.mahalleKey;
            },
            ),
      );
    }
  }
}
