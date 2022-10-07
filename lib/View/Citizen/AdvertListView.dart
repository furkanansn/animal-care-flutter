import 'package:bi_pati/Models/AdvertModel.dart';
import 'package:bi_pati/Models/DetailAnimal.dart';

import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/View/Citizen/AdvertDetailView.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:get/get.dart';

import 'EventsDetailView.dart';

class AdvertListView extends StatefulWidget {
  String name;
  String il_key;
  String ilce_key;
  String street_key;
  String type_id;

  AdvertListView(String name, String il_key, String ilce_key, String street_key,
      String type_id) {
    this.name = name;
    this.il_key = il_key;
    this.ilce_key = ilce_key;
    this.street_key = street_key;
    this.type_id = type_id;
  }
  @override
  _AdvertListViewState createState() => _AdvertListViewState();
}

class _AdvertListViewState extends State<AdvertListView> {
  DataController controller = Get.find();
  AdvertModel advertModel = AdvertModel();
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      AdvertModel advertModel = await QueryService().queryAnnouncements(
          il_key: int.tryParse(widget.il_key),
          ilce_key: int.tryParse(widget.ilce_key),
          mahalle_key: int.tryParse(widget.street_key),
          type_id: int.tryParse(widget.type_id));
      
      setState(() {
        this.advertModel = advertModel;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: primaryAppBar(widget.name),
      body: ListView.builder(
        itemCount: advertModel.data?.count == null ? 0 : advertModel.data.count,
        itemBuilder: (context, index) {
          Datum advert = advertModel.data.data[index];
          return ListTile(
              title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvertDetailView("", advert),
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.network(getImagePath(advert.image)),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            advert.content,
                            style: kLabelBlackStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            "",
                            style: kLabelBlackStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
