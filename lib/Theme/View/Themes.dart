import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/constant.dart';
import '../../Local/Controller/localController.dart';
import '../Controller/themeController.dart';

class Themes extends StatefulWidget {
  const Themes({Key? key}) : super(key: key);

  @override
  State<Themes> createState() => _ThemesState();
}

var groupValue2 =
    settingServices.sharedPreferences.getString("Theme") ?? "light";

class _ThemesState extends State<Themes> {
  ThemeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 1,
        title: Text("Drawer33".tr),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(
              "HomePage",
            );
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
                  secondary: const Icon(Icons.light_mode_outlined),
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: forGroundColor,
                  selected: groupValue2 == "light" ? true : false,
                  title: Text("Drawer4".tr),
                  value: "light",
                  groupValue: groupValue2,
                  onChanged: (value) {
                    setState(() {
                      groupValue2 = value!;
                      controller.changeTheme("light");
                    });
                  }),
            ),
            Card(
              child: RadioListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: forGroundColor,
                  selected: groupValue2 == "dark" ? true : false,
                  title: Text("Drawer44".tr),
                  value: "dark",
                  groupValue: groupValue2,
                  onChanged: (value) {
                    setState(() {
                      groupValue2 = value!;

                      controller.changeTheme("dark");
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
