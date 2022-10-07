import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ShelterAnimalDetailView extends StatefulWidget {
  @override
  _ShelterAnimalDetailViewState createState() =>
      _ShelterAnimalDetailViewState();

}


class _ShelterAnimalDetailViewState extends State<ShelterAnimalDetailView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: AppBar(
        title: Center(
            child: Text(
          "\tİzmir Barınağı \n 30 Kedi - 60 Köpek - 10 Kuş - (12 Engelli)",
          style: TextStyle(fontFamily: "kLabelStyle"),
        )),
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        return getBody();
      }),
    );
  }

  Widget getBody() {
    return ListView(
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/animal_detail");
            },
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 400,
                        height: 240,
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: shadowList,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/animals/caddy2.jpg'),
                                            fit: BoxFit.cover)),
                                    margin: EdgeInsets.only(top: 50),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 60,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                    color: primaryWhite,
                                    boxShadow: shadowList,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Tekir",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Van Kedisi",
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "24.01.2001 - 5 AYLIK",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("348 GÜNDÜR BARINAKTA",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
          Divider(
            color: Colors.grey,
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  Container(
                    width: 400,
                    height: 240,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: shadowList,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/animals/caddy2.png'))),
                                margin: EdgeInsets.only(top: 50),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 60,
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                                color: primaryWhite,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Column(
                                children: [
                                  Text(
                                    "Tekir",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Van Kedisi",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "24.01.2001 - 5 AYLIK",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("348 GÜNDÜR BARINAKTA",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /*Container(
                          width: 140,
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage("assets/animals/caddy.png"),
                                  fit: BoxFit.cover)),
                        ),*/

                  /* Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Tekir",
                                style: TextStyle(fontSize: 18, ),

                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "VAN KEDİSİ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text(
                                "24.01.2001 - 5 AYLIK",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text("348 GÜNDÜR BARINAKTA",
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                            ),
                          ],
                        )*/
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ]),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
