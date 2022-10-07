import 'package:bi_pati/Utilities/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Color primaryColor = Color(0xff132137);
final Color primarySecondColor = Color(0Xff2874A6);
final primaryGradientColors = [
  Colors.orange,
  Colors.orangeAccent,
  Colors.deepOrange,
  Colors.deepOrangeAccent
];
final Color primaryShadowColor = Colors.orange.shade300;
final Color primaryGreen = Color(0xff416d6d);
final Color primaryWhite = Colors.white;
final Color primaryboxcolor = Colors.blueGrey[300];

final List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey, blurRadius: 40, offset: Offset(20, 20))
];

class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/8.jpg"},
  {"image": "assets/animals/caddy.jpg"},
  {"image": "assets/animals/caddy3.jpg"},
];
ClipRRect categoryCard({String image, String title, Function press}) {
  return ClipRRect(
    child: Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(title, style: kTextStyle2),
                  trailing: IconButton(
                    icon: Icon(FontAwesomeIcons.chevronRight,
                        color: Colors.white),
                    onPressed: press,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

ClipRRect categoryStoreCard(
    {String image, String title, Function press, String count}) {
  return ClipRRect(
    child: Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: ListTile(
                title: Text(title, style: kTextStyle2),
                trailing: Container(
                  width: 90,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(count, style: kLabelStyle),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.chevronRight,
                              color: Colors.black),
                          onPressed: press,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    ),
  );
}
