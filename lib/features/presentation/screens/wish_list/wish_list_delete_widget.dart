import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:flutter/material.dart';

void displayWishListDeleteWidget({
  required WishListEntity wishList,
  required BuildContext context,
  required void Function() onDelete,
}) {
  displayDialogWidget(
    context: context,
    message: LocalizationConstants.deleteSpecificList.format(
      [wishList.name ?? ''],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(LocalizationConstants.cancel),
      ),
      TextButton(
        onPressed: () {
          onDelete();
          Navigator.of(context).pop();
        },
        child: const Text(LocalizationConstants.oK),
      ),
    ],
  );
}
