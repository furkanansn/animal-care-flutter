import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bi_pati/Models/Store.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';

class ShelterSectorDetailView extends StatefulWidget {
  @override
  _ShelterSectorDetailViewState createState() =>
      _ShelterSectorDetailViewState();
}

class _ShelterSectorDetailViewState extends State<ShelterSectorDetailView> {
  SectorController sectorController = Get.find();
  String assetImagePath = "";
  String title = "";

  @override
  void initState() {
    Map<String, String> variables = sectorController.getAssetImagePath();
    setState(() {
      assetImagePath = variables.values.elementAt(0);
      title = variables.values.elementAt(1);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: primaryAppBar(title),
        body: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Image.asset(assetImagePath),
                  Container(
                    width: screenSize.width / 1.5,
                    height: screenSize.height * 0.06,
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      sectorController.selectedStore.value.name,
                      style: kTextStyle2,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenSize.width / 2.05,
                        height: screenSize.height * 0.153,
                        margin: EdgeInsets.only(bottom: 20.0, left: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          sectorController.selectedStore.value.email,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 15,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Container(
                        width: screenSize.width / 2.08,
                        height: screenSize.height * 0.153,
                        margin: EdgeInsets.only(bottom: 20.0, left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          sectorController.selectedStore.value.phoneNumber,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 15,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ],
                  ),
                  Container(
                    width: screenSize.width / 1,
                    height: screenSize.height * 0.125,
                    margin: EdgeInsets.only(bottom: 20.0, right: 2, left: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      sectorController.selectedStore.value.address,
                      style: kTextStyle2,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenSize.width / 1.7,
                        height: screenSize.height * 0.06,
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          "Çalışma Saatleri",
                          style: kTextStyle2,
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: screenSize.width / 2.37,
                              height: screenSize.height * 0.05,
                              margin: EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: primaryColor,
                              ),
                              child: Center(
                                  child: Text(
                                "Açılış",
                                style: kTextStyle2,
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                          Container(
                            width: screenSize.width / 2.37,
                            height: screenSize.height * 0.05,
                            margin: EdgeInsets.only(bottom: 10.0, left: 45),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              "Kapanış",
                              style: kTextStyle2,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: screenSize.width / 5.5,
                            height: screenSize.height * 0.05,
                            margin: EdgeInsets.only(bottom: 15.0, left: 45),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "09.00",
                              style: kTextStyle2,
                              textAlign: TextAlign.center,
                            )),
                          ),
                          Container(
                            width: screenSize.width / 5.5,
                            height: screenSize.height * 0.05,
                            margin: EdgeInsets.only(bottom: 15.0, left: 140),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "18.00",
                              style: kTextStyle2,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                      Container(
                        width: screenSize.width / 2.3,
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: primaryColor,
                            child: Text(
                              "Haritalarda Aç",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
