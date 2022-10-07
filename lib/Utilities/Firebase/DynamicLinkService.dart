/*
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicLinkService {

  SharedPreferences _prefs;
  String id;
  Future<String> createDynamicLink() async {
    _prefs = await SharedPreferences.getInstance();
    id = _prefs.getString("id");

    var name = _prefs.getString("name");
    var image = _prefs.getString("image");
    var bio = _prefs.getString("bio");


    String std;


      String url = "https://www.diji-card.com/panel/card/$id/view";



      final DynamicLinkParameters parameters = DynamicLinkParameters(

        navigationInfoParameters: NavigationInfoParameters(forcedRedirectEnabled: true),
        uriPrefix: 'https://diji.page.link',
        link: Uri.parse(url),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: (name == null) ? "" : "Diji Card - Dijital Kartvizit",
          imageUrl: (image == null) ? Uri.parse("") : Uri.parse(image),
          description: (bio == null) ? "" : name

        ),
        androidParameters: AndroidParameters(
          fallbackUrl: Uri.parse(url),
          packageName: 'com.ytcc.dijicard',
          minimumVersion: 1,
        ),
        iosParameters: IosParameters(
          fallbackUrl: Uri.parse(url),
          bundleId: 'com.ytcagent.dijicard',
          minimumVersion: '1',
          appStoreId: '1549451300',
        ),
      );
      final link = await parameters.buildUrl();
      final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
        link,
        DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
      );
      log(shortenedLink.shortUrl.toString());
      _prefs.setString("url", shortenedLink.shortUrl.toString());
      log(shortenedLink.shortUrl.toString());
      return shortenedLink.shortUrl.toString();


  }

}*/
