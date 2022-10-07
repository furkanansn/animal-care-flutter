import 'package:bi_pati/Models/CategoryModel.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'InformationBankDetailListView.dart';
import 'QueryView.dart';

class InformationBankView extends StatefulWidget {
  @override
  _InformationBankViewState createState() => _InformationBankViewState();
}

class _InformationBankViewState extends State<InformationBankView> {
  DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: primaryAppBar("Bilgi Bankası"),
      body: Padding(
        padding: const EdgeInsets.all(2.5),
        child: ListView.builder(
          itemCount: dataController.dataBank.value.length,
          itemBuilder: (context, index) {
            Category categoryModel = dataController.dataBank[index];
            return Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                categoryCard(
                  title: categoryModel.name,
                  image: "assets/4.jpg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InformationBankDetailListView(
                              categoryModel.name, categoryModel.id.toString()),
                        ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
