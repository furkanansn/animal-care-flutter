import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';

class FirsPage extends StatelessWidget {
  const FirsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: screenSize.height * 0.59,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/logo2.png"))),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          width: screenSize.width * 0.976,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: primaryColor, width: 1)),
          child: RaisedButton(
              elevation: 5.0,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Text(
                "Giriş Yap",
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
                Navigator.pushNamed(context, "/login");
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: screenSize.width * 0.976,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: primaryColor, width: 1)),
          child: RaisedButton(
              elevation: 5.0,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Text(
                "Hesap Oluştur",
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
                Navigator.pushNamed(context, "/bio");
              }),
        )
      ],
    ));
  }
}
