import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatefulWidget {
  @override
  _PasswordViewState createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String password;
    String passwordAgain;
    final _key = GlobalKey<FormState>();
    return Scaffold(
        appBar: primaryAppBar("Parolamı Değiştir"),
        body: Form(
          key: _key,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: screenSize.height * 0.071,
                  width: screenSize.width / 1.07,
                  child: TextFormField(
                    onSaved: (newValue) {
                      password = newValue;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: "Yeni Şifrenizi Girin",
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: screenSize.height * 0.071,
                  width: screenSize.width / 1.07,
                  child: TextFormField(
                    onSaved: (newValue) {
                      passwordAgain = newValue;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: "Yeni Şifrenizi Tekrar Girin",
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  height: screenSize.height * 0.13,
                  width: screenSize.width / 1.07,
                  child: RaisedButton(
                      elevation: 5.0,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      child: Text(
                        "Şifreyi Güncelle",
                        style: TextStyle(
                          //color: Color(0xFF527DAA),
                          color: primaryColor,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          if(password == passwordAgain){

                          }else{
                              showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Parolalarınız eşleşmemektedir"),
                          actions: [
                            CupertinoButton(
                                child: Text("Tamam"),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
