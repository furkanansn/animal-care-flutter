import 'package:bi_pati/Models/NoticeResponseModel.dart';
import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/Utilities/ImageUtil.dart';
import 'package:bi_pati/Utilities/LoadingIndicator.dart';
import 'package:bi_pati/Utilities/LocationUtil.dart';
import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NoticeAdvertAddView extends StatefulWidget {
  String title;
  int announcementsType;

  NoticeAdvertAddView(String title, int announcementsType) {
    this.title = title;
    this.announcementsType = announcementsType;
  }

  @override
  _NoticeAdvertAddViewState createState() => _NoticeAdvertAddViewState();
}

class _NoticeAdvertAddViewState extends State<NoticeAdvertAddView> {
  ImageModel imageModel = ImageModel();
  LocationController locationController = Get.put(LocationController(),tag: "notice");
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController aciklamaController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController sokakController = TextEditingController();

  String address = "";
  String age;
  bool isShowDropdowns = true;
  final _key = GlobalKey<FormState>();
  LocationModel locationModel;
  String animalId;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {});
    locationController.getCities();
    profileController.getAnimals().then((value) {
      setState(() {});
    });

    super.initState();
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, bottom: 10),
        child: Text(
          "Adres: " + address,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLocationButton() {
    return InkWell(
      onTap: () async {
        loading(context);
        locationModel = await getAdressFromLocation();
        setState(() {
          address = locationModel.city +
              " " +
              locationModel.county +
              " " +
              locationModel.district +
              " Mahallesi" +
              " " +
              locationModel.street;
          isShowDropdowns = false;
        });
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 50.0,
        width: 200,
        child: Center(
          child: Text(
            "Lokasyonumu Bul",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationDescription() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0x6aeec6c6),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: aciklamaController,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Zorunlu alan";
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 2000,
                    decoration: InputDecoration.collapsed(hintText: "Açıklama"),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalType() {
    if (profileController.animals.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            "Hayvan Seçiniz / Hayvanınız yoksa profilinizden ekleyebilirsiniz",
            style: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: kBoxDecorationStyle,
        child: DropdownButton(
          isExpanded: true,
          hint: Text(
            "Hayvan Seçiniz",
            style: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          dropdownColor: Colors.black,
          focusColor: Colors.black,
          items: profileController.animals.map((e) {
            return new DropdownMenuItem(
              child: Text(
                e.name,
                style: TextStyle(color: Colors.white),
              ),
              value: e.id,
            );
          }).toList(),
          onChanged: (val) {
            animalId = val;
            setState(() {});
          },
          value: animalId,
        ),
      );
    }
  }

  Widget _buildStreetDescription() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0x6aeec6c6),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8, right: 15.0, bottom: 15, top: 15),
            child: TextField(
              controller: sokakController,
              decoration: InputDecoration.collapsed(hintText: "Sokak"),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: primaryAppBar(widget.title),
        body: Obx(() {
          return Form(
            key: _key,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildLocationButton(),
                    SizedBox(
                      height: 15,
                    ),
                    isShowDropdowns
                        ? locationController.getCitiesWidget(context)
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    isShowDropdowns
                        ? locationController.getCountyWidget(context)
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    isShowDropdowns
                        ? locationController.getStreetWidget(context)
                        : Container(),
                    isShowDropdowns
                        ? SizedBox(
                            height: 15,
                          )
                        : Container(),
                    isShowDropdowns ? _buildStreetDescription() : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    !isShowDropdowns ? _buildText() : Container(),
                    _buildAnimalType(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildLocationDescription(),
                    SizedBox(
                      height: 15,
                    ),

                    /*
                    (imageModel?.imageFile != null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              imageModel?.imageFile,
                              height: 300,
                              width: 500,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        content: Text(
                                            "Görseli nerden eklemek istersiniz?"),
                                        actions: [
                                          CupertinoButton(
                                            child: Text("Galeri"),
                                            onPressed: () async {
                                              ImageModel imageModel1 =
                                                  await getImage(
                                                      ImageSource.gallery,
                                                      context);

                                              setState(() {
                                                imageModel = imageModel1;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoButton(
                                            child: Text("Kamera"),
                                            onPressed: () async {
                                              ImageModel imageModel1 =
                                                  await getImage(
                                                      ImageSource.camera,
                                                      context);

                                              setState(() {
                                                imageModel = imageModel1;
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Image.asset("assets/foto.png")),
                          ),
                    
                    */
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: RaisedButton(
                          elevation: 5.0,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.white,
                          child: Text(
                            "İlan Ver",
                            style: TextStyle(
                              color: primaryColor,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              if (locationModel == null &&
                                  locationController.selectedStreet.value
                                          .toString() ==
                                      null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Konum seçiniz")));
                                return;
                              }
                              

                              _key.currentState.save();

                              NoticeResponseModel model = await QueryService()
                                  .addannouncement(
                                    
                                      title: sokakController.text,
                                      animal_id: animalId,
                                      context: context,
                                      animal_kind:
                                          profileController.typeInt.value,
                                      sehir_key: (locationController
                                                  .selectedCity.value) ==
                                              null
                                          ? null
                                          : locationController
                                              .selectedCity.value,
                                      ilce_key: (locationController
                                                  .selectedCounty?.value) ==
                                              null
                                          ? null
                                          : locationController
                                              .selectedCounty?.value,
                                      imageName: imageModel.imageName,
                                      content: aciklamaController.text,
                                      
                                      image: imageModel
                                          .base64, //imageModel.base64,
                                      districtId: (locationController
                                                  .selectedStreet?.value) ==
                                              null
                                          ? null
                                          : locationController
                                              .selectedStreet.value,
                                      city: locationModel?.city,
                                      county: locationModel?.county,
                                      street: locationModel?.street,
                                      type_id: widget.announcementsType,
                                      age: profileController.age.value);
                              if (model.error) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text(model.errorMsg),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("İlan Verildi")));
                                Navigator.pop(context);
                              }
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
