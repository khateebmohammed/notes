import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> dialogBuilder(BuildContext context, String title) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: const Icon(
          Icons.login_outlined,
          color: Colors.blue,
          size: 26,
        ),
        title: Text(title),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SignUp4".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          )
        ],
      );
    },
  );
}
