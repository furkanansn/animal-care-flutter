import 'package:bi_pati/Models/NoticeCorporateModel.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CorporateMainDetailView.dart';

class CorporateMainView extends StatefulWidget {
  @override
  _CorporateMainViewState createState() => _CorporateMainViewState();
}

class _CorporateMainViewState extends State<CorporateMainView> {
  List<Datum> data = [];
  List<Datum> dataIlgilenilenler = [];
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      NoticeCorporateModel res = await QueryService().getNotice();
      res.data.data.forEach((element) {
        dataIlgilenilenler.add(element);
        data.add(element);
      });

      data.removeWhere((element) => element.isNoticed == 1);
      dataIlgilenilenler.removeWhere((element) => element.isNoticed == 0);
      

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
          centerTitle: true,
          title: Text(
            "İhbarlar",
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'OpenSans',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          leading: Align(
            alignment: Alignment(3.5, 0),
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () async {
                    await LocalUtil().clearLocalData();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/firs_page", (route) => false);
                  },
                  child: IconButton(
                    icon:
                        Icon(FontAwesomeIcons.signOutAlt, color: primaryColor),
                  ),
                );
              },
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                "Bekleyenler",
                style: labelStyle,
              ),
            ),
            Tab(
              child: Text(
                "İlgilenilenler",
                style: labelStyle,
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [bekleyenler(), ilgilenilenler()],
        ),
      ),
    );
  }

  Widget bekleyenler() {
    return data == null || data.isEmpty
        ? Center(
            child: Text("Şuan da size yönlendirilen ihbar bulunmamaktadır"),
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              Datum datum = data[index];
              return ListTile(
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CorporateMainDetailView("İhbar Detay", datum)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Image.network(getImagePath(
                                datum.image == null ? "" : datum.image)),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Text(
                                  "İhbar Başlık: " + datum.title,
                                  style: kLabelBlackStyle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Text(
                                  "İhbar Tarihi: " + datum?.noticedTime,
                                  style: kLabelBlackStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget ilgilenilenler() {
    return dataIlgilenilenler == null || dataIlgilenilenler.isEmpty
        ? Center(
            child: Text("Şuan da size yönlendirilen ihbar bulunmamaktadır"),
          )
        : ListView.builder(
            itemCount: dataIlgilenilenler.length,
            itemBuilder: (context, index) {
              Datum datum = dataIlgilenilenler[index];
              return ListTile(
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CorporateMainDetailView(
                                  "İhbar Detay",
                                  datum,
                                  ilgilenildi: true,
                                )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Image.network(getImagePath(
                                datum.image == null ? "" : datum.image)),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Text(
                                  "İhbar Başlık: " + datum.title,
                                  style: kLabelBlackStyle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Text(
                                  "İhbar Tarihi: " + datum?.noticedTime,
                                  style: kLabelBlackStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
