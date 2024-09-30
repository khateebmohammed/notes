import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/Controller/SettingServices.dart';

SettingServices settingServices = Get.find();

class LocalController extends GetxController {
  Locale? initialLang = settingServices.sharedPreferences.getString("lang") !=
          null
      ? Locale(settingServices.sharedPreferences.getString("lang") as String)
      : Get.deviceLocale;

  void changeLang(String codeLang) async {
    Locale currLang = Locale(codeLang);
    await settingServices.sharedPreferences.setString("lang", codeLang);

    initialLang =
        Locale(settingServices.sharedPreferences.getString("lang") as String);

    await Get.updateLocale(currLang);
  }
}
