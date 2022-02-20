import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MuseumService {

  static Future<void> openMap(String url) async {
    String googleUrl = url;
    try {
      await launch(googleUrl);
    } catch(e) {
      print(e);
    }
  }

}