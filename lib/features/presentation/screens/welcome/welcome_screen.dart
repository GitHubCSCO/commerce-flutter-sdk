import 'package:commerce_flutter_app/core/config/app_router.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';

enum WelcomeScreenType {
  welcomePage,
  storefrontUrlPage,
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    this.welcomeScreenType = WelcomeScreenType.welcomePage,
  });

  final WelcomeScreenType welcomeScreenType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.yellow,
      body: welcomeScreenType == WelcomeScreenType.welcomePage
          ? const WelcomeFirstPage()
          : const StorefrontUrlPage(),
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
                    builder: (context) => const WelcomeScreen(
                      welcomeScreenType: WelcomeScreenType.storefrontUrlPage,
                    ),
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

class StorefrontUrlPage extends StatefulWidget {
  const StorefrontUrlPage({super.key});

  @override
  State<StorefrontUrlPage> createState() => _StorefrontUrlPageState();
}

class _StorefrontUrlPageState extends State<StorefrontUrlPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(() {});
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WelcomeCard(
        constraints: WelcomeStyle.welcomeSecondPageCardConstraints,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              LocalizationKeyword.existingCustomers,
              style: WelcomeStyle.welcomeCardHeaderStyle,
            ),
            WelcomeStyle.welcomeCardTextSpacer,
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Example: store.optimizely.com',
                border: OutlineInputBorder(),
                label: Text('Enter Store URL'),
              ),
            ),
            const Expanded(child: SizedBox()),
            WelcomePrimaryButton(
              onPressed: _textEditingController.text.isNotEmpty
                  ? () {
                      AppRoute.shop.navigate(context);
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
