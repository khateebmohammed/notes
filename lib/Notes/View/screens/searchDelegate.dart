import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import '../../Controller/NoteController.dart';

import '../../Controller/helpers/cloud_firestore_helper.dart';

class searchDelegate extends SearchDelegate {
  NoteController controller = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          query = "";
        },
        child: const Icon(
          Icons.close,
          size: 32,
        ),
      ),
      const SizedBox(
        width: 12,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: CloudFirestoreHelper.cloudFirestoreHelper.selectRecords(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            List<QueryDocumentSnapshot> filterData = snapshot.data!.docs
                .where((element) =>
                    element["title"].contains(query) ||
                    element["description"].contains(query))
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              physics: const ClampingScrollPhysics(),
              itemCount: query == "" ? data.length : filterData.length,
              itemBuilder: (context, i) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      controller.isUpdate.value = true;

                      Get.offNamed("edit_add_notes_page",
                          arguments: query == "" ? data[i] : filterData[i]);
                    },
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                            : ([...Colors.primaries]..shuffle()).first.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 15, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            query == ""
                                ? Text(
                                    "${data[i]["title"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Text(
                                    "${filterData[i]["title"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            query == ""
                                ? ReadMoreText(
                                    "${data[i]["description"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : ReadMoreText(
                                    "${filterData[i]["description"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            const SizedBox(height: 10),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: ([...Colors.primaries]
                                              ..shuffle())
                                            .first
                                            .shade300,
                                        content: Text(
                                          "Copied Note Successfully..",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.content_copy_rounded),
                                ),
                                IconButton(
                                  onPressed: () {
                                    CloudFirestoreHelper.cloudFirestoreHelper
                                        .deleteRecords(id: data[i].id);
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${(data[i]["Date"]).toString().split(" ").first}"),
                                  SizedBox(width: 10),
                                  Text("last update")
                                ],
                              ),
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
