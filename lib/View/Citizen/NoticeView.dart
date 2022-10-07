import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/View/Citizen/NoticeAdvertAddView.dart';
import 'package:bi_pati/View/Citizen/NoticeDetailView.dart';
import 'package:bi_pati/View/Citizen/QueryAdvertView.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'QueryAdoptionView.dart';

class NoticeView extends StatefulWidget {
  const NoticeView({Key key}) : super(key: key);

  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
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
              title: "Yaralı Hayvan İhbarı",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeDetailView("Yaralı Hayvan İhbarı"),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Kayıp Hayvan İhbarı",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeDetailView("Kayıp Hayvan İhbarı"),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Tehlikeli Hayvan İhbarı",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeDetailView("Tehlikeli Hayvan İhbarı"),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Kayıp İlanı Ver",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeAdvertAddView("Kayıp İlanı Ver",2),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Kayıp İlanları",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QueryAdvertView("Kayıp İlanları",2),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Kan İlanı Ver",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeAdvertAddView("Kan İlanı Ver",1),
                    ));
              },
            ),
            SizedBox(
              height: 5,
            ),
            categoryCard(
              title: "Kan İlanları",
              image: "assets/8.jpg",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QueryAdvertView("Kan İlanları",1),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
