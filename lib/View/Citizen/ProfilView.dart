import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/View/Citizen/ProfileAnimalView.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'EditAnimalView.dart';

class ProfilView extends StatefulWidget {
  @override
  _ProfilView createState() => _ProfilView();
}

class _ProfilView extends State<ProfilView> with TickerProviderStateMixin {
  bool selectedPetAnimal = true;
  bool selectedStreetAnimal = false;
  ProfileController profileController = Get.find();
  TabController tabController;
  GlobalKey globalKey = new GlobalKey();
  @override
  void initState() {
    profileController.getAnimals().then((value) {
      setState(() {});
    });
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, primaryColor])),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoButton(
                                borderRadius: BorderRadius.circular(5),
                                padding: EdgeInsets.all(15.0),
                                color: (selectedPetAnimal)
                                    ? Colors.orangeAccent
                                    : Colors.white,
                                child: Text(
                                  "Evcil\nHayvanlarım",
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (selectedPetAnimal) {
                                    } else {
                                      selectedPetAnimal = !selectedPetAnimal;
                                      selectedStreetAnimal =
                                          !selectedStreetAnimal;
                                      tabController.index = 0;
                                    }
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CupertinoButton(
                                borderRadius: BorderRadius.circular(5),
                                padding: EdgeInsets.all(15.0),
                                color: (selectedStreetAnimal)
                                    ? Colors.orangeAccent
                                    : Colors.white,
                                child: Text(
                                  "Sokak\nHayvanlarım",
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (selectedStreetAnimal) {
                                    } else {
                                      selectedPetAnimal = !selectedPetAnimal;
                                      selectedStreetAnimal =
                                          !selectedStreetAnimal;
                                    }

                                    tabController.index = 1;
                                  });
                                }),
                          ),
                        ],
                      )),
                  Container(
                    height: screenSize.height * 0.65,
                    width: screenSize.width,
                    child: DefaultTabController(
                      length: 1,
                      child: TabBarView(
                        controller: tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [getPets(), getStreet()],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget getPets() {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      bottom: true,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: profileController.petAnimalList.value.length,
        itemBuilder: (context, index) {
          Animal data = profileController.petAnimalList.value[index];
          return InkWell(
            onTap: () {
              tappedForEdit(data);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenSize.width / 2.7,
                      height: screenSize.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(getImagePath(
                                data.image == null ? "" : data.image))),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Adı: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.name,
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Cinsi: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.kind == 2 ? "Kedi" : "Köpek",
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Doğum Tarihi: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.birthday.toString(),
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getStreet() {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      bottom: true,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: profileController.streetAnimalList.value.length,
        itemBuilder: (context, index) {
          Animal data = profileController.streetAnimalList.value[index];
          return InkWell(
            onTap: () {
              tappedForEdit(data);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenSize.width / 2.7,
                      height: screenSize.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(getImagePath(
                                data.image == null ? "" : data.image))),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Adı: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.name,
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Cinsi: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.kind == 2 ? "Kedi" : "Köpek",
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Doğum Tarihi: ",
                            style: kLabelStyle,
                          ),
                          Text(
                            data.birthday.toString(),
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void tappedForEdit(Animal animal) {
    //TODO: get qr kod
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoButton(
              child: Text("Görüntüle/Düzenle"),
              onPressed: () {
                Navigator.pop(context);
                profileController.selectedAnimal.value = animal;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAnimalView(1),
                    ));
              },
            ),
            /*
            CupertinoButton(
              child: Text("Qr Kodu"),
              onPressed: () {
                Navigator.pop(context);
                showGeneralDialog(
                  context: context,
                  barrierColor:
                      Colors.black12.withOpacity(0.6), // background color
                  barrierDismissible:
                      false, // should dialog be dismissed when tapped outside
                  barrierLabel: "label", // label for barrier
                  transitionDuration: Duration(
                      milliseconds:
                          400), // how long it takes to popup dialog after button click
                  pageBuilder: (_, __, ___) {
                    return Scaffold(
                      appBar: primaryAppBar("Hayvanımın Qr Kodu"),
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFFFFFFFF),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: RepaintBoundary(
                                key: globalKey,
                                child: QrImage(
                                  embeddedImage: AssetImage("assets/logo2.png"),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: Size(50, 40),
                                  ),
                                  data: animal.uuid,
                                  size: MediaQuery.of(context).size.height / 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),*/
          ],
        );
      },
    );
  }
}
