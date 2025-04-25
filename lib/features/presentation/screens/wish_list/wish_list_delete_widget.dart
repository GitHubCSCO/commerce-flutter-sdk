import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/dialog.dart';
import 'package:flutter/material.dart';

void displayWishListDeleteWidget({
  required WishListEntity wishList,
  required BuildContext context,
  required void Function() onDelete,
}) {
  displayDialogWidget(
    context: context,
    message: LocalizationConstants.deleteSpecificList.localized().format(
      [wishList.name ?? ''],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.cancel.localized()),
      ),
      TextButton(
        onPressed: () {
          onDelete();
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ],
  );
}
