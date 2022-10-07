import 'dart:developer';

import 'package:bi_pati/Models/City.dart';
import 'package:bi_pati/Models/County.dart';
import 'package:bi_pati/Models/Street.dart';
import 'package:bi_pati/Network/LocationService.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Future<LocationData> getUserLocation() async {
  LocationData myLocation;
  String error;
  Location location = new Location();
  try {
    myLocation = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      error = 'please grant permission';
      print(error);
    }
    if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
      error = 'permission denied- please enable it from app settings';
      log(error);
    }
    myLocation = null;
  }
  return myLocation;
}

Future<LocationModel> getAdressFromLocation() async {
  LocationData locationData = await getUserLocation();

  var addresses = await Geocoder.local.findAddressesFromCoordinates(
      new Coordinates(locationData.latitude, locationData.longitude));
  var first = addresses.first;
  String city = addresses.first.subAdminArea
      .substring(0, addresses.first.subAdminArea.indexOf(" "));
  String county = addresses.first.subAdminArea
      .substring(addresses.first.subAdminArea.indexOf(" ") + 1);
  log(addresses.first.addressLine
      .substring(0, addresses.first.addressLine.indexOf(",")));
  return new LocationModel.name(
      city,
      county,
      addresses.first.thoroughfare,
      addresses.first.addressLine
          .substring(0, addresses.first.addressLine.indexOf(",")));
}

Future<LatLng> getLatLngFromAdress(String il, String ilce, String mahalle,
    String sokak, String sokakNo) async {
  City city = await LocationService().getCity();
  Cities cities;
  Counties counties;
  Streeties streeties;
  city.data.data.forEach((element) {
    if (element.sehirKey.toString() == il) {
      
      cities = element;
    }
  });
  County county = await LocationService().getCounty(key: cities.sehirKey);
  county.data.data.forEach((element) {
    if (element.ilceKey.toString() == ilce) {
      
      counties = element;
    }
  });
  Street street = await LocationService().getStreet(key: counties.ilceKey);
  street.data.data.forEach((element) {
    if (element.mahalleKey.toString() == mahalle) {
      
      streeties = element;
    }
  });

  String adres = cities.sehirTitle +
      " " +
      counties.ilceTitle +
      " " +
      streeties.mahalleTitle +
      " " +
      sokak +
      " " +
      sokakNo;
  List<Address> response = await Geocoder.local.findAddressesFromQuery(adres);
  return LatLng(
      response[0].coordinates.latitude, response[0].coordinates.longitude);
}

class LocationModel {
  String city;
  String county;
  String street;
  String district;
  LocationModel.name(this.city, this.county, this.street, this.district);
}
