import 'dart:developer';

import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Network/AuthService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  bool _citizen = false;
  bool _corporate = false;
  final _formState = GlobalKey<FormState>();
  String _email = "";
  String _password = "";


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Email Adresinizi Girin",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Email Giriniz";
              }
            },
            onSaved: (NewValue) {
              _email = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
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
              hintText: 'Şifrenizi Girin',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Şifrenizi Giriniz";
              }
            },
            onSaved: (NewValue) {
              _password = NewValue;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.bottomRight,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () => print("Şifremi Unuttum'a basıldı"),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Şifremi Unuttum",
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
          onPressed: ()  async {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();


                Auth loginModel = await AuthService()
                    .login(password: _password, email: _email);
                log(_email);
                log(_password);
                if (loginModel.error) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(loginModel.errorMsg),
                          actions: [
                            CupertinoButton(
                                child: Text("Tamam"),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                } else {
                  Navigator.pushNamed(context, "/logic");
                }

            }
          }),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: [
        Text(
          " Veya ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Şununla Giriş Yap",
          style: kLabelStyle,
        )
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ],
            image: DecorationImage(
              image: logo,
            )),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/bio");
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hesabınız yok mu? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Kaydol',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Form(
      key: _formState,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(

                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,

                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      //_buildRememberMeCheckbox(),

                      _buildLoginBtn(),
                      // _buildSignInWithText(),
                      //_buildSocialBtnRow(),
                      _buildSignupBtn(),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

/*TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0 , vsync: this);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bi Pati"),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          onTap: (i){
            keyboardHide();
          },
          tabs: [
            Tab(text: "Giriş Yap", icon: Icon(Icons.vpn_key),),
            Tab(text: "Kayıt ol", icon: Icon(Icons.person_add),),
          ],
        ),
      ),
      /*body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,

        ),
      ),*/
    );
  }
}*/
