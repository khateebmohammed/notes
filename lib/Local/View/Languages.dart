import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/constant.dart';
import '../Controller/localController.dart';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

var groupValue =  settingServices.sharedPreferences.getString("lang") ?? Get.deviceLocale?.languageCode;

class _LanguagesState extends State<Languages> {
  LocalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 1,
        title: Text("Drawer13".tr),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed("HomePage");

          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(
            "HomePage",
          );
          return true;
        },
        child: Column(
          children: <Widget>[
            Card(
              child: RadioListTile(
                  secondary: const Icon(Icons.flag),
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: forGroundColor,
                  selected: groupValue == "ar" ? true : false,
                  // selected: Get.deviceLocale?.languageCode == "ar" ? true : false,
                  title: Text("Drawer14".tr),
                  value: "ar",
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;

                      controller.changeLang(groupValue!);
                    });
                  }),
            ),
            Card(
              child: RadioListTile(
                  secondary: const Icon(Icons.flag),
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: forGroundColor,
                  selected: groupValue == "en" ? true : false,
                  //selected: Get.deviceLocale?.languageCode == "ar" ? true : false,
                  title: Text("Drawer15".tr),
                  value: "en",
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;

                      controller.changeLang(groupValue!);
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
