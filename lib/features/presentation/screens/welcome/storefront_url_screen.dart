import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';

class StorefrontUrlScreen extends StatelessWidget {
  const StorefrontUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.yellow,
      body: const StorefrontUrlPage(),
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
