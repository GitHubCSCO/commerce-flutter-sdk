import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutSuccessEntity {

  final String orderNumber;
  final bool isVmiCheckout;

  const CheckoutSuccessEntity({required this.orderNumber, required this.isVmiCheckout});

}

class CheckoutSuccessScreen extends StatelessWidget {

  final CheckoutSuccessEntity checkoutSuccessEntity;

  const CheckoutSuccessScreen({super.key, required this.checkoutSuccessEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundGray,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                "assets/images/checkout_icons/icon_success.svg",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                LocalizationConstants.orderPlacedSuccessfully.format([checkoutSuccessEntity.orderNumber]),
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PrimaryButton(
                onPressed: () {
                  if (checkoutSuccessEntity.isVmiCheckout) {
                    AppRoute.vmi.navigate(context);
                  } else {
                    AppRoute.shop.navigate(context);
                  }
                },
                text: checkoutSuccessEntity.isVmiCheckout ? LocalizationConstants.backToVmiHome : LocalizationConstants.continueShopping,
              ),
            )
          ],
        ),
      ),
    );
  }

}