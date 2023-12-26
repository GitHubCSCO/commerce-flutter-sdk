import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Welcome to Optimizely B2B Mobile App"),
            ElevatedButton(
                onPressed: () {
                  AppRoute.shop.navigate(context);
                },
                child: const Text("Go to B2B Store")),
          ],
        ),
      ),
    );
  }

  // Text("Welcome to Optimizely B2B Mobile App")
}
