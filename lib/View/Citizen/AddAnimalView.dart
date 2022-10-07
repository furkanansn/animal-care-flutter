import 'dart:io';

import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Utilities/ImageUtil.dart';
import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../Utilities/Constants.dart';
import '../../Widgets/Styles.dart';

class AddAnimalView extends StatefulWidget {
  int which;
  String type;
  AddAnimalView(int which, String type) {
    this.which = which;
    this.type = type;
  }

  @override
  _AddAnimalViewState createState() => _AddAnimalViewState();
}

class _AddAnimalViewState extends State<AddAnimalView> {
  Animal animal = new Animal();
  final _formState = GlobalKey<FormState>();
  bool wetNurse = false, takeOwnership = false;
  File animalImage,
      diseaseImage,
      medicineImage,
      surgeryImage,
      report1Image,
      report2Image,
      report3Image,
      passport1Image,
      passport2Image,
      passport3Image,
      other1Image,
      other2Image,
      other3Image;
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputBegin = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  ImageModel animalImageModel = new ImageModel();
  ImageModel diseasImageModel = new ImageModel();
  ImageModel medicineImageModel = new ImageModel();
  ImageModel surgeryImageModel = new ImageModel();
  ImageModel report1ImageModel = new ImageModel();
  ImageModel report2ImageModel = new ImageModel();
  ImageModel report3ImageModel = new ImageModel();
  ImageModel passport1ImageModel = new ImageModel();
  ImageModel passport2ImageModel = new ImageModel();
  ImageModel passport3ImageModel = new ImageModel();
  ImageModel other1ImageModel = new ImageModel();
  ImageModel other2ImageModel = new ImageModel();
  ImageModel other3ImageModel = new ImageModel();
  ProfileController profileController = Get.put(ProfileController());
  LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    locationController.getCities();
    profileController.getDiseaseSurgeryMedicine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
            (widget.which == 0) ? "Sokak Hayvanı Ekle" : "Evcil Hayvanı Ekle"),
        centerTitle: true,
      ),
      body: Obx(() {
        return Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content:
                                  Text("Görseli nerden eklemek istersiniz?"),
                              actions: [
                                CupertinoButton(
                                  child: Text("Galeri"),
                                  onPressed: () async {
                                    animalImageModel = await getImage(
                                        ImageSource.gallery, context);

                                    setState(() {
                                      animalImage = animalImageModel.imageFile;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoButton(
                                  child: Text("Kamera"),
                                  onPressed: () async {
                                    animalImageModel = await getImage(
                                        ImageSource.camera, context);

                                    setState(() {
                                      animalImage = animalImageModel.imageFile;
                                    });
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Text("Hayvan fotoğrafı ekle"),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.white,
                              child: animalImage != null
                                  ? ClipOval(
                                      child: Image.file(
                                        animalImage,
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.asset(
                                        "assets/cameraa.png",
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    profileController.getAnimalTypesWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    _buildNameTF(),
                    _buildBirthday(),
                    SizedBox(
                      height: 10,
                    ),
                    profileController.getWeightWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    locationController.getCitiesWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    locationController.getCountyWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    locationController.getStreetWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    profileController.getDiseaseSurgeryMedicineWidget(
                        context, 0),
                    SizedBox(
                      height: 10,
                    ),
                    profileController.getDiseaseSurgeryMedicineWidget(
                        context, 1),
                    SizedBox(
                      height: 10,
                    ),
                    profileController.getDiseaseSurgeryMedicineWidget(
                        context, 2),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Raporlar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                                          report1ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            report1Image =
                                                report1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          report1ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            report1Image =
                                                report1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: report1Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          report1Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          report2ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            report2Image =
                                                report2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          report2ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            report2Image =
                                                report2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: report2Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          report2Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          report3ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            report3Image =
                                                report3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          report3ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            report3Image =
                                                report3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: report3Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          report3Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Pasaportlar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                                          passport1ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            passport1Image =
                                                passport1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          passport1ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            passport1Image =
                                                passport1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: passport1Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          passport1Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          passport2ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            passport2Image =
                                                passport2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          passport2ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            passport2Image =
                                                passport2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: passport2Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          passport2Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          passport3ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            passport3Image =
                                                passport3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          passport3ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            passport3Image =
                                                passport3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: passport3Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          passport3Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Diğer Dökümanlar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                                          other1ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            other1Image =
                                                other1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          other1ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            other1Image =
                                                other1ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: other1Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          other1Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          other2ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            other2Image =
                                                other2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          other2ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            other2Image =
                                                other2ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: other2Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          other2Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                          other3ImageModel = await getImage(
                                              ImageSource.gallery, context);
                                          setState(() {
                                            other3Image =
                                                other3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text("Kamera"),
                                        onPressed: () async {
                                          other3ImageModel = await getImage(
                                              ImageSource.camera, context);
                                          setState(() {
                                            other3Image =
                                                other3ImageModel.imageFile;
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: other3Image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          other3Image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          "assets/cameraa.png",
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            "Ekle",
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
                              if (widget.which == 1) {
                                animal.isPet = true;
                              } else {
                                animal.isPet = false;
                              }
                              animal.kind = profileController.type.value;
                              animal.sehir_key = locationController
                                  .selectedCity.value
                                  .toString();
                              animal.ilce_key = locationController
                                  .selectedCounty.value
                                  .toString();
                                  animal.mahalle_key = locationController
                                  .selectedStreet.value
                                  .toString();
                              animal.takeOwnership =
                                  takeOwnership == true ? 1 : 0;
                              animal.wetNurse = wetNurse == true ? 1 : 0;
                              animal.image = animalImageModel?.base64;
                              animal.ext = animalImageModel?.imageName;
                              animal.type = profileController.type.value;
                              if (locationController.selectedStreet?.value !=
                                  null) {
                                animal.streetId = locationController
                                    .selectedStreet.value
                                    .toString();
                              }
                              animal.diseases =
                                  profileController.diseaseSavedList.value;

                              animal.medicines =
                                  profileController.medicineSavedList.value;

                              animal.surgeries =
                                  profileController.surgerySavedList.value;

                              animal.report = [];
                              if (report1ImageModel.base64 != null) {
                                animal.report.add(Other(
                                    image: report1ImageModel.base64,
                                    ext: report1ImageModel.imageName));
                              }
                              if (report2ImageModel.base64 != null) {
                                animal.report.add(Other(
                                    image: report2ImageModel.base64,
                                    ext: report2ImageModel.imageName));
                              }
                              if (report3ImageModel.base64 != null) {
                                animal.report.add(Other(
                                    image: report3ImageModel.base64,
                                    ext: report3ImageModel.imageName));
                              }
                              animal.passport = [];
                              if (passport1ImageModel.base64 != null) {
                                animal.passport.add(Other(
                                    image: passport1ImageModel.base64,
                                    ext: passport1ImageModel.imageName));
                              }
                              if (passport2ImageModel.base64 != null) {
                                animal.passport.add(Other(
                                    image: passport2ImageModel.base64,
                                    ext: passport2ImageModel.imageName));
                              }
                              if (passport3ImageModel.base64 != null) {
                                animal.passport.add(Other(
                                    image: passport3ImageModel.base64,
                                    ext: passport3ImageModel.imageName));
                              }
                              animal.others = [];
                              if (other1ImageModel.base64 != null) {
                                animal.others.add(Other(
                                    image: other1ImageModel.base64,
                                    ext: other1ImageModel.imageName));
                              }
                              if (other2ImageModel.base64 != null) {
                                animal.others.add(Other(
                                    image: other2ImageModel.base64,
                                    ext: other2ImageModel.imageName));
                              }
                              if (other3ImageModel.base64 != null) {
                                animal.others.add(Other(
                                    image: other3ImageModel.base64,
                                    ext: other3ImageModel.imageName));
                              }
                              animal.birthday = dateinput.text;
                              animal.weight = profileController.weight.value;
                              animal.imageModel = animalImageModel;
                              animal.type =
                                  profileController.typeInt.value.toString();
                              if (widget.type == "p") {
                                AnimalModel animalModel = new AnimalModel();
                                animalModel.animals = [];
                                animalModel.animals.add(animal);

                                await AnimalService().addAnimal(
                                    animalModel:
                                        animalModelToJson(animalModel));
                                showSuccess(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/logic", (route) => false);
                              } else {
                                profileController.addAnimal(animal);
                                showSuccess(context);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    "/register_part_2", (route) => false);
                              }
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0, left: 8),
              hintText: "Ad Girin",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Ad Giriniz";
              }
            },
            onSaved: (NewValue) {
              animal.name = NewValue;
            },
          ),
        )
      ],
    );
  }

  Widget _buildBirthday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  Widget _buildMedicinStartDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "İlaç Başlama Tarihi",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: dateinputBegin, //editing controller of this TextField
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              hintText: "İlaç Başlama Tarihi",
              hintStyle: kHintTextStyle,
            ),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateinputBegin.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicinEndDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "İlaç Bitirme Tarihi",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: dateinputEnd, //editing controller of this TextField
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              hintText: "İlaç Bitirme Tarihi",
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
                  dateinputEnd.text = formattedDate;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
            },
          ),
        ),
      ],
    );
  }
}
