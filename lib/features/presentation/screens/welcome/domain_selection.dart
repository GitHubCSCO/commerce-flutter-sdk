import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DomainSelectionScreen extends StatelessWidget {
  const DomainSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeBaseScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text(
              LocalizationKeyword.cancel,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      child: const DomainSelectionPage(),
    );
  }
}

class DomainSelectionPage extends StatefulWidget {
  const DomainSelectionPage({super.key});

  @override
  State<DomainSelectionPage> createState() => _DomainSelectionPageState();
}

class _DomainSelectionPageState extends State<DomainSelectionPage> {
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
                hintText: LocalizationKeyword.enterDomainHint,
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
              child: const Text(LocalizationKeyword.useECommerceWebsite),
            ),
          ],
        ),
      ),
    );
  }
}
