import 'dart:convert';
import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:bi_pati/ViewModel/DataContoller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLogic extends StatefulWidget {
  const AppLogic({Key key}) : super(key: key);

  @override
  _AppLogicState createState() => _AppLogicState();
}

class _AppLogicState extends State<AppLogic> {
  DataController dataController = Get.put(DataController());
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      String token = await LocalUtil().getLocalData(key: "token");

      String isApproved = await LocalUtil().getLocalData(key: "isApproved");
      Auth auth;
      try {
        auth = Auth.fromJson(
            jsonDecode(await LocalUtil().getLocalData(key: "user")));
      } catch (e) {}

      if (token == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/firs_page", (route) => false);
      } else {
        if (auth.data.user.isPersonal == 1) {
          if (isApproved == "0") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/firs_page", (route) => false);
          } else {
            await dataController.getDataBankCategory();
            await dataController.getEvents();
            Navigator.pushNamedAndRemoveUntil(
                context, "/citizen_home", (route) => false);
          }
        } else {
          if (isApproved == "0") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/firs_page", (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, "/corporate_main", (route) => false);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CupertinoActivityIndicator()),
    );
  }
}
