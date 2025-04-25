import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeBaseScreen(
      child: WelcomeFirstPage(),
    );
  }
}

class WelcomeFirstPage extends StatelessWidget {
  const WelcomeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationConstants.firstTimeWelcome.localized(),
            style: WelcomeStyle.welcomeCardHeaderStyle,
          ),
          WelcomeStyle.welcomeCardTextSpacer,
          const Text(
            'This app enables Optimizely customers to easily access their B2B Commerce application.',
            style: WelcomeStyle.welcomeCardTextStyle,
          ),
          WelcomeStyle.welcomeCardTextSpacer,
          const Text(
            'If you\'re new to Optimizely and would like access to the mobile app version of your storefront, visit our website.',
            style: WelcomeStyle.welcomeCardTextStyle,
          ),
          WelcomeStyle.welcomeCardTextSpacer,
          const Text(
            'Sign in below if you are an existing customer.',
            style: WelcomeStyle.welcomeCardTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            onPressed: () {
              AppRoute.domainSelection.navigateBackStack(context);
            },
            text: LocalizationConstants.signInPrompt.localized(),
          ),
          const SizedBox(
            height: 2,
          ),
          TertiaryButton(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            text: LocalizationConstants.visitWebsite.localized(),
          ),
        ],
      ),
    );
  }
}
