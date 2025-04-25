import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  final bool domainChangePossible;

  const LandingScreen({
    super.key,
    required this.domainChangePossible,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(AssetConstants.logo),
              ),
            ),
          ),
          OrderBottomSectionWidget(
            actions: [
              PrimaryButton(
                text: LocalizationConstants.signIn.localized(),
                onPressed: () async {
                  var goToShop = await context.pushNamed(AppRoute.login.name);
                  if (goToShop == true && context.mounted) {
                    AppRoute.shop.navigate(context);
                  }
                },
              ),
              if (domainChangePossible)
                PlainButton(
                  text: LocalizationConstants.changeDomain.localized(),
                  onPressed: () =>
                      AppRoute.domainSelection.navigateBackStack(context),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
