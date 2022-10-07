import 'package:bi_pati/Utilities/Ads/AdmobManager.dart';
import 'package:bi_pati/Utilities/Firebase/PushNotificationsManager.dart';
import 'package:bi_pati/View/Auth/LoginView.dart';
import 'package:bi_pati/View/Auth/RegisterPart2.dart';
import 'package:bi_pati/View/Auth/RegisterPart3.dart';
import 'package:bi_pati/View/Auth/RegisterView.dart';
import 'package:bi_pati/View/Citizen/AddAnimalView.dart';
import 'package:bi_pati/View/Citizen/AnimalDetailView.dart';
import 'package:bi_pati/View/Citizen/ProfileAnimalView.dart';
import 'package:bi_pati/View/Citizen/ShelterAnimalDetailView.dart';
import 'package:bi_pati/View/Citizen/ShelterDetailView.dart';
import 'package:bi_pati/View/Citizen/SpecialBottomNavBar.dart';
import 'package:bi_pati/View/Citizen/VideoDonationView.dart';
import 'package:bi_pati/View/Corporate/CorporateMainView.dart';
import 'package:bi_pati/View/Logic/AppLogic.dart';
import 'package:flutter/material.dart';
import 'View/Auth/FirstPage.dart';
import 'View/Citizen/ShelterSectorDetailView.dart';
import 'package:bi_pati/introduction_animation/introduction_animation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseConfiguration();
  AdmobManager().initializeAdmob();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bi Pati",
      initialRoute: "/logic",
      routes: {
        "/logic": (context) => AppLogic(),
        "/login": (context) => LoginView(),
        "/register": (context) => RegisterView(),
        "/register_part_2": (context) => RegisterPart2(),
        "/register_part_3": (context) => RegisterPart3(),
        "/firs_page": (context) => FirsPage(),
        "/citizen_home": (context) => SpecialBottomNavBar(),
        "/video_donation": (context) => VideoDonationView(),
        "/shelter_detail": (context) => ShelterDetailView(),
        "/shelter_animal_detail": (context) => ShelterAnimalDetailView(),
        "/shelter_sector_detail": (context) => ShelterSectorDetailView(),
        "/animal_detail": (context) => AnimalDetail(),
        "/bio": (context) => IntroductionAnimationScreen(),
        "/profile_animal": (context) => ProfileAnimalView(),

        //Corporate
        "/corporate_main": (context) => CorporateMainView()
      },
    );
  }
}
