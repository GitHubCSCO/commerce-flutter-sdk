import 'package:flutter/material.dart';

class WelcomeStyle {
  static const TextStyle welcomeCardHeaderStyle = TextStyle(
    fontSize: 33,
    fontWeight: FontWeight.w200,
  );

  static const TextStyle welcomeCardTextStyle = TextStyle(
    fontWeight: FontWeight.w300,
  );

  static const Widget welcomeCardTextSpacer = SizedBox(height: 15);

  static const BoxConstraints welcomeFirstPageCardConstraints =
      BoxConstraints(maxWidth: 360, maxHeight: 500);

  static const BoxConstraints welcomeSecondPageCardConstraints =
      BoxConstraints(maxWidth: 360, maxHeight: 250);

  static const ShapeBorder welcomeCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  );

  static const Color welcomeCardColor = Color.fromRGBO(255, 255, 255, 0.8);

  static const EdgeInsetsGeometry welcomeCardPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 15);

  static const Color welcomeButtonColorAccent = Colors.deepPurple;

  static BorderRadius welcomeButtonBorderRadius = BorderRadius.circular(5);

  static const String optimizelyLogo = 'assets/images/optimizely-logo.png';

  static const String welcomeBackgroundImage =
      'assets/images/launch_screen_background@3x.png';

  static const double optimizelyLogoHeight = 120;

  static const double optimizelyLogoWidth = 120;
}
