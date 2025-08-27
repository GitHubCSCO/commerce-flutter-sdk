import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/dialog_button_wrapper_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';

void showCancelOrderAlert(BuildContext context,
    {void Function()? onDismissAlert}) {
  displayDialogWidget(
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgAssetImage(
                height: 20,
                width: 20,
                assetName: AssetConstants.iconAlert,
                semanticsLabel: 'alert icon',
                fit: BoxFit.none,
                color: Colors.redAccent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  LocalizationConstants.cancelOrder.localized(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(LocalizationConstants.areYouSureYouWantToCancelTheEntireOrder
              .localized()),
        ],
      ),
      actions: [
        DialogButtonWrapper(
          child: SecondaryButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: LocalizationConstants.no.localized(),
          ),
        ),
        DialogButtonWrapper(
          child: TertiaryBlackButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDismissAlert?.call();
            },
            text: LocalizationConstants.yesCancel.localized(),
          ),
        ),
      ]);
}
