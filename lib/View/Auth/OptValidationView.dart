import 'dart:developer';

import 'package:bi_pati/Utilities/LocalUtil.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../Network/AuthService.dart';
import '../../Utilities/Constants.dart';
import '../../Widgets/Styles.dart';
import 'RegisterPart2.dart';

class OptValidationView extends StatefulWidget {
  String opt;
  String message;
  int isCorporate;
  OptValidationView({String opt, String message, int isCorporate}) {
    this.opt = opt;
    this.message = message;
    this.isCorporate = isCorporate;
  }

  @override
  _OptValidationViewState createState() => _OptValidationViewState();
}

class _OptValidationViewState extends State<OptValidationView> {
  String _smsCode = "";
  final _formState = GlobalKey<FormState>();
  CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    log(widget.opt);
    return Scaffold(
      body: Form(
        key: _formState,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                Center(
                    child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 40),
                CircularCountDownTimer(
                  // Countdown duration in Seconds
                  duration: 180,

                  // Controller to control (i.e Pause, Resume, Restart) the Countdown
                  controller: _controller,

                  // Width of the Countdown Widget
                  width: MediaQuery.of(context).size.width / 2,

                  // Height of the Countdown Widget
                  height: MediaQuery.of(context).size.height / 6,

                  // Default Color for Countdown Timer
                  color: Colors.white,

                  // Filling Color for Countdown Timer
                  fillColor: Colors.red,

                  // Background Color for Countdown Widget
                  backgroundColor: null,

                  // Border Thickness of the Countdown Circle
                  strokeWidth: 5.0,

                  // Begin and end contours with a flat edge and no extension
                  strokeCap: StrokeCap.butt,

                  // Text Style for Countdown Text
                  textStyle: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),

                  // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                  isReverse: true,

                  // true for reverse animation, false for forward animation
                  isReverseAnimation: true,

                  // Optional [bool] to hide the [Text] in this widget.
                  isTimerTextShown: true,

                  // Function which will execute when the Countdown Ends
                  onComplete: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/logic", (route) => false);
                    // Here, do whatever you want
                    print('Countdown Ended');
                  },
                ),
                Column(
                  children: [
                    Text(
                      "Validasyon Kodu",
                      style: kLabelStyle,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "   Validasyon Kodu Girin",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "    Lütfen Validasyon Kodu Giriniz";
                        }
                      },
                      onSaved: (NewValue) {
                        _smsCode = NewValue;
                      },
                    )
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      elevation: 5.0,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      child: Text(
                        "Doğrula",
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
                        if (_formState.currentState.validate()) {
                          _formState.currentState.save();
                          if (widget.opt == _smsCode) {
                            await AuthService().veriftOtp();
                            await LocalUtil()
                                .addLocalData(key: "isApproved", value: "1");
                            if (widget.isCorporate == 0) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPart2(),
                                  ),
                                  (route) => false);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Hesabınızın onaylanmasını bekleyiniz."),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                "/login",
                                                (route) => false);
                                          },
                                          child: Text("Tamam"))
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Yanlış girdiniz. Lütfen kontrol edip tekrar deneyiniz."),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Tamam"))
                                  ],
                                );
                              },
                            );
                          }
                        }
                      }),
                )
              ],
            )),
      ),
    );
  }
}
