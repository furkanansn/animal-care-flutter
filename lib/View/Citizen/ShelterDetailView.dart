import 'dart:async';
import 'dart:typed_data';

import 'package:bi_pati/Models/Store.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/LocationUtil.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ShelterDetailView extends StatefulWidget {
  @override
  _ShelterDetailViewState createState() => _ShelterDetailViewState();
}

class _ShelterDetailViewState extends State<ShelterDetailView> {
  SectorController sectorController = Get.find();
  String assetImagePath = "";
  String title = "";
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> customMarkers = [];
  LocationData locationModel;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(39.925533, 32.866287),
    zoom: 11,
  );

  @override
  void initState() {
    Map<String, String> variables = sectorController.getAssetImagePath();
    Future.delayed(Duration(seconds: 0), () async {
      List<LatLng> coordinates = [];
      List<Marker> markers = [];

      sectorController.store.value.forEach((element) {
        getLatLngFromAdress(
                element.sehirKey.toString(),
                element.ilceKey.toString(),
                element.districtId.toString(),
                element.street,
                element.streetNo)
            .then((value) {
          element.lat = value.latitude.toString();
          element.lng = value.longitude.toString();
          markers.add(Marker(
            markerId: MarkerId(element.id.toString()),
            position: value,
            onTap: () {
              sectorController.selectedStore.value = element;
              Navigator.pushNamed(context, "/shelter_sector_detail");
            },
          ));
          setState(() {
            customMarkers = markers;
          });
        });
      });

      LocationData locationModelBefore = await getUserLocation();

      setState(() {
        locationModel = locationModelBefore;
        //zoom: 100.151926040649414);
      });
    });
    setState(() {
      assetImagePath = variables.values.elementAt(0);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    title = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(title),
      ),
      body: Obx(() {
        if (sectorController.store.value.length == 0) {
          return Container(
            width: double.maxFinite,
            child: Card(
              elevation: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Bu Kriterlerde " + title + " Bulunmamaktadır",
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          );
        } else {
          // return makeTheList();
          return Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: false,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                  controller.animateCamera(CameraUpdate.newLatLng(
                      //LatLng(locationModel.latitude, locationModel.longitude)));
                      LatLng(37.84501, 27.83963)));
                },
                onTap: (argument) {},
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                markers: customMarkers.toSet(),
                zoomControlsEnabled: true,
              ),
              Positioned(
                  bottom: 10,
                  child: FittedBox(
                      child: SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: makeTheList())))
            ],
          );
        }
      }),
    );
  }

  Widget makeTheList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            width: MediaQuery.of(context).size.width - 40,
            child: itemShelter(context, index));
      },
      itemCount: sectorController.store.value.length,
    );
  }

  Widget itemShelter(
    BuildContext context,
    int index,
  ) {
    Size screenSize = MediaQuery.of(context).size;
    Stores store = sectorController.store.value[index];

    return GestureDetector(
      onTap: () {
        sectorController.selectedStore.value = store;
        Navigator.pushNamed(context, "/shelter_sector_detail");
      },
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: screenSize.width / 2.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    image: DecorationImage(image: AssetImage(assetImagePath)),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    store.name,
                    style: kLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    store.phoneNumber,
                    style: kLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    store.email,
                    style: kLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    store.address,
                    style: kLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
