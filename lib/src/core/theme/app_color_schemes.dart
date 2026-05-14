import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_colors_extension.dart';
import 'package:flutter/material.dart';

class AppColorSchemes {
  AppColorSchemes._();

  static ColorScheme light({
    required Color seed,
    required AppColors appColors,
  }) {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: seed,
      onPrimary: appColors.onPrimary,
      primaryContainer: appColors.primaryContainer,
      onPrimaryContainer: appColors.onPrimaryContainer,
      secondary: appColors.secondary,
      onSecondary: appColors.onSecondary,
      secondaryContainer: appColors.secondaryContainer,
      onSecondaryContainer: appColors.onSecondaryContainer,
      error: appColors.error,
      onError: appColors.onError,
      background: appColors.background,
      onBackground: appColors.onBackground,
      surface: appColors.surface,
      onSurface: appColors.onSurface,
      outline: appColors.outline,
    );
  }
}
