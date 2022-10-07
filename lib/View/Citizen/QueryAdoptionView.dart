import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AdvertListView.dart';

class QueryAdoptionView extends StatefulWidget {
  String title;
  int id;
  QueryAdoptionView(String title, int id) {
    this.title = title;
    this.id = id;
  }

  @override
  _QueryAdoptionViewState createState() => _QueryAdoptionViewState();
}

class _QueryAdoptionViewState extends State<QueryAdoptionView> {
  LocationController locationController = Get.put(LocationController());
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: primaryAppBar(widget.title),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ListView(
                children: [
                  locationController.getCitiesWidget(context),
                  SizedBox(
                    height: 15,
                  ),
                  locationController.getCountyWidget(context),
                  SizedBox(
                    height: 15,
                  ),
                  locationController.getStreetWidget(context),
                  SizedBox(
                    height: 15,
                  ),
                  profileController.getAnimalTypesWidget(context),
                  SizedBox(
                    height: 15,
                  ),
                  //profileController.getAgeWidget(context),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: RaisedButton(
                        elevation: 5.0,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.white,
                        child: Text(
                          "İlan Ara",
                          style: TextStyle(
                            color: primaryColor,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdvertListView(
                                      widget.title,
                                      locationController.selectedCity?.value
                                          .toString(),
                                      locationController.selectedCounty?.value
                                          .toString(),
                                      locationController.selectedStreet?.value
                                          .toString(),
                                      widget.id.toString())));
                        }),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
