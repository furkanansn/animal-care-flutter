import 'dart:convert';
import 'dart:io';

import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Models/City.dart';
import 'package:bi_pati/Models/County.dart';
import 'package:bi_pati/Models/Street.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/Network/LocationService.dart';
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

class EditAnimalView extends StatefulWidget {
  int which;
  EditAnimalView(int which) {
    this.which = which;
  }

  @override
  _EditAnimalViewState createState() => _EditAnimalViewState();
}

class _EditAnimalViewState extends State<EditAnimalView> {
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
  Cities city;
  Counties county;
  Streeties street;
  bool hideAdress = false;
  @override
  Future<void> initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await profileController.getDiseaseSurgeryMedicine();
      animal = profileController.selectedAnimal.value;
      await locationController.getCities();

      try {
        city = locationController.cities.value.firstWhere(
            (element) => element.sehirKey.toString() == animal.sehir_key);
        locationController.selectedCity.value = city.sehirKey;
        County count = await LocationService().getCounty(
          key: int.parse(animal.sehir_key),
        );
        count.data.data.forEach((element) {
          if (element.ilceKey.toString() == animal.ilce_key) {
            county = element;
          }
        });
        Street streetData =
            await LocationService().getStreet(key: county.ilceKey);
        streetData.data.data.forEach((element) {
          if (element.mahalleKey.toString() == animal.streetId) {
            street = element;
          }
        });
      } catch (e) {
        print(e.toString());
      }

      profileController.diseaseEditList.value = animal.diseases;
      profileController.medicineEditList.value = animal.medicines;
      profileController.surgeryEditList.value = animal.surgeries;

      animalImageModel.imageName = profileController.selectedAnimal.value.image;
      dateinput.text = profileController.selectedAnimal.value.birthday;

      profileController.GetWeightOfAnimal(animal.weight);
      if (profileController.selectedAnimal.value.report != null) {
        if (profileController.selectedAnimal.value.report.length == 0) {
        } else if (profileController.selectedAnimal.value.report.length == 3) {
          report1ImageModel.imageName =
              profileController.selectedAnimal.value.report[0].image;
          report2ImageModel.imageName =
              profileController.selectedAnimal.value.report[1].image;
          report3ImageModel.imageName =
              profileController.selectedAnimal.value.report[2].image;
        } else if (profileController.selectedAnimal.value.report.length == 2) {
          report1ImageModel.imageName =
              profileController.selectedAnimal.value.report[0].image;
          report2ImageModel.imageName =
              profileController.selectedAnimal.value.report[1].image;
        } else if (profileController.selectedAnimal.value.report.length == 1) {
          report1ImageModel.imageName =
              profileController.selectedAnimal.value.report[0].image;
        }
      }
      if (profileController.selectedAnimal.value.passport != null) {
        if (profileController.selectedAnimal.value.passport.length == 0) {
        } else if (profileController.selectedAnimal.value.passport.length ==
            3) {
          passport1ImageModel.imageName =
              profileController.selectedAnimal.value.passport[0].image;
          passport2ImageModel.imageName =
              profileController.selectedAnimal.value.passport[1].image;
          passport3ImageModel.imageName =
              profileController.selectedAnimal.value.passport[2].image;
        } else if (profileController.selectedAnimal.value.passport.length ==
            2) {
          passport1ImageModel.imageName =
              profileController.selectedAnimal.value.passport[0].image;
          passport2ImageModel.imageName =
              profileController.selectedAnimal.value.passport[1].image;
        } else if (profileController.selectedAnimal.value.passport.length ==
            1) {
          passport1ImageModel.imageName =
              profileController.selectedAnimal.value.passport[0].image;
        }
      }
      if (profileController.selectedAnimal.value.others != null) {
        if (profileController.selectedAnimal.value.others.length == 0) {
        } else if (profileController.selectedAnimal.value.others.length == 3) {
          other1ImageModel.imageName =
              profileController.selectedAnimal.value.others[0].image;
          other2ImageModel.imageName =
              profileController.selectedAnimal.value.others[1].image;
          other3ImageModel.imageName =
              profileController.selectedAnimal.value.others[2].image;
        } else if (profileController.selectedAnimal.value.others.length == 2) {
          other1ImageModel.imageName =
              profileController.selectedAnimal.value.others[0].image;
          other2ImageModel.imageName =
              profileController.selectedAnimal.value.others[1].image;
        } else if (profileController.selectedAnimal.value.others.length == 1) {
          other1ImageModel.imageName =
              profileController.selectedAnimal.value.others[0].image;
        }
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                        content: Text("Silmek istediğinizden emin misiniz?"),
                        actions: [
                          CupertinoButton(
                            child: Text("Vazgeç"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoButton(
                            child: Text("Sil"),
                            onPressed: () async {
                              await AnimalService().deleteAnimal(id: animal.id);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/logic", (route) => false);
                            },
                          )
                        ]);
                  },
                );
              },
              child: Text("Sil",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  )))
        ],
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
                                    : getImageWidget(
                                        animalImageModel?.imageName)),
                          ),
                        ],
                      ),
                    ),
                    //profileController.getAnimalTypesWidget(context,                      value: animal.type),
                    SizedBox(
                      height: 10,
                    ),
                    _buildNameTF(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildBirthday(),
                    SizedBox(
                      height: 10,
                    ),
                    profileController.getWeightWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    hideAdress
                        ? Container()
                        : Text(
                            "Adres: " +
                                city?.sehirTitle.toString() +
                                " " +
                                county?.ilceTitle.toString() +
                                " " +
                                street?.mahalleTitle.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                    TextButton(
                        onPressed: () {
                          hideAdress = true;
                          setState(() {});
                        },
                        child: Text("Adres Değiştir")),
                    hideAdress
                        ? locationController.getCitiesEditWidget(context)
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    hideAdress
                        ? locationController.getCountyEditWidget(context)
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    hideAdress
                        ? locationController.getStreetEditWidget(context)
                        : Container(),
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
                                  child: getImageWidgetWithData(
                                      report1ImageModel)),
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
                                  child: getImageWidgetWithData(
                                      report2ImageModel)),
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
                                  child: getImageWidgetWithData(
                                      report3ImageModel)),
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
                                  child: getImageWidgetWithData(
                                      passport1ImageModel)),
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
                                  child: getImageWidgetWithData(
                                      passport2ImageModel)),
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
                                  child: getImageWidgetWithData(
                                      passport3ImageModel)),
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
                                  child:
                                      getImageWidgetWithData(other1ImageModel)),
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
                                  child:
                                      getImageWidgetWithData(other2ImageModel)),
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
                                  child:
                                      getImageWidgetWithData(other3ImageModel)),
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
                            "Kaydet",
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

                              if (locationController.selectedCounty == null) {
                                locationController.selectedCounty = county.ilceKey.toString().obs;
                               
                              } else {
                                animal.ilce_key = locationController
                                    .selectedCounty.value
                                    .toString();
                              }
                              if (locationController.selectedStreet == null) {
                                locationController.selectedStreet =  street.mahalleKey.toString().obs;
                       
                              } else {
                                animal.streetId = locationController
                                    .selectedStreet.value
                                    .toString();
                              }

                              animal.mahalle_key = locationController
                                  .selectedCounty.value
                                  .toString();
                              if (animal.mahalle_key == "null") {
                                animal.mahalle_key = null;
                              }
                              animal.takeOwnership =
                                  takeOwnership == true ? 1 : 0;
                              animal.wetNurse = wetNurse == true ? 1 : 0;
                              if (animalImageModel.base64 != null) {
                                animal.image = animalImageModel.base64;
                                animal.ext = animalImageModel.imageName;
                              }

                              animal.weight = profileController.weight.value;
                              if (profileController
                                  .diseaseSavedList.value.isNotEmpty) {
                                animal.diseases =
                                    profileController.diseaseSavedList.value;
                              } else {
                                animal.diseases =
                                    profileController.diseaseEditList.value;
                              }
                              if (profileController
                                  .medicineSavedList.value.isNotEmpty) {
                                animal.medicines =
                                    profileController.medicineSavedList.value;
                              } else {
                                animal.medicines =
                                    profileController.medicineEditList.value;
                              }
                              if (profileController
                                  .surgerySavedList.value.isNotEmpty) {
                                animal.surgeries =
                                    profileController.surgerySavedList.value;
                              } else {
                                animal.surgeries =
                                    profileController.surgeryEditList.value;
                              }

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
                              AnimalModel animalModel = new AnimalModel();
                              animalModel.animals = [];
                              animalModel.animals.add(animal);
                              print(jsonEncode(animal.toJson()));

                              await AnimalService().updateAnimal(
                                  animalModel: jsonEncode(animal.toJson()),
                                  id: animal.id);
                              showEditSuccess(context);
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
            initialValue: profileController.selectedAnimal.value.name,
            keyboardType: TextInputType.text,
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

  Widget getImageWidget(image) {
    return ClipOval(
        child: FadeInImage.assetNetwork(
      placeholder: "assets/cameraa.png",
      image: getImagePath(image),
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    ));
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
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1930, 01, 01),
                  maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                setState(() {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  dateinputBegin.text = formattedDate;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
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

  Widget _buildMultiSelectweight() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: MultiSelectDialogField(
        decoration: kBoxDecorationStyle,
        title: Text(
          "Kilo Seç",
          style: TextStyle(color: Colors.white),
        ),
        cancelText: Text(
          "Vazgeç",
          style: TextStyle(color: Colors.white),
        ),
        buttonText: Text(
          "Kilo Seç",
          style: TextStyle(color: Colors.white),
        ),
        confirmText: Text(
          "Tamam",
          style: TextStyle(color: Colors.white),
        ),
        // items: _animals.map((e) => MultiSelectItem(e, e.name)).toList(),
        listType: MultiSelectListType.CHIP,
        onConfirm: (values) {
          //_selectedAnimals = values;
        },
      ),
    );
  }

  Widget _buildkgWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            initialValue: profileController.selectedAnimal.value.weight,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              hintText: "Kilo girin",
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "    Lütfen Kilo Giriniz";
              }
            },
            onSaved: (NewValue) {
              animal.weight = NewValue;
            },
          ),
        )
      ],
    );
  }

  getImageWidgetWithData(ImageModel imageModel) {
    print("resimlerin urlsi " + imageModel?.imageName.toString());
    if (imageModel.imageFile != null) {
      return ClipOval(
        child: Image.file(
          imageModel.imageFile,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else if (imageModel.imageName != null) {
      return ClipOval(
        child: Image.network(
          getImagePath(imageModel.imageName),
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          "assets/cameraa.png",
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
