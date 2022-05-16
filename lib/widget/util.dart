import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static const String IMG_KEY = 'IMAGE_KEY';

  static Future<bool> saveImageToPref(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(IMG_KEY, value);
  }

  static Future<String?> getImageFromPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(IMG_KEY);
  }

  static String base64String(Uint8List data) {
    return base64String(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}
