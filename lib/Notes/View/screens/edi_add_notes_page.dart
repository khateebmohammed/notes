import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Components/AwesomeDialoge.dart';
import '../../Controller/NoteController.dart';
import '../../Controller/helpers/cloud_firestore_helper.dart';

class EditAddNotesPage extends StatefulWidget {
  const EditAddNotesPage({Key? key}) : super(key: key);

  @override
  State<EditAddNotesPage> createState() => _EditAddNotesPageState();
}

class _EditAddNotesPageState extends State<EditAddNotesPage> {
  NoteController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.clearControllersAndVar();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isUpdate.value) {
      controller.res =
          ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;

      controller.titleController.text = "${controller.res!["title"]}";
      controller.descriptionController.text =
          "${controller.res!["description"]}";
    }
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 1,
       // backgroundColor: Colors.white,
        actions: [


          Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepPurple.shade300,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arial',
                      )),
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      awesomeDialog(context, "انت غير متصل بالانترنت", "");
                    } else {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();

                        Map<String, dynamic> data = {
                          "title": controller.title,
                          "description": controller.description,
                          "Date": DateTime.now().toString(),
                          "UId": FirebaseAuth.instance.currentUser?.uid,
                        };

                        if (controller.isUpdate.value) {
                          await CloudFirestoreHelper.cloudFirestoreHelper
                              .updateRecords(
                                  data: data, id: controller.res!.id);
                        } else {
                          CloudFirestoreHelper.cloudFirestoreHelper
                              .insertData(data: data);
                        }

                        Get.back();
                      }
                    }
                  },
                  child: Text(
                    (controller.isUpdate.value) ? "SAVE".tr : "ADD".tr,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: controller.titleController,
                  decoration: textFieldDecoration("Title".tr),
                  onSaved: (val) {
                    controller.title = val;
                  },
                  autofocus: true,
                  validator: (val) => (val!.isEmpty) ? "TitleFirst".tr : null,
                ),
                SizedBox(height: 1,),
                TextFormField(
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: controller.description == null
                      ? 20
                      : controller.description?.length,
                  controller: controller.descriptionController,
                  decoration: textFieldDecoration("Description".tr),
                  onSaved: (val) {
                    controller.description = val;
                  },
                  validator: (val) =>
                      (val!.isEmpty) ? "DescriptionFirst".tr : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      hintText: hint,
      fillColor: Get.isDarkMode
          ? Colors.grey.shade900
          : ([...Colors.primaries]..shuffle()).first.shade100,
      filled: true,
    );
  }
}
