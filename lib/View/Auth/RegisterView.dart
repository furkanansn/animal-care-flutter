import 'package:bi_pati/Models/Auth.dart';
import 'package:bi_pati/Network/LocationService.dart';
import 'package:bi_pati/Tools/KeyboardHide.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/ViewModel/SectorController.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Network/AuthService.dart';
import 'OptValidationView.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  bool _citizen = false;
  bool _corporate = false;
  final _formState = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _nameSurname = "";
  String _birthday = "";
  String _city = "";
  String _town = "";
  String _neighborhood = "";
  String _phone = "";
  String _passwordAgain = "";
  String _corporateName = "";
  String _taxOffice = "";
  String _taxNumber = "";
  String _corporateAdress = "";
  String _workHours = "";
  String _corporatePhone = "";
  String _street;
  String _streetNo;
  String selectedCityValue;
  TabController tabController;
  TextEditingController dateinput = TextEditingController();
  LocationController locationController = Get.put(LocationController());
  SectorController sectorController = Get.put(SectorController());
  ProfileController profileController = Get.put(ProfileController());
  Widget _buildCorporateNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kuruluş Adı",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Kuruluş Adı Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Kuruluş Adı Giriniz";
              }
            },
            onSaved: (NewValue) {
              _corporateName = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildStreetNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10.0),
              hintText: "Sokak Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Sokak Adı Giriniz";
              }
            },
            onSaved: (NewValue) {
              _street = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildStreetNoNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10.0),
              hintText: "No Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen No Giriniz";
              }
            },
            onSaved: (NewValue) {
              _streetNo = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildCorporateAdressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Adres",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              hintText: "Adres Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Adres Giriniz";
              }
            },
            onSaved: (NewValue) {
              _corporateAdress = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildCorporatePhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Yetkili Telefon Numarası (*Sms Onayi Gidecek)",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                hintText: "Yetkili Telefon Numarası Giriniz ",
                hintStyle: kHintTextStyle),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Yetkili Telefon Numarası Giriniz";
              }
            },
            onSaved: (NewValue) {
              _corporatePhone = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildTab() {
    return AppBar(
      backgroundColor: primaryColor,
      shadowColor: primaryShadowColor,
      bottom: TabBar(
        controller: tabController,
        onTap: (i) {
          keyboardHide();
        },
        tabs: [
          Tab(text: "Bireysel Kayıt", icon: Icon(Icons.person)),
          Tab(text: "Kurumsal Kayıt", icon: Icon(Icons.person_pin)),
        ],
      ),
    );
  }

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
              hintText: "Email Adresi Giriniz",
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

  Widget _buildNameSurnameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ad Soyad",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Ad Soyad Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Ad Soyad Giriniz";
              }
            },
            onSaved: (NewValue) {
              _nameSurname = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildTaxOfficeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vergi Dairesi",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.work,
                color: Colors.white,
              ),
              hintText: "Vergi Dairesi Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Vergi Dairesi Giriniz";
              }
            },
            onSaved: (NewValue) {
              _taxOffice = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildTaxNumberTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vergi Numarası",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.work,
                color: Colors.white,
              ),
              hintText: "Vergi Numarası Giriniz",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Vergi Numarası Giriniz";
              }
            },
            onSaved: (NewValue) {
              _taxNumber = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildPhoneTF(isCorporate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Telefon Numarası",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: "5XX XXX XX XX " +
                  (isCorporate ? "" : "(*Sms Onayi Gidecek)"),
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty && value.toString().length != 10) {
                return "    Lütfen Belirtilen Şekilde Telefon Numarası Giriniz";
              }
            },
            onSaved: (NewValue) {
              _phone = NewValue;
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
          'Parola',
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
              hintText: 'Parola Giriniz',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Parola Giriniz";
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

  Widget _buildPasswordAgainTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Parola Tekrar',
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
              hintText: 'Tekrar Parola Giriniz',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Tekrar Parola Giriniz";
              }
            },
            onSaved: (NewValue) {
              _passwordAgain = NewValue;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBirthday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Doğum Tarihi",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: dateinput, //editing controller of this TextField
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              hintText: "Doğum Tarihi", //label text of field
              hintStyle: kHintTextStyle,
            ),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1930, 01, 01),
                  maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                setState(() {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  dateinput.text = formattedDate;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
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
            "Kayıt Ol",
            style: TextStyle(
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
              if (_password != _passwordAgain) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Parolalarınız eşleşmemektedir"),
                      actions: [
                        ElevatedButton(
                          child: Text("Tamam"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
                return;
              }

              Auth registerModel = Auth();
              if (tabController.index == 0) {
                registerModel = await new AuthService().register(
                    isPersonal: true,
                    street: _street,
                    streetNo: _streetNo,
                    name: _nameSurname,
                    password: _password,
                    email: _email,
                    birthday: dateinput.text,
                    phoneNumber: "+90" + _phone,
                    districtId:
                        locationController.selectedStreet.value.toString(),
                    sehir_key: locationController.selectedCity.value.toString(),
                    ilce_key:
                        locationController.selectedCounty.value.toString());
              } else {
                registerModel = await new AuthService().register(
                    isPersonal: false,
                    sectorId: sectorController.selectedSector.value,
                    name: _corporateName,
                    password: _password,
                    email: _email,
                    street: _street,
                    streetNo: _streetNo,
                    phoneNumber: "+90" + _phone,
                    districtId:
                        locationController.selectedStreet.value.toString(),
                    sehir_key: locationController.selectedCity.value.toString(),
                    ilce_key:
                        locationController.selectedCounty.value.toString(),
                    taxNumber: _taxNumber,
                    taxOffice: _taxOffice,
                    authorizedPhone: "+90" + _corporatePhone,
                    workingHours: _workHours,
                    adress: _corporateAdress);
              }

              if (!registerModel.error) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OptValidationView(
                        isCorporate: tabController.index,
                        opt: registerModel.data.code.toString(),
                        message: registerModel.data.msg.toString(),
                      ),
                    ),
                    (route) => false);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          "Böyle bir kullanıcı bulunmaktadır. Lütfen giriş yapınız."),
                      actions: [
                        ElevatedButton(
                            child: Text("Tamam"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    );
                  },
                );
              }
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    LocationService().getCity().then((value) {});
    dateinput.text = ""; //set the initial value of text field
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    locationController.getCities();
    sectorController.getSectors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildTab(),
        body: Obx(() {
          return Form(
            key: _formState,
            child: TabBarView(
              controller: tabController,
              children: [
                AnnotatedRegion<SystemUiOverlayStyle>(
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
                              vertical: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildNameSurnameTF(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildBirthday(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildEmailTF(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildPhoneTF(false),
                                SizedBox(
                                  height: 20.0,
                                ),
                                //_buildCityDropDown(),
                                locationController.getCitiesWidget(context),
                                SizedBox(
                                  height: 20.0,
                                ),
                                locationController.getCountyWidget(context),
                                SizedBox(
                                  height: 20.0,
                                ),
                                locationController.getStreetWidget(context),
                                SizedBox(
                                  height: 20.0,
                                ),

                                _buildStreetNameTF(),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildStreetNoNameTF(),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildPasswordTF(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildPasswordAgainTF(),
                                _buildRegisterBtn(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                AnnotatedRegion<SystemUiOverlayStyle>(
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
                              vertical: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildCorporateNameTF(),
                                SizedBox(
                                  height: 20,
                                ),
                                locationController.getCitiesWidget(context),
                                SizedBox(
                                  height: 20,
                                ),
                                locationController.getCountyWidget(context),
                                SizedBox(
                                  height: 20,
                                ),
                                locationController.getStreetWidget(context),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildStreetNameTF(),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildStreetNoNameTF(),
                                SizedBox(
                                  height: 20,
                                ),
                                sectorController.getSectorsWidget(context),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildCorporateAdressTF(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildPhoneTF(true),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildEmailTF(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildCorporatePhoneTF(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildTaxOfficeTF(),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildTaxNumberTF(),
                                SizedBox(
                                  height: 10,
                                ),
                                profileController.getWorkingWidget(context),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildPasswordTF(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _buildPasswordAgainTF(),
                                _buildRegisterBtn(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
