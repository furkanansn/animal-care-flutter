import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Utilities/Firebase/PushNotificationsManager.dart';
import 'package:bi_pati/View/Citizen/AddAnimalView.dart';
import 'package:bi_pati/View/Citizen/AdoptionView.dart';
import 'package:bi_pati/View/Citizen/HomeView.dart';
import 'package:bi_pati/View/Citizen/NoticeView.dart';
import 'package:bi_pati/View/Citizen/ProfilView.dart';
import 'package:bi_pati/View/Citizen/StoreView.dart';
import 'package:bi_pati/View/QrCode.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SpecialBottomNavBar extends StatefulWidget {
  int index;
  SpecialBottomNavBar({int index}) {
    this.index = index;
  }
  @override
  _SpecialBottomNavBarState createState() => _SpecialBottomNavBarState();
}

class _SpecialBottomNavBarState extends State<SpecialBottomNavBar> {
  @override
  ProfileController profileController = Get.put(ProfileController());
  SectorController sectorController = Get.put(SectorController());
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
      fontFamily: "OpenSans", fontWeight: FontWeight.bold, fontSize: 30);
  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    StoreView(),
    NoticeView(),
    AdoptionView(),
    ProfilView(),
  ];
  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index;
      });
    }
    sectorController.getQueryModel();
    profileController.getUser();
    notificationOnForeground(context);

    super.initState();
  }

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
        centerTitle: true,
        title: Text(
          "Many Paw",
          style: TextStyle(
            color: primaryColor,
            fontFamily: 'OpenSans',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Align(
          alignment: Alignment(3.5, 0),
          child: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.bars, color: primaryColor),
                ),
              );
            },
          ),
        ),
        actions: [
          _selectedIndex == 4
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 14,
                      top: 5,
                    ),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("Hayvan Ekle"),
                                actions: [
                                  CupertinoButton(
                                      child: Text("Evcil Hayvanı"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddAnimalView(1, "p"),
                                            ));
                                      }),
                                  CupertinoButton(
                                      child: Text("Sokak Hayvanı"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddAnimalView(0, "p"),
                                            ));
                                      }),
                                /*
                                  CupertinoButton(
                                      child: Text("Qr Kod İle"),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        String cameraScanResult =
                                            await Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner(),));

                                        await AnimalService()
                                            .addAnimalWithQr(cameraScanResult);
                                        showSuccess(context);
                                      }),
                                */
                                ],
                              );
                            },
                          );
                          //Navigator.pushNamed(context, "/profile_animal");
                        },
                        child: Text(
                          "🐶🐱",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                )
              : Container()
        ],
        titleSpacing: 0,
        backgroundColor: Colors.white,
      ),
      drawer: primaryDrawer(context),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: primarySecondColor,
        selectedItemColor: primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icon/home.png"),
            ),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Lokasyonlar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: "İhbar",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icon/sahiplendirme.png"),
            ),
            label: "Sahiplendirme",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.paw),
            label: "Hayvanlarım",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
