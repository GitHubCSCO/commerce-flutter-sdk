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

  static void showProductAddedToCart(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showAddToCartFailed(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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

  static void showSnackBarMessage(BuildContext context, String message,
      {int seconds = 1}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
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
      SnackBar(
        content: Text(LocalizationConstants.productDeleted.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showProductDeleteFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocalizationConstants.errorDeletingProduct.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showVMILocationNoteSaved(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocalizationConstants.locationNoteUpdated.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showVMILocationNoteNotSaved(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocalizationConstants.error.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showPromotionApplied(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocalizationConstants.promotionApplied.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showPromotionNotApplied(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(LocalizationConstants.promotionNotAppliedContinue.localized()),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showCreditCardDeletedsuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Card deleted successfully"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showCreditCardDeletedFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error deleting card"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showCreditCardSavedFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Can not add  card"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showBilltoShipToSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Changed Customer Successfully"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showBilltoShipToFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to Change Customer"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showSuccesss(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Success"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failure"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static showComingSoon(BuildContext context) {}
}
