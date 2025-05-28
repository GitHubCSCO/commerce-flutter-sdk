import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptiErrorWidget extends StatelessWidget {
  final String? errorText;
  final VoidCallback onRetry;

  const OptiErrorWidget({
    Key? key,
    this.errorText,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                AssetConstants.iconError,
              ),
            ),
            SizedBox(height: 20),
            Text(
              errorText ?? LocalizationConstants.errorLoading.localized(),
              style: OptiTextStyles.body,
            ),
            SizedBox(height: 20),
            TertiaryButton(
              text: LocalizationConstants.tryAgain.localized(),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
