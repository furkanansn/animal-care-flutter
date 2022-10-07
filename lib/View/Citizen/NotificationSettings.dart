import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool statusDonate = false;
  bool statusNotice = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      dynamic data = await QueryService().getUser();
      //print(data);
      statusDonate = data["donateNotification"];
      statusNotice = data["noticeNotification"];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar("Bildirim Ayarları"),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: ListTile(
                  title: Text(
                    "Bağış Bildirimi",
                    style: kLabelBlackStyle,
                  ),
                  trailing: Switch(
                    value: statusDonate,
                    onChanged: (value) async {
                      setState(() {
                        statusDonate = value;
                      });
                      await QueryService().updateUser(
                          donateNotification: statusDonate,
                          noticeNotification: statusNotice);
                    },
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: ListTile(
                  title: Text(
                    "İhbar Bildirimi",
                    style: kLabelBlackStyle,
                  ),
                  trailing: Switch(
                    value: statusNotice,
                    onChanged: (value) async {
                      setState(() {
                        statusNotice = value;
                      });
                      await QueryService().updateUser(
                          donateNotification: statusDonate,
                          noticeNotification: statusNotice);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
