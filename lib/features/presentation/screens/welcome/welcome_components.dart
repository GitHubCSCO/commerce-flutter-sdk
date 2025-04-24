import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';

class WelcomeBaseScreen extends StatelessWidget {
  const WelcomeBaseScreen({
    super.key,
    required this.child,
    this.appBar,
  });

  final Widget child;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(WelcomeStyle.welcomeBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    WelcomeStyle.optimizelyLogo,
                    height: WelcomeStyle.optimizelyLogoHeight,
                    width: WelcomeStyle.optimizelyLogoWidth,
                  ),
                  Center(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: WelcomeStyle.welcomeCardShape,
      elevation: 0,
      color: WelcomeStyle.welcomeCardColor,
      child: Padding(
        padding: WelcomeStyle.welcomeCardPadding,
        child: child,
      ),
    );
  }
}
