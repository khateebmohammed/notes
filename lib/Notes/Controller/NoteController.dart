import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class NoteController extends GetxController {
  RxBool isUpdate = false.obs;
  RxString displayName = "".obs;
  String? Email;
  String? title;
  String? description;
  File? file;
  String? imageName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  QueryDocumentSnapshot? res;

  getEmailDisplayName() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      Email = FirebaseAuth.instance.currentUser?.email!;
    }
    FirebaseFirestore.instance
        .collection('user')
        .where("Email", isEqualTo: user?.email)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element.exists) {
                  displayName.value = element.data()["UserName"] ?? "Unknown";
                }
              })
            })
      .catchError((ex) {
print("object");
        //Fluttertoast.showToast(msg: ex.toString());
      });
  }

  clearControllersAndVar() {
    titleController.clear();
    descriptionController.clear();
    title = null;
    description = null;
  }

  Future uploadCamera() async {
    var pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 400,
        preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      imageName = basename(pickedImage.path);
    } else {
      Fluttertoast.showToast(msg: 'لم يتم اختيار صورة');
    }
  }

  Future uploadGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      imageName = basename("myImage.jpg");
    } else {
      Fluttertoast.showToast(msg: 'لم يتم اختيار صورة');
    }
  }
}
