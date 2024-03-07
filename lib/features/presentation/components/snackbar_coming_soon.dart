import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showComingSoonSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming Soon"),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
