import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundEnabledColor = AppStyle.primary500,
    this.backgroundDisabledColor = AppStyle.neutral200,
    this.foregroundColor = AppStyle.neutral00,
    this.borderRadius = AppStyle.borderRadius,
  });

  final Widget child;
  final Function()? onPressed;
  final Color backgroundEnabledColor;
  final Color backgroundDisabledColor;
  final Color foregroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: onPressed != null
            ? MaterialStatePropertyAll(
                backgroundEnabledColor,
              )
            : MaterialStatePropertyAll(
                backgroundDisabledColor,
              ),
        foregroundColor: onPressed != null
            ? MaterialStatePropertyAll(
                foregroundColor,
              )
            : const MaterialStatePropertyAll(
                AppStyle.neutral990,
              ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
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

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor = AppStyle.neutral75,
    this.foregroundColor = AppStyle.primary500,
    this.borderRadius = AppStyle.borderRadius,
  });

  final Widget child;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(foregroundColor),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
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

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    this.child,
    this.onPressed,
    this.backgroundColor = AppStyle.neutral00,
    this.foregroundColor = AppStyle.primary500,
    this.borderColor = AppStyle.neutral200,
    this.borderRadius = AppStyle.borderRadius,
  });

  final Widget? child;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(foregroundColor),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
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

class PlainButton extends StatelessWidget {
  const PlainButton({
    super.key,
    required this.child,
    this.onPressed,
    this.foregroundColor = AppStyle.primary500,
  });

  final Widget child;
  final Function()? onPressed;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        foregroundColor: MaterialStatePropertyAll(foregroundColor),
      ),
      child: child,
    );
  }
}

class PrimaryBlackButton extends PrimaryButton {
  const PrimaryBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
  }) : super(
          child: child,
          onPressed: onPressed,
          backgroundEnabledColor: AppStyle.neutral990,
          backgroundDisabledColor: AppStyle.neutral200,
          foregroundColor: AppStyle.neutral00,
        );
}

class SecondaryBlackButton extends SecondaryButton {
  const SecondaryBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
        );
}

class TertiaryBlackButton extends TertiaryButton {
  const TertiaryBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
        );
}

class PlainBlackButton extends PlainButton {
  const PlainBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
        );
}
