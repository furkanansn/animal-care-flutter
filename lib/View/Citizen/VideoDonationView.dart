import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Ads/AdmobManager.dart';
import 'package:bi_pati/Utilities/Constants.dart';
import 'package:bi_pati/ViewModel/LocationController.dart';
import 'package:bi_pati/Widgets/PrimaryWidgets.dart';
import 'package:bi_pati/Widgets/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class VideoDonationView extends StatefulWidget {
  @override
  _VideoDonationViewState createState() => _VideoDonationViewState();
}

class _VideoDonationViewState extends State<VideoDonationView> {
  bool didVideoWatch = false;
  bool _dog = false;
  bool _cat = false;
  int _currentStep = 0;
  LocationController locationController = Get.put(LocationController());
  @override
  void initState() {
    locationController.getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: primaryAppBar("Video Bağış"),
        body: Obx(() {
          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stepper(
                type: StepperType.vertical,
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  return Row(
                    children: <Widget>[
                      didVideoWatch || _currentStep > 2
                          ? TextButton(
                              onPressed: onStepContinue,
                              child: const Text('Devam Et'),
                            )
                          : Text("Videoyu izleyiniz")
                    ],
                  );
                },
                onStepTapped: (step) => setState(() => _currentStep = step),
                onStepContinue: () async {
                  if (_currentStep < 7 - 1) {
                    _currentStep += 1;
                    didVideoWatch = false;
                  } else {
                    await QueryService().videoDonation(
                        city: locationController.selectedCity.value,
                        county: locationController.selectedCounty.value,
                        street: locationController.selectedStreet.value,
                        type: _dog ? 1 : 2);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Bağışınız başarıyla yapıldı")));
                    Navigator.pop(context);
                  }
                  setState(() {});
                },
                steps: [
                  Step(
                    isActive: _currentStep == 0,
                    state: _currentStep > 0
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("1. Video"),
                    content: watchVideoButton("İzle"),
                  ),
                  Step(
                    isActive: _currentStep == 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("2. Video"),
                    content: watchVideoButton("İzle"),
                  ),
                  Step(
                    isActive: _currentStep == 2,
                    state: _currentStep > 2
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("3. Video"),
                    content: watchVideoButton("İzle"),
                  ),
                  Step(
                    isActive: _currentStep == 3,
                    state: _currentStep > 3
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("İl Seç"),
                    content: locationController.getCitiesWidget(context),
                  ),
                  Step(
                    isActive: _currentStep == 4,
                    state: _currentStep > 4
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("İlçe Seç"),
                    content: locationController.getCountyWidget(context),
                  ),
                  Step(
                    isActive: _currentStep == 5,
                    state: _currentStep > 5
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text("Mahalle Seç"),
                    content: locationController.getStreetWidget(context),
                  ),
                  Step(
                      isActive: _currentStep == 6,
                      title: Text("Tür"),
                      content: hayvanTurleri())
                ],
                currentStep: _currentStep,
              ));
        }));
  }

  Widget hayvanTurleri() {
    return Container(
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey),
            child: Checkbox(
              value: _dog,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _cat = false;
                    _dog = value;
                  } else {
                    _dog = value;
                  }
                });
              },
            ),
          ),
          Text(
            "Köpek",
            style: kLabelBlackStyle,
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey),
            child: Checkbox(
              value: _cat,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _dog = false;
                    _cat = value;
                  } else {
                    _cat = value;
                  }
                });
              },
            ),
          ),
          Text(
            "Kedi",
            style: kLabelBlackStyle,
          )
        ],
      ),
    );
  }

  Widget watchVideoButton(String text) {
    return Container(
      child: RaisedButton(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          child: Text(
            text,
            style: TextStyle(
              color: primaryColor,
              letterSpacing: 1.5,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed: () {
            AdmobManager().interstitialAd();
            didVideoWatch = true;
            setState(() {});
          }),
    );
  }
}
