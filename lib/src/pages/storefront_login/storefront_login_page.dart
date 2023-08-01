import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StorefrontLoginPage extends StatelessWidget {
  const StorefrontLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/optimizely-logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(
                width: 350,
                height: 400,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(
                    //   color: Theme.of(context).colorScheme.outline,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        _StorefrontWelcome(),
                        SizedBox(
                          height: 5,
                        ),
                        _StorefrontButton(
                          bodyText: 'Sign in to your B2B Store',
                          fill: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _StorefrontButton(
                          bodyText: 'Visit Optimizely.com',
                          fill: false,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorefrontButton extends StatelessWidget {
  const _StorefrontButton({required this.bodyText, required this.fill});

  final String bodyText;
  final bool fill;

  void onEvent() {
    debugPrint('Hello world');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: fill
          ? FilledButton(
              onPressed: onEvent,
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Text(bodyText),
              ),
            )
          : OutlinedButton(
              onPressed: onEvent,
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Text(bodyText),
              ),
            ),
    );
  }
}

class _StorefrontWelcome extends StatelessWidget {
  const _StorefrontWelcome();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Optimizely B2B Mobile App',
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 28,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'This app enables Optimizely customers to easily access their B2B Commerce application.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'If you\'re new to Optimizely and would like to access to the mobile app version of your storefront, visit out website.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Sign in below if you are an existing customer.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
