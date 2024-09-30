import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:notes/Services/Controller/SettingServices.dart';
import '../../Components/constant.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    SettingServices controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IntroductionScreen(
            scrollPhysics: const BouncingScrollPhysics(),
            pages: [
              PageViewModel(
                titleWidget: const Text(
                  "Take notes.\nEverything is copy.\n\nI forgot my notebook, so I had to take notes on my phone.",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                body: '',
                image: Image.asset(
                  'images/1.png',
                  height: 250,
                  width: 250,
                ),
              ),
              PageViewModel(
                titleWidget: const Text(
                  "If you wish to forget anything on the spot, make a note that this thing is to be remembered.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                body: '"Edgar Allan Poe"',
                image: Image.asset(
                  'images/2.png',
                  height: 250,
                  width: 250,
                ),
              ),
              PageViewModel(
                titleWidget: const Text(
                  "Love, hope, fear, faith - these make humanity; These are its sign and note and character.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                body: '"Robert Browning"',
                image: Image.asset(
                  'images/3.png',
                  height: 250,
                  width: 250,
                ),
              ),
            ],
            onDone: () async {
              await controller.sharedPreferences.setBool("Seen", true);
              Get.offNamed("loginPage");
            },
            onSkip: () async {
              await controller.sharedPreferences.setBool("Seen", true);
              Get.offNamed("loginPage");
            },
            skip: Text(
              'Skip'.tr,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: forGroundColor),
            ),
            done: Text('Done'.tr,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: forGroundColor)),
            next: const Icon(Icons.arrow_forward, color: forGroundColor),
            controlsPadding: const EdgeInsets.symmetric(vertical: 20),
            showSkipButton: true,
            back: const Icon(Icons.arrow_back_outlined),
            dotsDecorator: DotsDecorator(
              size: const Size.square(10),
              activeSize: const Size(30, 10),
              activeColor: forGroundColor,
              spacing: const EdgeInsets.symmetric(horizontal: 3),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
      ),
    );
  }
}
