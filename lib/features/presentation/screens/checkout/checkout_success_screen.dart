import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutSuccessScreen extends StatelessWidget {

  final String orderNumber;

  const CheckoutSuccessScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              "assets/images/icon_shop_categories.svg",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              LocalizationConstants.orderPlacedSuccessfully.format([orderNumber]),
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PrimaryButton(
              onPressed: () {
                AppRoute.shop.navigate(context);
              },
              text: LocalizationConstants.continueShopping,
            ),
          )
        ],
      ),
    );
  }

}