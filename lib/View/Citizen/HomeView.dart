import 'dart:ui';

import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _scrollController = new ScrollController();
  ProfileController profileController = Get.find();
  DataController dataController = Get.put(DataController());

  @override
  void initState() {
    dataController.getHome();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(viewportFraction: 0.877);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(body: Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[300],
                    boxShadow: shadowList),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: "OpenSans"),
                                      text: "Merhaba ",
                                      children: [
                                        /*
                                        
                                        */
                                        TextSpan(
                                            text: profileController
                                                    .user.value.data?.user?.name
                                                    .substring(
                                                        0,
                                                        profileController
                                                                .user
                                                                .value
                                                                .data
                                                                ?.user
                                                                ?.name
                                                                .indexOf(" ") +
                                                            1)
                                                    .capitalizeFirst +
                                                profileController
                                                    .user.value.data?.user?.name
                                                    .substring(profileController
                                                            .user
                                                            .value
                                                            .data
                                                            ?.user
                                                            ?.name
                                                            .indexOf(" ") +
                                                        1)
                                                    .capitalizeFirst +
                                                " 👋 🐶",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "OpenSans"))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[300],
                    boxShadow: shadowList),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Bugün " +
                                        dataController.bagislarHome.length
                                            .toString() +
                                        " adet hayvan beslemesi yapıldı.",
                                    style: kLabelBlackStyle),
                                Container(
                                  height: screenSize.height * 0.3,
                                  margin: EdgeInsets.only(top: 16),
                                  child: dataController.bagislarHome.length == 0
                                      ? getEmptyWidget(1)
                                      : ListView.builder(
                                          itemCount: dataController
                                              .bagislarHome.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 8),
                                              width: screenSize.width / 1.19,
                                              height: screenSize.height / 6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9.6),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://cataas.com/cat/cute?${index.toString()}")),
                                              ),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                    bottom: 19.2,
                                                    left: 19.2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.8),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaY: 19.2,
                                                                sigmaX: 19.2),
                                                        child: Container(
                                                          height: 36,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.72,
                                                                  right: 14.4),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  'assets/svg/icon_location.svg'),
                                                              SizedBox(
                                                                width: 9.52,
                                                              ),
                                                              Text(
                                                                dataController
                                                                        .bagislarHome[
                                                                    index]["sehir"],
                                                                style:
                                                                    kTextStyle,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[300],
                    boxShadow: shadowList),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Bugün " +
                                        dataController.ihbarlarHome.length
                                            .toString() +
                                        " adet ihbara müdahale edildi.",
                                    style: kLabelBlackStyle),
                                Container(
                                  height: screenSize.height * 0.3,
                                  margin: EdgeInsets.only(top: 16),
                                  child: dataController.ihbarlarHome.length == 0
                                      ? getEmptyWidget(2)
                                      : ListView.builder(
                                          itemCount: dataController
                                              .ihbarlarHome.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 8),
                                              width: screenSize.width / 1.19,
                                              height: screenSize.height / 6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9.6),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://cataas.com/cat/cute?${index.toString()}")),
                                              ),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                    bottom: 19.2,
                                                    left: 19.2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.8),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaY: 19.2,
                                                                sigmaX: 19.2),
                                                        child: Container(
                                                          height: 36,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.72,
                                                                  right: 14.4),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  'assets/svg/icon_location.svg'),
                                                              SizedBox(
                                                                width: 9.52,
                                                              ),
                                                              Text(
                                                                dataController
                                                                        .ihbarlarHome[
                                                                    index]["sehir"],
                                                                style:
                                                                    kTextStyle,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[300],
                    boxShadow: shadowList),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Bugün " +
                                        dataController.etkinliklerHome.length
                                            .toString() +
                                        " adet etkinlik oluşturuldu.",
                                    style: kLabelBlackStyle),
                                Container(
                                  height: screenSize.height * 0.3,
                                  margin: EdgeInsets.only(top: 16),
                                  child: dataController
                                              .etkinliklerHome.length ==
                                          0
                                      ? getEmptyWidget(3)
                                      : ListView.builder(
                                          itemCount: dataController
                                              .etkinliklerHome.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 8),
                                              width: screenSize.width / 1.19,
                                              height: screenSize.height / 6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9.6),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://cataas.com/cat/cute?${index.toString()}")),
                                              ),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned(
                                                    bottom: 19.2,
                                                    left: 19.2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.8),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaY: 19.2,
                                                                sigmaX: 19.2),
                                                        child: Container(
                                                          height: 36,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.72,
                                                                  right: 14.4),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  'assets/svg/icon_location.svg'),
                                                              SizedBox(
                                                                width: 9.52,
                                                              ),
                                                              Text(
                                                                dataController
                                                                        .etkinliklerHome[
                                                                    index]["sehir"],
                                                                style:
                                                                    kTextStyle,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  getEmptyWidget(int num) {
    return Container(
        decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
          image: NetworkImage(
              "https://cataas.com/cat/cute?$num"),
          fit: BoxFit.cover),
    ));
  }
}
