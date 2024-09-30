import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Services/Controller/SettingServices.dart';
import 'Binding/bindings.dart';
import 'Local/View/Languages.dart';
import 'Local/Model/local.dart';
import 'Local/Controller/localController.dart';
import 'Notes/View/screens/edi_add_notes_page.dart';
import 'Notes/View/screens/home_page.dart';
import 'Onboarding/View/OnboardingScreen.dart';
import 'Sign In/View/SignInScreen.dart';
import 'SignUp/View/signUpScreen.dart';
import 'Splash/Controller/SplashController.dart';
import 'Splash/View/SplashScreen.dart';
import 'Theme/Controller/themeController.dart';
import 'Theme/View/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initializing For FireBase
  await initialServices();
  runApp(const MyApp());
}

Future initialServices() async {
  await Get.putAsync(() => SettingServices().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());
    ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      getPages: [
        GetPage(
          name: "/OnBoarding",
          page: () => const OnBoarding(),
        ),
        GetPage(
            name: "/loginPage",
            page: () => const LoginPage(),
            middlewares: [AuthMeddleWare()]),
        GetPage(
          name: "/HomePage",
          page: () => const HomePage(),
        ),
        GetPage(
          name: "/edit_add_notes_page",
          page: () => const EditAddNotesPage(),
        ),
        GetPage(
          name: "/SignUp",
          page: () => const SignUp(),
        ),
        GetPage(
          name: "/Languages",
          page: () => const Languages(),
        ),
        GetPage(
          name: "/Themes",
          page: () => const Themes(),
        ),
        GetPage(
          name: "/SplashScreen",
          page: () => const SplashScreen(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      theme: themeController.initialTheme,

      initialRoute: "SplashScreen",
      initialBinding: MyBinding(),
      locale: localController.initialLang ?? Get.deviceLocale,
      translations: MyLocal(),
    );
  }
}
