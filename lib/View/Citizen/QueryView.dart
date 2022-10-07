import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueryView extends StatefulWidget {
  String title;
  int id;
  QueryView(String title, int id) {
    this.title = title;
    this.id = id;

  }

  @override
  _QueryViewState createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  LocationController locationController = Get.put(LocationController());
  SectorController sectorController = Get.put(SectorController());

  @override
  void initState() {
    locationController.getCities();
    sectorController.selectedSector.value = widget.id;
    super.initState();
  }

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
                Container(
                  child: RaisedButton(
                      elevation: 5.0,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      child: Text(
                        "Ara",
                        style: TextStyle(
                          color: primaryColor,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onPressed: () async {
                        await sectorController.getQueryModel(
                            il_key: locationController.selectedCity?.value,
                            ilce_key: locationController.selectedCounty?.value,
                            mahalle_key:
                                locationController.selectedStreet?.value,
                            sector_id: widget.id);
                        Navigator.pushNamed(context, "/shelter_detail",
                            arguments: widget.title);
                      }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
