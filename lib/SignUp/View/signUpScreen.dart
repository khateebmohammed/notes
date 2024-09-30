import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/constant.dart';
import '../Controller/SignUpController.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
    controller.clearController();
  }

  SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.validateKey2,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const Icon(
                    Icons.app_registration,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "SignUpTitle".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "SignUpSubTitle".tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: Container(
                      decoration: paddingBoxDecoration(),
                      child: TextFormField(
                        onSaved: (username) {
                          if (username != null) {
                            controller.myuUserNanmeSignUp = username;
                          }
                        },
                        validator: (String? username) {
                          if (username == null || username.isEmpty) {
                            return 'emptyField'.tr;
                          } else {
                            username.trim();
                            var len = username.length;
                            if (len <= 4) {
                              return 'userNameVerify1'.tr;
                            } else if (len > 20) {
                              return "userNameVerify2".tr;
                            }
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: textInputDecoration(
                            'UserNameField'.tr, Icons.account_circle_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: Container(
                      decoration: paddingBoxDecoration(),
                      child: TextFormField(
                        onSaved: (emailVal) {
                          if (emailVal != null) {
                            controller.myEmail1SignUp = emailVal;
                          }
                        },
                        validator: (String? emailVal) {
                          if (emailVal == null || emailVal.isEmpty) {
                            return 'emptyField'.tr;
                          } else {
                            var pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            RegExp regexEmail = RegExp(pattern);
                            if (!regexEmail.hasMatch(emailVal)) {
                              return "loginEmailValid".tr;
                            }
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputDecoration(
                            'Email'.tr, Icons.email_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: GetX<SignUpController>(
                      builder: (controller) => Container(
                        decoration: paddingBoxDecoration(),
                        child: TextFormField(
                          controller: controller.passwordController,
                          onSaved: (passwordVal) {
                            if (passwordVal != null) {
                              controller.myPassword1SignUp = passwordVal;
                            }
                          },
                          validator: (String? passwordVal) {
                            if (passwordVal == null || passwordVal.isEmpty) {
                              return "emptyField".tr;
                            } else {
                              passwordVal.trim();
                              var len = passwordVal.length;

                              if (len < 6) {
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
                              Icons.password,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 15),
                    child: GetX<SignUpController>(
                      builder: (controller) => Container(
                        decoration: paddingBoxDecoration(),
                        child: TextFormField(
                          validator: (conPassword) {
                            if (controller.passwordController.text !=
                                    conPassword ||
                                conPassword?.isEmpty == true) {
                              return "WrongPassword".tr;
                            }
                            return null;
                          },
                          obscureText: controller.securePass2.value,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  if (controller.eyeState2 ==
                                      Icons.remove_red_eye_outlined) {
                                    controller.eyeState2 =
                                        Icons.visibility_off_outlined;
                                    controller.securePass2.value = true;
                                  } else {
                                    controller.eyeState2 =
                                        Icons.remove_red_eye_outlined;
                                    controller.securePass2.value = false;
                                  }
                                },
                                child: Icon(controller.eyeState2)),
                            hintText: 'ConfirmPassword'.tr,
                            prefixIcon: const Icon(
                              Icons.password,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        if (controller.validateKey2.currentState?.validate() ==
                            true) {
                          controller.validateKey2.currentState?.save();
                          await controller.signUp(context: context);
                        }
                      },
                      height: 50,
                      color: forGroundColor,
                      minWidth: double.infinity,
                      child: Text(
                        "SignUpButton".tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HaveAccount'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.offNamed("loginPage");
                        },
                        child: Text(
                          'login1'.tr,
                          style: TextStyle(
                              color: Colors.blueAccent.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
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

  textInputDecoration(String hintText, IconData prefixIcon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      border: InputBorder.none,
    );
  }
}
