import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/constant.dart';
import '../../Local/Controller/localController.dart';

class ThemeController extends GetxController {
  ThemeData initialTheme =
      settingServices.sharedPreferences.getString("Theme") == "light" ||
              settingServices.sharedPreferences.getString("Theme") == null
          ? customLightTheme
          : customDarkTheme;

  static ThemeData customLightTheme = ThemeData.light().copyWith(

      scaffoldBackgroundColor: backGroundPageColor,
      primaryColor: const Color(0xFF6C63FF),
      useMaterial3: true,


      appBarTheme: AppBarTheme(
        backgroundColor:  Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 65,
      ));

  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black87,
      primaryColor: const Color(0xFF6C63FF),

      appBarTheme: AppBarTheme(
        color: CupertinoColors.black.withOpacity(0.3),
        foregroundColor: Colors.white,
      ));

  changeTheme(String theme) async {
    await settingServices.sharedPreferences.setString("Theme", theme);
    initialTheme =
        settingServices.sharedPreferences.getString("Theme") == "light"
            ? customLightTheme
            : customDarkTheme;
    Get.changeTheme(initialTheme);
  }
}
