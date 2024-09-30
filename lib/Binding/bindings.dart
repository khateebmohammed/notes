import 'package:get/get.dart';

import '../Local/Controller/localController.dart';
import '../Notes/Controller/NoteController.dart';
import '../Services/Controller/SettingServices.dart';
import '../Sign In/Controller/SignInController.dart';
import '../SignUp/Controller/SignUpController.dart';
import '../Theme/Controller/themeController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingServices());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(NoteController());
    Get.put(LocalController());
    Get.put(ThemeController());
  }

}