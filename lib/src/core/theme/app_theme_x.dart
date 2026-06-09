import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_colors_extension.dart';
import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_text_styles.dart';
import 'package:flutter/material.dart';

extension AppThemeX on BuildContext {
  ColorScheme get scheme => Theme.of(this).colorScheme;

  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get text => Theme.of(this).extension<AppTextStyles>()!;
}
