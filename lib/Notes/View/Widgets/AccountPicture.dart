import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Components/constant.dart';
import '../../Controller/NoteController.dart';

Widget currPicture() {
  NoteController controller = Get.find();
  return InkWell(
    onTap: () async {
      print(FirebaseFirestore.instance.collection('user').doc().id);
      await Get.bottomSheet(Container(
        color: Colors.white,
        height: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please Select an Image",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: TextButton.icon(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.greenAccent.withAlpha(100))),
                label: const Text(
                  "From Gallery",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                icon: const Icon(
                  Icons.photo_album_outlined,
                  size: 30,
                ),
                onPressed: () {
                  controller.uploadGallery();
                  Get.back();
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: TextButton.icon(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10)),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.amberAccent.withAlpha(100))),
                label: const Text(
                  "From Camera",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                icon: const Icon(
                  Icons.photo_camera_outlined,
                  size: 30,
                ),
                onPressed: () {
                  controller.uploadCamera();
                 Get.back();
                },
              ),
            ),
          ],
        ),
      ));
    },
    child: CircleAvatar(
      backgroundColor: forGroundColor,
      foregroundImage: AssetImage("images/icon.png"),
      onForegroundImageError: (exception, stackTrace) {
        Fluttertoast.showToast(
            msg: "$exception", toastLength: Toast.LENGTH_LONG);
      },
    ),
  );
}
