import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.push(AppRoute.domainSelection.path);
                    },
                    child: const Text('Change domain')),
                ElevatedButton(
                  onPressed: () {
                    AppRoute.login.navigate(context);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
