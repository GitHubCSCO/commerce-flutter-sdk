import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor = AppStyle.primary500,
    this.foregroundColor = AppStyle.neutral00,
    this.borderRadius = AppStyle.borderRadius,
    this.isEnabled = true,
  });

  final Widget child;
  final Function()? onPressed;
  final bool isEnabled;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        alignment: Alignment.center,
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(
          isEnabled
              ? backgroundColor
              : backgroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
        foregroundColor: MaterialStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
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
    this.isEnabled = true,
  });

  final Widget child;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
        backgroundColor: MaterialStatePropertyAll(
          isEnabled
              ? backgroundColor
              : backgroundColor.withOpacity(AppStyle.disabledButtonOpacity),
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

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    this.child,
    this.onPressed,
    this.backgroundColor = AppStyle.neutral00,
    this.foregroundColor = AppStyle.primary500,
    this.borderColor = AppStyle.neutral200,
    this.borderRadius = AppStyle.borderRadius,
    this.isEnabled = true,
  });

  final Widget? child;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderRadius;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: isEnabled
                  ? borderColor
                  : borderColor.withOpacity(AppStyle.disabledButtonOpacity),
            ),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(isEnabled
            ? foregroundColor
            : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity)),
        backgroundColor: MaterialStatePropertyAll(isEnabled
            ? backgroundColor
            : backgroundColor.withOpacity(AppStyle.disabledButtonOpacity)),
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
    this.isEnabled = true,
  });

  final Widget child;
  final Function()? onPressed;
  final Color foregroundColor;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        foregroundColor: MaterialStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
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
    bool isEnabled = true,
  }) : super(
          child: child,
          onPressed: onPressed,
          backgroundColor: AppStyle.neutral990,
          foregroundColor: AppStyle.neutral00,
          isEnabled: isEnabled,
        );
}

class SecondaryBlackButton extends SecondaryButton {
  const SecondaryBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
    bool isEnabled = true,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
          isEnabled: isEnabled,
        );
}

class TertiaryBlackButton extends TertiaryButton {
  const TertiaryBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
    bool isEnabled = true,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
          isEnabled: isEnabled,
        );
}

class PlainBlackButton extends PlainButton {
  const PlainBlackButton({
    super.key,
    required Widget child,
    Function()? onPressed,
    bool isEnabled = true,
  }) : super(
          child: child,
          onPressed: onPressed,
          foregroundColor: AppStyle.neutral990,
          isEnabled: isEnabled,
        );
}
