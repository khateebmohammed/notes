import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/AwesomeDialoge.dart';
import '../../Components/ShowDialogMethod.dart';


class SignInController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late UserCredential userCredential;
  RxBool securePass = true.obs;
  IconData eyeState = Icons.visibility_off_outlined;
  TextEditingController passwordController = TextEditingController();
  String myEmail = "", myPassword = "";
  String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  Future login(
      {required BuildContext context,
      required String myEmail,
      required String myPassword}) async {
    try {
      dialogBuilder(context, "login1".tr);
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: myEmail, password: myPassword);

      if (userCredential.user?.uid != null &&
          userCredential.user?.emailVerified == true) {
        Get.back();
        Get.snackbar('login2'.tr, "",
            backgroundColor: Colors.deepPurple.shade100);
        Get.offNamed("HomePage");
      } else {
        Get.back();

        await verify(context, myEmail, myPassword);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        AwesomeDialog(
            context: context,
            body: Column(
              children: [
                const Text('No user found for that email'),
                const SizedBox(
                  height: 20,
                ),
                const Text('لا يوجد مستخدم لهذا الحساب'),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  child: Text('login3'.tr),
                  onPressed: () {
                    Get.back();

                    Get.toNamed("SignUp");
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )).show();
      } else if (e.code == 'wrong-password') {
        Get.back();

        awesomeDialog(context, 'Wrong password provided for that user',
            "كلمة مرور خاطئة");
      } else if (e.code == 'user-disabled') {
        Get.back();

        awesomeDialog(context, e.code.toString(), (e.message.toString()));
      } else {
        Get.back();
        awesomeDialog(context, e.code.toString(), (e.message.toString()));
      }
    }
  }

  Future<void> verify(BuildContext context, String email, password) {
    bool stat = false;
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          icon: const Icon(
            Icons.verified_outlined,
            color: Colors.blue,
            size: 26,
          ),
          title: const Text(
            "اذهب الى بريدك الالكتروني وتاكد من رابط التحقق",
          ),
          content: Text(email,
              style: TextStyle(
                  color: Get.isDarkMode
                      ? Colors.blue.shade200
                      : Colors.blue.shade900,
                  fontWeight: FontWeight.bold)),
          actions: [
            stat == true
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.blue.withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              child: const Text('تـم'),
              onPressed: () {
                Get.back();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.blue.withOpacity(0.13),
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                child: const Text('تـحـقق'),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    if (credential.user?.emailVerified == false) {
                      Get.back();
                      awesomeDialog(context, 'Must Verification Your Email',
                          "يجب التحقق من البريد الالكتروني");
                    } else {
                      Get.snackbar('Successful Sign In', "",
                          backgroundColor: Colors.deepPurple.shade100);
                      Get.offNamed("HomePage");
                    }
                  } on FirebaseAuthException catch (ex) {
                    Get.snackbar(ex.code.toString(), ex.message.toString(),
                        backgroundColor: Colors.deepPurple.shade100);
                  }
                }),
          ],
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        );
      },
    );
  }
}
