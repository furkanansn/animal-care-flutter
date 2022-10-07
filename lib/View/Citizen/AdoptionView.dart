import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/View/Citizen/NoticeDetailView.dart';
import 'package:bi_pati/View/Citizen/QueryAdoptionView.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'NoticeAdvertAddView.dart';

class AdoptionView extends StatefulWidget {
  const AdoptionView({Key key}) : super(key: key);

  @override
  _AdoptionViewState createState() => _AdoptionViewState();
}

class _AdoptionViewState extends State<AdoptionView> {
  final announcementsType = 3;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(2.5),
      child: ListView(
        children: [
          SizedBox(
            height: 5,
          ),
          categoryCard(
            title: "Sahiplendir",
            image: "assets/8.jpg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticeAdvertAddView("Sahiplendir", 3),
                  ));
            },
          ),
          SizedBox(
            height: 5,
          ),
          categoryCard(
            title: "Sahiplendirme İlanları",
            image: "assets/4.jpg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QueryAdoptionView("Sahiplendirme İlanları",3),
                  ));
            },
          ),
        ],
      ),
    ));
  }
}
