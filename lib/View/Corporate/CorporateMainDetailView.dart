import 'package:bi_pati/Models/NoticeCorporateModel.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/View/Corporate/CorporateMainView.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';

class CorporateMainDetailView extends StatelessWidget {
  Datum datum;
  String title;
  bool ilgilenildi;
  CorporateMainDetailView(String title, Datum datum, {bool ilgilenildi}) {
    this.title = title;
    this.datum = datum;
    this.ilgilenildi = ilgilenildi;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: primaryAppBar(title),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(getImagePath(datum.image)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "İhbar Başlık: " + datum.title,
                          style: kLabelBlackStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "İhbar Tarihi: " + datum.noticedTime,
                          style: kLabelBlackStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "İhbar Yeri: " + datum.adres,
                          style: kLabelBlackStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "İhbar Açıklaması: " + datum.content,
                          style: kLabelBlackStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ilgilenildi != null
                ? Container()
                : Container(
                    width: screenSize.width * 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: RaisedButton(
                        elevation: 5.0,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.white,
                        child: Text(
                          "İlgileniyorum",
                          style: TextStyle(
                            //color: Color(0xFF527DAA),
                            color: primaryColor,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        onPressed: () async {
                          await QueryService().noticesUpdate(id: datum.id);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CorporateMainView(),
                              ),
                              (route) => false);
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
