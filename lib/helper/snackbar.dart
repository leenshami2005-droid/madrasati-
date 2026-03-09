import 'package:flutter/material.dart';

class sSnackbar {
  static void show(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
