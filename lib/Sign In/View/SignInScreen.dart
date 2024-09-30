import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/constant.dart';
import '../Controller/SignInController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SignInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: controller.validateKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.note_alt_outlined,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "loginWelcome".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "loginWelcome2".tr,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: paddingBoxDecoration(),
                      child: TextFormField(
                        onSaved: (emailVal) {
                          if (emailVal != null) {
                            controller.myEmail = emailVal;
                          }
                        },
                        validator: (String? emailVal) {
                          if (emailVal?.isEmpty == true) {
                            return "emptyField".tr;
                          } else {
                            var pattern = controller.emailRegex;
                            RegExp regexEmail = RegExp(pattern);
                            if (emailVal != null &&
                                !regexEmail.hasMatch(emailVal)) {
                              return "loginEmailValid".tr;
                            }
                          }

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email'.tr,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: Container(
                        decoration: paddingBoxDecoration(),
                        child: GetX<SignInController>(
                          builder: (controller) => TextFormField(
                            controller: controller.passwordController,
                            onSaved: (passwordVal) {
                              if (passwordVal != null) {
                                controller.myPassword = passwordVal;
                              }
                            },
                            validator: (String? passwordVal) {
                              if (passwordVal?.isEmpty == true) {
                                return "emptyField".tr;
                              } else {
                                var len = passwordVal?.length;
                                if (len! < 6) {
                                  return "passwordVerify1".tr;
                                } else if (len > 20) {
                                  return "passwordVerify2".tr;
                                }
                              }

                              return null;
                            },
                            obscureText: controller.securePass.value,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    if (controller.eyeState ==
                                        Icons.remove_red_eye_outlined) {
                                      controller.eyeState =
                                          Icons.visibility_off_outlined;
                                      controller.securePass.value = true;
                                    } else {
                                      controller.eyeState =
                                          Icons.remove_red_eye_outlined;
                                      controller.securePass.value = false;
                                    }
                                  },
                                  child: Icon(controller.eyeState)),
                              hintText: 'Password'.tr,
                              prefixIcon: const Icon(
                                Icons.password_outlined,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        if (controller.validateKey.currentState?.validate() ==
                            true) {
                          controller.validateKey.currentState?.save();
                          await controller.login(
                              context: context,
                              myEmail: controller.myEmail,
                              myPassword: controller.myPassword);
                        }
                      },
                      height: 50,
                      color: forGroundColor,
                      minWidth: double.infinity,
                      child: Text(
                        "SingIn".tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nonmember'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.offNamed("SignUp");
                        },
                        child: Text(
                          "Register".tr,
                          style: TextStyle(
                              color: Colors.blueAccent.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "forgetPassword".tr,
                    style: TextStyle(
                        color: Colors.blueAccent.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  paddingBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 1.5));
  }
}
