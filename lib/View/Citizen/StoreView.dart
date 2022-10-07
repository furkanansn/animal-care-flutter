import 'dart:ui';
import 'package:bi_pati/Models/Store.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:bi_pati/View/Citizen/QueryView.dart';
import 'package:flutter/material.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:get/get.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key key}) : super(key: key);

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  SectorController sectorController = Get.put(SectorController());

  @override
  void initState() {
    sectorController.getSectors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return Container(
        height: screenSize.height / 1,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "DERNEKLER",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Dernekler", 6),
                          ));
                    },
                    count: getCountNumber(6)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "VETERİNER",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Veteriner", 3),
                          ));
                    },
                    count: getCountNumber(3)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "BARINAKLAR",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Barınaklar", 7),
                          ));
                    },
                    count: getCountNumber(7)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "KUAFÖRLER",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Kuaförler", 8),
                          ));
                    },
                    count: getCountNumber(8)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "HAYVAN OTELLERİ",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QueryView("Hayvan Otelleri", 4),
                          ));
                    },
                    count: getCountNumber(4)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "HAYVAN EĞİTİM \n MERKEZLERİ",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QueryView("Hayvan Eğitim Merkezleri", 9),
                          ));
                    },
                    count: getCountNumber(9)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "PET TAXİLER",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Pet Taxiler", 10),
                          ));
                    },
                    count: getCountNumber(10)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "PARKLAR",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("Parklar", 11),
                          ));
                    },
                    count: getCountNumber(11)),
                SizedBox(
                  height: 5,
                ),
                categoryStoreCard(
                    title: "PET SHOPLAR",
                    image: "assets/8.jpg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QueryView("PETSHOPLAR", 12),
                          ));
                    },
                    count: getCountNumber(12)),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String getCountNumber(int sectorId) {
    print(sectorController.store.value.length.toString());
    try {
      List<Stores> data = sectorController.store.value;
      int count = 0;
      data.forEach((element) {
        if (element.sectorId != null) {
          if (element.sectorId == sectorId) {
            count = count + 1;
          }
        }
      });
      return count.toString();
    } catch (e) {
      return "0";
    }
  }
}
