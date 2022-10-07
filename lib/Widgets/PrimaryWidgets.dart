import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:bi_pati/View/Citizen/DonatesViews.dart';
import 'package:bi_pati/View/Citizen/EventsView.dart';
import 'package:bi_pati/View/Citizen/HomeView.dart';
import 'package:bi_pati/View/Citizen/InformationBankView.dart';
import 'package:bi_pati/View/Citizen/NoticeView.dart';
import 'package:bi_pati/View/Citizen/SettingsView.dart';
import 'package:bi_pati/View/Citizen/SpecialBottomNavBar.dart';
import 'package:bi_pati/View/Citizen/StoreView.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget kare({String text, context}) {
  Size screenSize = MediaQuery.of(context).size;
  Orientation orientation = MediaQuery.of(context).orientation;
  return Container(
      width: screenSize.width / 3.5,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.fromBorderSide(BorderSide(
          color: Color.fromARGB(255, 235, 235, 235),
          width: 2,
          style: BorderStyle.solid,
        )),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 70,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          /*  Image.asset(
            image,
            fit: BoxFit.fitHeight,
          ),*/
          Container(
              width: 160,
              height: screenSize.height / 9,
              child: Center(
                  child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ))),
        ],
      ));
}

showSuccess(context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Başarıyla Eklendi")));
}
showEditSuccess(context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Başarıyla Düzenlendi")));
}

Widget primaryAppBar(String text, {bool isBackButtonEnabled}) {
  return AppBar(
      toolbarHeight: 68,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
          color: primaryColor,
          fontFamily: 'OpenSans',
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      leading: isBackButtonEnabled == null
          ? Align(
              alignment: Alignment(3.5, 0),
              child: Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: IconButton(
                      icon:
                          Icon(FontAwesomeIcons.arrowLeft, color: primaryColor),
                    ),
                  );
                },
              ),
            )
          : Align(
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
                      icon: Icon(FontAwesomeIcons.signOutAlt,
                          color: primaryColor),
                    ),
                  );
                },
              ),
            ));
}

Widget primaryDrawer(context) {
  return Drawer(
      child: Column(
    children: [
      UserAccountsDrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/logo1.png"))),
      ),
      Expanded(
        child: ListView(
          padding: EdgeInsets.only(bottom: 12),
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialBottomNavBar(
                          index: 0,
                        ),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Anasayfa",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialBottomNavBar(
                          index: 1,
                        ),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Lokasyonlar",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialBottomNavBar(
                          index: 2,
                        ),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "İhbar",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialBottomNavBar(
                          index: 3,
                        ),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Sahiplendir",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialBottomNavBar(
                          index: 4,
                        ),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Hayvanlarım",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformationBankView(),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Bilgi Bankası",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsView(),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Etkinlikler",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonatesViews(),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(FontAwesomeIcons.donate),
                  title: Text(
                    "Bağışlar",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ));
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.settings),
                  title: Text(
                    "Ayarlar",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
            InkWell(
                onTap: () async {
                  await LocalUtil().clearLocalData();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                },
                splashColor: primaryColor,
                child: ListTile(
                  //leading: Icon(Icons.logout),
                  title: Text(
                    "Çıkış Yap",
                    style: TextStyle(
                        fontFamily: "OpenSans", fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.chevron_right),
                )),
          ],
        ),
      )
    ],
  ));
}
