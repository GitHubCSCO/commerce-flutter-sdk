import 'package:commerce_flutter_sdk/src/core/theme/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_color_schemes.dart';
import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_colors_extension.dart';
import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light({Color seed = OptiAppColors.defaultPrimaryColor}) {
    final appColors = AppColors.light();
    final scheme = AppColorSchemes.light(seed: seed, appColors: appColors);
    final appText = AppTextStyles.from(scheme, appColors);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      disabledColor: appColors.disabledColor,
      iconTheme: IconThemeData(color: scheme.primary),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.backgroundGray,
        surfaceTintColor: appColors.backgroundGray,
        titleTextStyle: appText.titleLarge,
        iconTheme: IconThemeData(color: scheme.primary),
      ),
      dividerTheme: DividerThemeData(
        color: appColors.border,
        space: 1,
        thickness: 0.5,
      ),
      extensions: <ThemeExtension<dynamic>>[
        appColors,
        appText,
      ],
    );
  }
}
