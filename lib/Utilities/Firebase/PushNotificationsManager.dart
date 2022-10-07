import 'package:bi_pati/Network/QueryService.dart';
import 'package:bi_pati/Utilities/Firebase/Notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

Future<void> firebaseConfiguration() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission(
      announcement: true, criticalAlert: true, provisional: true);
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _firebaseMessaging.getToken().then((token) async {
    print(token);
    await QueryService().updateFcm(token);
  });
  FirebaseMessaging.onMessage.listen((event) {
    print("ok");
  });

  FirebaseMessaging.onBackgroundMessage(notificationOnBackgroundMessageHandler);
}

notificationOnForeground(context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    FlutterRingtonePlayer.playNotification();
    print("burdayım amına koyam");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(event.notification.title),
            content: Text(event.notification.body),
            actions: [
              TextButton(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Notifications(message.notification.body),
        ));
  });
}

Future<void> notificationOnBackgroundMessageHandler(
    RemoteMessage message) async {
  Firebase.initializeApp();
  print('background message ${message.notification.body}');
}
