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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(WelcomeStyle.welcomeBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
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
        ],
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
    this.child,
    this.constraints = WelcomeStyle.welcomeFirstPageCardConstraints,
  });

  final Widget? child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Card(
        shape: WelcomeStyle.welcomeCardShape,
        elevation: 0,
        color: WelcomeStyle.welcomeCardColor,
        child: Padding(
          padding: WelcomeStyle.welcomeCardPadding,
          child: child,
        ),
      ),
    );
  }
}

class WelcomePrimaryButton extends StatelessWidget {
  const WelcomePrimaryButton({
    super.key,
    this.child,
    this.onPressed,
  });

  final Widget? child;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: onPressed != null
            ? MaterialStateProperty.all(
                WelcomeStyle.welcomeButtonColorAccent,
              )
            : null,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: WelcomeStyle.welcomeButtonBorderRadius,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class WelcomeSecondaryButton extends StatelessWidget {
  const WelcomeSecondaryButton({
    super.key,
    this.child,
    this.onPressed,
  });

  final Widget? child;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: WelcomeStyle.welcomeButtonColorAccent,
            ),
            borderRadius: WelcomeStyle.welcomeButtonBorderRadius,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          WelcomeStyle.welcomeButtonColorAccent,
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
