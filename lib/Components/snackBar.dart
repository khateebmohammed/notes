import 'package:flutter/material.dart';

snackBar(context, title, color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.startToEnd,
        content: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: color),
  );
}
