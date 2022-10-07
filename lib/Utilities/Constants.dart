import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/material.dart';

final BASE_URL = "http://167.99.137.5";

getImagePath(String path) {
  return BASE_URL + "/api/v1/animals/show?path=" + path.toString();
}

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);
final kTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: 'OpenSans',
);

final kTextStyle2 = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
final kLabelBlackStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18,
  fontFamily: 'OpenSans',
);

final labelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.white,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
