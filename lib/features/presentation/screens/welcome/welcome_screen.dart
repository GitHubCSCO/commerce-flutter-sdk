import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
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

  // Text("Welcome to Optimizely B2B Mobile App")
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
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'This app enables Optimizely customers to easily access their B2B Commerce application.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'If you\'re new to Optimizely and would like access to the mobile app version of your storefront, visit our website.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Sign in below if you are an existing customer.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            const Expanded(child: SizedBox()),
            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.deepPurple,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    LocalizationKeyword.signInPrompt,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  Colors.deepPurple,
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(LocalizationKeyword.visitWebsite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360, maxHeight: 500),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0,
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: child,
        ),
      ),
    );
  }
}
