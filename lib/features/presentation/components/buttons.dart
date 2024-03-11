import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.backgroundColor = AppStyle.primary500,
    this.foregroundColor = AppStyle.neutral00,
    this.borderRadius = AppStyle.borderRadius,
    this.isEnabled = true,
    this.leadingIcon,
    this.trailingIcon,
    required this.text,
  });

  final SvgPicture? leadingIcon;
  final SvgPicture? trailingIcon;
  final String text;
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              leadingIcon ?? const SizedBox.shrink(),
              const SizedBox(width: 10),
              Text(
                text,
                style: OptiTextStyles.subtitle.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 10),
              trailingIcon ?? const SizedBox.shrink(),
            ],
          ),
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
    super.onPressed,
    super.isEnabled,
    super.leadingIcon,
    super.trailingIcon,
    required super.text,
  }) : super(
          backgroundColor: AppStyle.neutral990,
          foregroundColor: AppStyle.neutral00,
        );
}

class SecondaryBlackButton extends SecondaryButton {
  const SecondaryBlackButton({
    super.key,
    required super.child,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}

class TertiaryBlackButton extends TertiaryButton {
  const TertiaryBlackButton({
    super.key,
    required Widget super.child,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}

class PlainBlackButton extends PlainButton {
  const PlainBlackButton({
    super.key,
    required super.child,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}
