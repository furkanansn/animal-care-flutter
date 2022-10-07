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

class NoticeDetailView extends StatefulWidget {
  String title;

  NoticeDetailView(String title) {
    this.title = title;
  }

  @override
  _NoticeDetailViewState createState() => _NoticeDetailViewState();
}

class _NoticeDetailViewState extends State<NoticeDetailView> {
  ImageModel imageModel = ImageModel();
  LocationController locationController = Get.put(LocationController());
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController aciklamaController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController sokakController = TextEditingController();
  String title = "";
  String address = "";
  bool isShowDropdowns = true;
  final _key = GlobalKey<FormState>();
  LocationModel locationModel;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {});
    locationController.getCities();
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

  Widget _buildLocationTitle() {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
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
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Zorunlu alan";
                      }
                    },
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 100,
                    decoration: InputDecoration.collapsed(hintText: "Başlık"),
                  )),
            ),
          ),
        ],
      ),
    );
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
                    SizedBox(
                      height: 15,
                    ),
                    profileController.getAnimalTypesWidget(context),
                    SizedBox(
                      height: 15,
                    ),
                    //_buildLocationTitle(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildLocationDescription(),
                    SizedBox(
                      height: 15,
                    ),
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
                            "İhbar Et",
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

                              if (imageModel.base64 == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Lütfen Resim seçiniz")));
                                return;
                              }
                              NoticeResponseModel model = await QueryService()
                                  .addNotice(
                                      animal_id:
                                          profileController.typeInt.value,
                                      notice_type_id: 1,
                                      context: context,
                                      sehir_key: (locationController
                                                  .selectedCity?.value) ==
                                              null
                                          ? null
                                          : locationController
                                              .selectedCity.value,
                                      ilce_key: (locationController
                                                  .selectedCounty?.value) ==
                                              null
                                          ? null
                                          : locationController
                                              .selectedCounty.value,
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
                                      title: sokakController.text);
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
                                    SnackBar(
                                        content: Text("İhbar gönderildi")));
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
