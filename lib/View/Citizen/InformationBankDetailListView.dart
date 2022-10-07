import 'package:bi_pati/Models/DataBankView.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:bi_pati/Models/CategoryModel.dart';
import 'InformationBankDetailView.dart';

class InformationBankDetailListView extends StatefulWidget {
  String title;
  String id;

  InformationBankDetailListView(String title, String id) {
    this.title = title;
    this.id = id;
  }

  @override
  _InformationBankDetailListViewState createState() =>
      _InformationBankDetailListViewState();
}

class _InformationBankDetailListViewState
    extends State<InformationBankDetailListView> {
  DataController dataController = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      dataController.getDataBank(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: primaryAppBar(widget.title),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(2.5),
            child: ListView.builder(
              itemCount: dataController.dataBankList.value.length,
              itemBuilder: (context, index) {
                DataBank dataBank = dataController.dataBankList[index];
                return Column(
                  children: [
                    SizedBox(height: 5),
                    categoryCard(
                      title: dataBank.title,
                      image: "assets/8.jpg",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InformationBankDetailView(
                                 dataBank.title,dataBank.content),
                            ));
                      },
                    ),
                  ],
                );
              },
            ),
          );
        }));
  }
}
