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

  static void showProductAddedToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product Added to Cart"),
        duration: Duration(seconds: 1),
      ),
    );
  }

    static void showInvalidCVV(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invalid CVV"),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
