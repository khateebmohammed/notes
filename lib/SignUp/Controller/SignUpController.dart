import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Components/AwesomeDialoge.dart';
import '../../Components/ShowDialogMethod.dart';
import '../../Sign In/Controller/SignInController.dart';

class SignUpController extends GetxController {
  SignInController controller = Get.find();
  late UserCredential credential;
  User? user = FirebaseAuth.instance.currentUser;
  IconData eyeState = Icons.visibility_off_outlined;
  IconData eyeState2 = Icons.visibility_off_outlined;
  RxBool securePass = true.obs;
  RxBool securePass2 = true.obs;
  TextEditingController passwordController = TextEditingController();
  String myEmail1SignUp = '', myPassword1SignUp = '', myuUserNanmeSignUp = '';
  final validateKey2 = GlobalKey<FormState>();

  Future signUp({required context}) async {
    try {
      dialogBuilder(context, 'SignUp1'.tr);
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: myEmail1SignUp,
        password: myPassword1SignUp,
      )
       ;

      if (credential.user?.emailVerified == false) {
        await user?.sendEmailVerification();
        Get.back();
        controller.verify(context, myEmail1SignUp, myPassword1SignUp);
      } else {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(myEmail1SignUp)
            .set({
          'UserName': myuUserNanmeSignUp,
          'Email': myEmail1SignUp,
          'Password': myPassword1SignUp,
        });
        Get.offNamed("HomePage");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Fluttertoast.showToast(
            msg: "SignUp2".tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);
      } else if (e.code == 'email-already-in-use') {
        Get.back();

        Fluttertoast.showToast(
            msg: "SignUp3".tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);
        controller.verify(context, myEmail1SignUp, myPassword1SignUp);
      } else {
        Get.back();
        awesomeDialog(context, e.code.toString(), (e.message.toString()));
      }
    } catch (e) {
      Get.back();

      awesomeDialog(context, e.toString(), "");
    }
  }

  clearController() {
    passwordController.clear();
  }
}
