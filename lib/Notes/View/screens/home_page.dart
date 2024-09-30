import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes/Notes/Controller/NoteController.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import '../../../Components/AwesomeDialoge.dart';
import '../../../Components/constant.dart';
import '../../../Components/snackBar.dart';
import '../../Controller/helpers/cloud_firestore_helper.dart';
import '../Widgets/AccountPicture.dart';
import 'searchDelegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getEmailDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showSearch(context: context, delegate: searchDelegate());
          },
          child: Text(
            "homePageAppbarTitle".tr,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                showSearch(context: context, delegate: searchDelegate());
              },
              icon: const Icon(
                Icons.search,
                size: 28,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              GetX<NoteController>(
                builder: (controller) => UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: forGroundColor),
                    currentAccountPicture: currPicture(),
                    currentAccountPictureSize: const Size.square(80),
                    accountName: Text(
                      controller.displayName.value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    accountEmail: Text(
                      "${controller.Email}",
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () {
                    Get.back();
                  },
                  title: Text("Drawer1".tr),
                  leading: const Icon(Icons.home_outlined),
                //  subtitle: Text('Drawer2'.tr),
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      "Themes",
                    );
                  },
                  title: Text("Drawer33".tr),
                 // subtitle: Text("Drawer3".tr),
                  trailing: const Icon(Icons.arrow_right),
                  leading: const Icon(Icons.color_lens_outlined),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      "Languages",
                    );
                  },
                  //subtitle: Text("Drawer16".tr),
                  title: Text("Drawer13".tr),
                  leading: const Icon(Icons.language_outlined),
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      awesomeDialog(context, "انت غير متصل بالانترنت", "");
                    } else {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: const Text(' هل أنت متأكد؟ '),
                            content: const Text(" تسجيل خروج "),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('لا'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('نعم'),
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .catchError((ex) {
                                    Fluttertoast.showToast(msg: ex.toString());
                                  });
                                  snackBar(context, ' Account signed out',
                                      Colors.blue);
                                  Get.toNamed("loginPage");
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  title: Text("Drawer5".tr),
                  leading: const Icon(Icons.logout_outlined),
                 // subtitle: Text('Drawer12'.tr),
                  // isThreeLine: true,
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      awesomeDialog(context, "انت غير متصل بالانترنت", "");
                    } else {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: const Text(' هل أنت متأكد؟ '),
                            content: const Text("  حذف الحساب نهائيا "),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('لا'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle:
                                          Theme.of(context).textTheme.labelLarge,
                                     ),
                                  child: const Text('نعم'),
                                  onPressed: () async {
                                    await FirebaseAuth.instance.currentUser
                                        ?.delete()
                                        .catchError((e) {
                                      Fluttertoast.showToast(msg: e);
                                    });
                                    snackBar(
                                        context, ' Account  deleted', Colors.red);

                                    Get.toNamed("loginPage");
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  title: Text("Drawer6".tr),
                  leading: const Icon(Icons.delete_forever_rounded),
                //  subtitle: Text('Drawer7'.tr),
                  // isThreeLine: true,
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text("Drawer8".tr),
                  leading: const Icon(Icons.help_outline_outlined),
                //  subtitle: Text('Drawer9'.tr),
                  // isThreeLine: true,
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () async {},
                  title: Text("Drawer10".tr),
                  leading: const Icon(Icons.info_outline),
                //  subtitle: Text("Drawer11".tr),
                  // isThreeLine: true,
                  trailing: const Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: forGroundColor,
        elevation: 8,
        tooltip: "FloatingButton".tr,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(5),
                topLeft: Radius.circular(5))),
        onPressed: () async {
          controller.isUpdate.value = false;
          Get.toNamed("edit_add_notes_page");
        },
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: CloudFirestoreHelper.cloudFirestoreHelper.selectRecords(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;

              if (data.isEmpty) {
                return const Center(
                    child: Text(
                  "لا يوجد ملاحظات",
                  style: TextStyle(fontFamily: "LBC", fontSize: 20),
                ));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: InkWell(
                        onTap: () {
                          controller.isUpdate.value = true;
                          Get.toNamed("edit_add_notes_page",
                              arguments: data[i]);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Get.isDarkMode
                                      ? Colors.grey.shade300
                                      : ([...Colors.primaries]..shuffle())
                                          .first
                                          .shade50,
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 1)
                            ],
                            color: Get.isDarkMode
                                ? Colors.grey.shade900
                                : ([...Colors.primaries]..shuffle())
                                    .first
                                    .shade100,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  "${data[i]["title"]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                ),
                                const SizedBox(height: 10),
                                ReadMoreText(
                                  "${data[i]["description"]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            await Share.share(
                                                "Title : ${data[i]["title"]}\nDescription : ${data[i]["description"]}");
                                          },
                                          icon: const Icon(Icons.share_rounded),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await Clipboard.setData(
                                              ClipboardData(
                                                text:
                                                    "Title : ${data[i]["title"]}\nDescription : ${data[i]["description"]}",
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: ([
                                                  ...Colors.primaries
                                                ]..shuffle())
                                                    .first
                                                    .shade300,
                                                content: Text(
                                                  "Copied".tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.content_copy_rounded),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            AwesomeDialog(
                                                dialogBorderRadius:
                                                    BorderRadius.circular(20),
                                                padding:
                                                    const EdgeInsets.all(20),
                                                animType: AnimType.BOTTOMSLIDE,
                                                borderSide: const BorderSide(
                                                    color: forGroundColor,
                                                    width: 0.5),
                                                context: context,
                                                btnOk: TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    Colors.blue[
                                                                        300])),
                                                    child: Text(
                                                      "OK".tr,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () async {
                                                      Get.back();
                                                      await CloudFirestoreHelper
                                                          .cloudFirestoreHelper
                                                          .deleteRecords(
                                                              id: data[i].id)
                                                          .catchError((ex) {
                                                        Fluttertoast.showToast(
                                                            msg: ex.toString());
                                                      });
                                                    }),
                                                btnCancel: TextButton(
                                                    child: Text(
                                                      "Cancel".tr,
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    }),
                                                isDense: true,
                                                dialogType: DialogType.INFO,
                                                body: Text(
                                                  "DeleteNote".tr,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                )).show();
                                          },
                                          icon:
                                              const Icon(Icons.delete_outline),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${(data[i]["Date"]).toString().split(" ").first}",
                                            ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("last update", )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
