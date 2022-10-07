import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/View/Citizen/KvkkView.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'NotificationSettings.dart';
import 'PasswordView.dart';
import 'SecurityView.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar("Ayarlar"),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationSettings(),
                    ));
              },
              child: ListTile(
                title: Text(
                  "Bildirim Ayarları",
                  style: kLabelBlackStyle,
                ),
                trailing: Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          /*
          Card(
            elevation: 10,
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordView(),
                    ));
              },
              child: ListTile(
                title: Text(
                  "Parolamı Değiştir",
                  style: kLabelBlackStyle,
                ),
                trailing: Icon(FontAwesomeIcons.chevronRight, color: Colors.black,),
              ),
            ),
          ),*/
          Card(
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Security(),
                    ));
              },
              child: ListTile(
                title: Text(
                  "Gizlilik Sözleşmesi",
                  style: kLabelBlackStyle,
                ),
                trailing: Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Kvkk(),
                    ));
              },
              child: ListTile(
                title: Text(
                  "KVKK Bildirimi",
                  style: kLabelBlackStyle,
                ),
                trailing: Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
