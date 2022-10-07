import 'package:bi_pati/Models/AdvertModel.dart';
import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Models/EventModel.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';

class AdvertDetailView extends StatefulWidget {
  String title;
  Datum datum;

  AdvertDetailView(String title, Datum datum) {
    this.title = title;
    this.datum = datum;
  }

  @override
  State<AdvertDetailView> createState() => _AdvertDetailViewState();
}

class _AdvertDetailViewState extends State<AdvertDetailView> {
  Animal animal = Animal();
  List<String> hastalikAdi = [];

  List<String> ameliyatAdi = [];

  List<String> ilaclaAdi = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      animal = await AnimalService().getAnimalById(widget.datum.animalId);

      animal.diseases.forEach((element) {
        hastalikAdi.add(element.name.toString() +
            " - " +
            element.beginDate.toString() +
            " - " +
            element.endDate.toString() +
            " - " +
            (element.isContinue == true ? "Devam Ediyor" : "Devam Etmiyor") +
            "\n");
      });
      animal.surgeries.forEach((element) {
        ameliyatAdi.add(element.name.toString() +
            " - " +
            element.beginDate.toString() +
            " - " +
            element.endDate.toString() +
            " - " +
            (element.isContinue == true ? "Devam Ediyor" : "Devam Etmiyor") +
            "\n");
      });
      animal.medicines.forEach((element) {
        ilaclaAdi.add(element.name.toString() +
            " - " +
            element.beginDate.toString() +
            " - " +
            element.endDate.toString() +
            " - " +
            (element.isContinue == true ? "Devam Ediyor" : "Devam Etmiyor") +
            "\n");
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(""),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image.network(getImagePath(widget.datum.image)),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(
                            getImagePath(animal.image),
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Adı: " + animal.name,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Doğum Tarihi: " + animal.birthday,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Ameliyatları: \n" + ameliyatAdi.join(""),
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Hastalıklar: \n" + hastalikAdi.join(""),
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "İlaçlar: \n" + ilaclaAdi.join(""),
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Kilo: " + animal.weight,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Açıklama: " + widget.datum.content,
                      style: kLabelBlackStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Adres: " + getAdress(widget.datum),
                      style: kLabelBlackStyle,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getAdress(Datum datum) {
  String adres = "";

  if (datum.sehirKey != null) {
    adres = datum.city["sehir_title"] +
        " " +
        datum.county["ilce_title"] +
        " " +
        datum.district["mahalle_title"];
  } else {
    adres = datum.cityName + " " + datum.countyName + " " + datum.streetName;
  }

  return adres == null ? "" : adres;
}
