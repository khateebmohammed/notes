import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Services/Controller/SettingServices.dart';

SettingServices controller = Get.find();

class AuthMeddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (controller.sharedPreferences.getBool("Seen") == true) {
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser?.emailVerified == true) {
        return const RouteSettings(name: "/HomePage");
      } else {
        // return const RouteSettings(name: "/loginPage");
        return null;

      }

    } else if (controller.sharedPreferences.getBool("Seen") == null) {
      return const RouteSettings(name: "/OnBoarding");
    }
    else {
      return null;
    }
  }
}
