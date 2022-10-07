import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/View/Citizen/VideoDonationView.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'DonatesDetailViews.dart';

class DonatesViews extends StatelessWidget {
  const DonatesViews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar("Bağışlar"),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Column(
              children: [
                SizedBox(height: 5,),
                categoryCard(
                  title: "Video Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoDonationView(),
                      ));},
                ),
                SizedBox(height: 5,),
                categoryCard(
                  title: "Mama Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonatesDetailViews("Mama Bağış"),
                      ));},
                ),
                SizedBox(height: 5,),
                categoryCard(
                  title: "Dernek Veteriner Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonatesDetailViews("Dernek Veteriner Bağış"),
                      ));},
                ),
                SizedBox(height: 5,),
                categoryCard(
                  title: "Sağlık Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonatesDetailViews("Sağlık Bağış"),
                      ));},
                ),
                SizedBox(height: 5,),
                categoryCard(
                  title: "Barınak Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonatesDetailViews("Barınak Bağış"),
                      ));},
                ),
                SizedBox(height: 5,),
                categoryCard(
                  title: "Destek Bağış",
                  image: "assets/8.jpg",
                  press: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonatesDetailViews("Destek Bağış"),
                      ));},
                ),

              ],
            ),
          )
          )
    );
  }
}
