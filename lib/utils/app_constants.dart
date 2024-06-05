import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static ThemeMode themeMode = ThemeMode.light;
  static String language = 'UZ';
  static Color appColor = Colors.white12;

  static String password = '0412';
  static Color textColor = Colors.black;
  static double textSize = 14;

  Future<void> setConstants() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    /// theme
    String isDark = preferences.getString('isDark') ?? 'false';
    themeMode = isDark == 'true' ? ThemeMode.dark : ThemeMode.light;

    language = preferences.getString('language') ?? 'UZ';

    /// color
    int colorValues = preferences.getInt('app-color') ?? 1;
    appColor = colorValues == 1 ? Colors.white12 : Color(colorValues);

    /// password
    password = preferences.getString('password') ?? '1111';

    /// text settings
    String box = preferences.getString('text-val') ?? 'null';
    if (box != 'null') {
      final Map<String, dynamic> temp = jsonDecode(box);
      textSize = temp['text-size'];
      textColor = Color(temp['text-color']);
    }
  }
}
