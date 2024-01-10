import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/storefront_url_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.yellow,
      body: WelcomeFirstPage(),
    );
  }
}

class WelcomeFirstPage extends StatelessWidget {
  const WelcomeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WelcomeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              LocalizationKeyword.firstTimeWelcome,
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
            const Expanded(child: SizedBox()),
            WelcomePrimaryButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StorefrontUrlScreen(),
                  ),
                );
              },
              child: const Text(
                LocalizationKeyword.signInPrompt,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            WelcomeSecondaryButton(
              onPressed: () {},
              child: const Text(
                LocalizationKeyword.visitWebsite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
