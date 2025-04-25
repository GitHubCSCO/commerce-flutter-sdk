import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
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
  final Color? backgroundColor;
  final Color foregroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        alignment: Alignment.center,
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          isEnabled
              ? backgroundColor ?? OptiAppColors.primaryColor
              : (backgroundColor ?? OptiAppColors.primaryColor)
                  .withOpacity(AppStyle.disabledButtonOpacity),
        ),
        foregroundColor: WidgetStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
        shape: WidgetStateProperty.all(
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
  const SecondaryButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.backgroundColor = AppStyle.neutral75,
      this.foregroundColor = AppStyle.primary500,
      this.borderRadius = AppStyle.borderRadius,
      this.isEnabled = true,
      this.style});

  final String text;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final bool isEnabled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
        backgroundColor: WidgetStatePropertyAll(
          isEnabled
              ? backgroundColor
              : backgroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(text,
              style: style ?? TextStyle(color: OptiAppColors.primaryColor)),
        ),
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppStyle.neutral00,
    this.foregroundColor = AppStyle.primary500,
    this.borderColor = AppStyle.neutral200,
    this.borderRadius = AppStyle.borderRadius,
    this.isEnabled = true,
  });

  final String text;
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
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: isEnabled
                  ? borderColor
                  : borderColor.withOpacity(AppStyle.disabledButtonOpacity),
            ),
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(isEnabled
            ? foregroundColor
            : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity)),
        backgroundColor: WidgetStatePropertyAll(isEnabled
            ? backgroundColor
            : backgroundColor.withOpacity(AppStyle.disabledButtonOpacity)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: OptiAppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class PlainButton extends StatelessWidget {
  const PlainButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.foregroundColor = AppStyle.primary500,
      this.isEnabled = true,
      this.style});

  final String text;
  final Function()? onPressed;
  final Color foregroundColor;
  final bool isEnabled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        foregroundColor: WidgetStatePropertyAll(
          isEnabled
              ? foregroundColor
              : foregroundColor.withOpacity(AppStyle.disabledButtonOpacity),
        ),
      ),
      child: Text(
        text,
        style: style ?? TextStyle(color: OptiAppColors.primaryColor),
      ),
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
    required super.text,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}

class TertiaryBlackButton extends TertiaryButton {
  const TertiaryBlackButton({
    super.key,
    required super.text,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}

class PlainBlackButton extends PlainButton {
  const PlainBlackButton({
    super.key,
    required super.text,
    super.onPressed,
    super.isEnabled,
  }) : super(
          foregroundColor: AppStyle.neutral990,
        );
}
