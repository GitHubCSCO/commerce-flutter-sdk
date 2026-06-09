import 'package:commerce_flutter_sdk/src/core/theme/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
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
  final Color? foregroundColor;
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
              ? backgroundColor ?? context.scheme.primary
              : (backgroundColor ?? context.scheme.primary)
                  .withValues(alpha: AppStyle.disabledButtonOpacity),
        ),
        foregroundColor: WidgetStatePropertyAll(
          isEnabled
              ? foregroundColor ?? context.colors.neutral00
              : (foregroundColor ?? context.colors.neutral00)
                  .withValues(alpha: AppStyle.disabledButtonOpacity),
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
              if (leadingIcon != null) ...{
                leadingIcon ?? const SizedBox.shrink(),
                const SizedBox(width: 10),
              },
              Text(
                text,
                style: context.text.subtitle.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
              if (trailingIcon != null) ...{
                const SizedBox(width: 10),
                trailingIcon ?? const SizedBox.shrink(),
              }
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
      this.backgroundColor,
      this.foregroundColor,
      this.borderRadius = AppStyle.borderRadius,
      this.isEnabled = true,
      this.style});

  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
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
              ? foregroundColor ?? context.scheme.primary
              : (foregroundColor ?? context.scheme.primary)
                  .withValues(alpha: AppStyle.disabledButtonOpacity),
        ),
        backgroundColor: WidgetStatePropertyAll(
          isEnabled
              ? backgroundColor ?? context.colors.neutral75
              : (backgroundColor ?? context.colors.neutral75)
                  .withValues(alpha: AppStyle.disabledButtonOpacity),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: style ??
                TextStyle(
                  color: isEnabled
                      ? context.scheme.primary
                      : context.scheme.primary
                          .withValues(alpha: AppStyle.disabledButtonOpacity),
                ),
          ),
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
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius = AppStyle.borderRadius,
    this.isEnabled = true,
  });

  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
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
                  ? borderColor ?? context.colors.neutral200
                  : (borderColor ?? context.colors.neutral200)
                      .withValues(alpha: AppStyle.disabledButtonOpacity),
            ),
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(isEnabled
            ? foregroundColor ?? context.scheme.primary
            : (foregroundColor ?? context.scheme.primary)
                .withValues(alpha: AppStyle.disabledButtonOpacity)),
        backgroundColor: WidgetStatePropertyAll(isEnabled
            ? backgroundColor ?? context.colors.neutral00
            : (backgroundColor ?? context.colors.neutral00)
                .withValues(alpha: AppStyle.disabledButtonOpacity)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: isEnabled
                    ? context.scheme.primary
                    : context.scheme.primary
                        .withValues(alpha: AppStyle.disabledButtonOpacity)),
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
      this.foregroundColor,
      this.isEnabled = true,
      this.style});

  final String text;
  final Function()? onPressed;
  final Color? foregroundColor;
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
              ? foregroundColor ?? context.scheme.primary
              : (foregroundColor ?? context.scheme.primary)
                  .withValues(alpha: AppStyle.disabledButtonOpacity),
        ),
      ),
      child: Text(
        text,
        style: style ?? TextStyle(color: context.scheme.primary),
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
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      isEnabled: isEnabled,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      backgroundColor: context.colors.neutral990,
      foregroundColor: context.colors.neutral00,
    );
  }
}

class SecondaryBlackButton extends SecondaryButton {
  const SecondaryBlackButton({
    super.key,
    required super.text,
    super.onPressed,
    super.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: text,
      onPressed: onPressed,
      isEnabled: isEnabled,
      foregroundColor: context.colors.neutral990,
    );
  }
}

class TertiaryBlackButton extends TertiaryButton {
  const TertiaryBlackButton({
    super.key,
    required super.text,
    super.onPressed,
    super.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return TertiaryButton(
      text: text,
      onPressed: onPressed,
      isEnabled: isEnabled,
      foregroundColor: context.colors.neutral990,
    );
  }
}

class PlainBlackButton extends PlainButton {
  const PlainBlackButton({
    super.key,
    required super.text,
    super.onPressed,
    super.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return PlainButton(
      text: text,
      onPressed: onPressed,
      isEnabled: isEnabled,
      foregroundColor: context.colors.neutral990,
    );
  }
}
