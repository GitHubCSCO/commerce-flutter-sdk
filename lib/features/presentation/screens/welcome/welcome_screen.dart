import 'package:commerce_flutter_app/core/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            const Text("Welcome to Optimizely B2B Mobile App") ,
            ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteNames.shop);
                },
                child: const Text("Go to B2B Store")),
          ],
        ),
      ),
    );
  }


  // Text("Welcome to Optimizely B2B Mobile App")
}