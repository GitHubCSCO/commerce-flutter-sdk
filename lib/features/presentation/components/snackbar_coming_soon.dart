import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
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

  static void showAddToCartFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(SiteMessageConstants.defaultValueAddToCartFail),
        duration: const Duration(seconds: 1),
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

  static void showPoNumberRequired(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PO Number Required"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showWishListAddToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(SiteMessageConstants.defaultValueAddToCartAllProductsFromList),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showWishListAddToCartError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(SiteMessageConstants.defaultValueAddToCartFail),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showProductDeleted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.productDeleted),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showProductDeleteFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.errorDeletingProduct),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showListSaved(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.listSaved),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showRenameFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.renameFailed),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showListDeleted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.listDeleted),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showListUpdated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.listUpdated),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showUpdateFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(LocalizationConstants.update),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showCustomSnackBar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static showComingSoon(BuildContext context) {}
}
