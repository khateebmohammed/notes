import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant.dart';

awesomeDialog(context, title, subTitle) {
  return AwesomeDialog(
      dialogBorderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(15),
      animType: AnimType.BOTTOMSLIDE,
      borderSide: const BorderSide(color: forGroundColor, width: 0.5),
      context: context,
      btnCancel: TextButton(
          child: Text(
            "Cancel".tr,
            style: const TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Get.back();
          }),
      isDense: true,
      dialogType: DialogType.INFO,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      )).show();
}
