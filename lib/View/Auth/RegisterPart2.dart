import 'package:bi_pati/Models/AnimalModel.dart';
import 'package:bi_pati/Network/AnimalService.dart';
import 'package:bi_pati/View/Citizen/AddAnimalView.dart';
import 'package:bi_pati/ViewModel/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/Styles.dart';

class RegisterPart2 extends StatefulWidget {
  const RegisterPart2({Key key}) : super(key: key);

  @override
  _RegisterPart2State createState() => _RegisterPart2State();
}

class _RegisterPart2State extends State<RegisterPart2> {
  ProfileController profileController = Get.put(ProfileController());
  //LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    //  locationController.getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                AnimalModel animalModel = new AnimalModel();
                animalModel.animals = [];
                if (profileController.petAnimalList?.value != null) {
                  profileController.petAnimalList.value.forEach((element) {
                    animalModel.animals.add(element);
                  });
                }
                if (profileController.streetAnimalList?.value != null) {
                  profileController.streetAnimalList.value.forEach((element) {
                    animalModel.animals.add(element);
                  });
                }

                await AnimalService()
                    .addAnimal(animalModel: animalModelToJson(animalModel));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/citizen_home", (route) => false);
              },
              icon: Icon(Icons.check)),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/citizen_home", (route) => false);
              },
              child: Text("Atla"))
        ],
        backgroundColor: primaryColor,
        title: Text(
          "Hayvanlarım",
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Evcil Hayvan Ekle",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAnimalView(1,""),
                                  ));
                            })
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileController.petAnimalList.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: (profileController
                                          .petAnimalList
                                          .value[index]
                                          ?.imageModel
                                          ?.imageFile ==
                                      null)
                                  ? Image.asset("assets/foto.png")
                                  : Image.file(
                                      profileController.petAnimalList
                                          .value[index].imageModel.imageFile,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                            Column(
                              children: [
                                Text(profileController
                                    .petAnimalList.value[index].name),
                                //Text("Van Kedisi"),
                                Text(profileController
                                        .petAnimalList.value[index].birthday ??
                                    ""),
                                //Text("Kocaeli - İzmit"),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sokak Hayvan Ekle",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAnimalView(0,""),
                                  ));
                            })
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileController.streetAnimalList.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: (profileController
                                          .streetAnimalList
                                          .value[index]
                                          ?.imageModel
                                          ?.imageFile ==
                                      null)
                                  ? Image.asset("assets/foto.png")
                                  : Image.file(
                                      profileController.streetAnimalList
                                          .value[index].imageModel.imageFile,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                            Column(
                              children: [
                                Text(profileController
                                    .streetAnimalList.value[index].name),
                                //Text("Van Kedisi"),
                                Text(profileController.streetAnimalList
                                        .value[index].birthday ??
                                    ""),
                                //Text("Kocaeli - İzmit"),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}