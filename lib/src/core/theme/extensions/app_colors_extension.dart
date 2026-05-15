import 'package:commerce_flutter_sdk/src/core/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color backgroundWhite;
  final Color textPrimary;
  final Color textSecondary;
  final Color textBodyColor;
  final Color textFadeColor;
  final Color textLink;
  final Color backgroundGray;
  final Color border;
  final Color ctaPrimary;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color backgroundInput;
  final Color inputFocusShadow;
  final Color optiTextPrimaryColor;
  final Color defaultPrimaryColor;
  final Color primaryColor;
  final Color headerTextColor;
  final Color cursorColor;
  final Color denyTextColor;
  final Color dividerColor;
  final Color listBackgroundColor;
  final Color inStockColor;
  final Color lowStockColor;
  final Color outOfStockColor;
  final Color quantityPricingFirstBackgroundColor;
  final Color quantityPricingSecondBackgroundColor;
  final Color defaultBorderColor;
  final Color listBorderColor;
  final Color darkGrayTextColor;
  final Color mediumGrayTextColor;
  final Color lightGrayTextColor;
  final Color unselectedTextColor;
  final Color selectedTextColor;
  final Color hintTextColor;
  final Color invalidColor;
  final Color successColor;
  final Color successBackgroundColor;
  final Color textFieldBackgroundColor;
  final Color textFieldBorderColor;
  final Color textFieldBorderShadowColor;
  final Color buttonTextDisabledColor;
  final Color buttonBackgroundDisabledColor;
  final Color buttonBorderDisabledColor;
  final Color buttonBorderColor;
  final Color buttonAddColor;
  final Color buttonDeleteColor;
  final Color buttonLeaveColor;
  final Color buttonRefreshColor;
  final Color buttonEditColor;
  final Color buttonDarkRedBackgroundColor;
  final Color navIconUncheckedColor;
  final Color gradientFirstColor;
  final Color gradientSecondColor;
  final Color messageBackgroundColor;
  final Color spacerBackgroundColor;
  final Color textDisabledColor;
  final Color grayBackgroundColor;

  /// scheme colors
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color outline;
  final Color disabledColor;

  const AppColors({
    required this.backgroundWhite,
    required this.textPrimary,
    required this.textSecondary,
    required this.textBodyColor,
    required this.textFadeColor,
    required this.textLink,
    required this.backgroundGray,
    required this.border,
    required this.ctaPrimary,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.backgroundInput,
    required this.inputFocusShadow,
    required this.optiTextPrimaryColor,
    required this.defaultPrimaryColor,
    required this.primaryColor,
    required this.headerTextColor,
    required this.cursorColor,
    required this.denyTextColor,
    required this.dividerColor,
    required this.listBackgroundColor,
    required this.inStockColor,
    required this.lowStockColor,
    required this.outOfStockColor,
    required this.quantityPricingFirstBackgroundColor,
    required this.quantityPricingSecondBackgroundColor,
    required this.defaultBorderColor,
    required this.listBorderColor,
    required this.darkGrayTextColor,
    required this.mediumGrayTextColor,
    required this.lightGrayTextColor,
    required this.unselectedTextColor,
    required this.selectedTextColor,
    required this.hintTextColor,
    required this.invalidColor,
    required this.successColor,
    required this.successBackgroundColor,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderColor,
    required this.textFieldBorderShadowColor,
    required this.buttonTextDisabledColor,
    required this.buttonBackgroundDisabledColor,
    required this.buttonBorderDisabledColor,
    required this.buttonBorderColor,
    required this.buttonAddColor,
    required this.buttonDeleteColor,
    required this.buttonLeaveColor,
    required this.buttonRefreshColor,
    required this.buttonEditColor,
    required this.buttonDarkRedBackgroundColor,
    required this.navIconUncheckedColor,
    required this.gradientFirstColor,
    required this.gradientSecondColor,
    required this.messageBackgroundColor,
    required this.spacerBackgroundColor,
    required this.textDisabledColor,
    required this.grayBackgroundColor,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.outline,
    required this.disabledColor,
  });

  factory AppColors.light() => AppColors(
        backgroundWhite: OptiAppColors.backgroundWhite,
        textPrimary: OptiAppColors.textPrimary,
        textSecondary: OptiAppColors.textSecondary,
        textBodyColor: OptiAppColors.textBodyColor,
        textFadeColor: OptiAppColors.textFadeColor,
        textLink: OptiAppColors.textLink,
        backgroundGray: OptiAppColors.backgroundGray,
        border: OptiAppColors.border,
        ctaPrimary: OptiAppColors.ctaPrimary,
        iconPrimary: OptiAppColors.iconPrimary,
        iconSecondary: OptiAppColors.iconSecondary,
        backgroundInput: OptiAppColors.backgroundInput,
        inputFocusShadow: OptiAppColors.inputFocusShadow,
        optiTextPrimaryColor: OptiAppColors.optiTextPrimaryColor,
        defaultPrimaryColor: OptiAppColors.defaultPrimaryColor,
        primaryColor: OptiAppColors.primaryColor,
        headerTextColor: OptiAppColors.headerTextColor,
        cursorColor: OptiAppColors.cursorColor,
        denyTextColor: OptiAppColors.denyTextColor,
        dividerColor: OptiAppColors.dividerColor,
        listBackgroundColor: OptiAppColors.listBackgroundColor,
        inStockColor: OptiAppColors.inStockColor,
        lowStockColor: OptiAppColors.lowStockColor,
        outOfStockColor: OptiAppColors.outOfStockColor,
        quantityPricingFirstBackgroundColor:
            OptiAppColors.quantityPricingFirstBackgroundColor,
        quantityPricingSecondBackgroundColor:
            OptiAppColors.quantityPricingSecondBackgroundColor,
        defaultBorderColor: OptiAppColors.defaultBorderColor,
        listBorderColor: OptiAppColors.listBorderColor,
        darkGrayTextColor: OptiAppColors.darkGrayTextColor,
        mediumGrayTextColor: OptiAppColors.mediumGrayTextColor,
        lightGrayTextColor: OptiAppColors.lightGrayTextColor,
        unselectedTextColor: OptiAppColors.unselectedTextColor,
        selectedTextColor: OptiAppColors.selectedTextColor,
        hintTextColor: OptiAppColors.hintTextColor,
        invalidColor: OptiAppColors.invalidColor,
        successColor: OptiAppColors.successColor,
        successBackgroundColor: OptiAppColors.successBackgroundColor,
        textFieldBackgroundColor: OptiAppColors.textFieldBackgroundColor,
        textFieldBorderColor: OptiAppColors.textFieldBorderColor,
        textFieldBorderShadowColor: OptiAppColors.textFieldBorderShadowColor,
        buttonTextDisabledColor: OptiAppColors.buttonTextDisabledColor,
        buttonBackgroundDisabledColor:
            OptiAppColors.buttonBackgroundDisabledColor,
        buttonBorderDisabledColor: OptiAppColors.buttonBorderDisabledColor,
        buttonBorderColor: OptiAppColors.buttonBorderColor,
        buttonAddColor: OptiAppColors.buttonAddColor,
        buttonDeleteColor: OptiAppColors.buttonDeleteColor,
        buttonLeaveColor: OptiAppColors.buttonLeaveColor,
        buttonRefreshColor: OptiAppColors.buttonRefreshColor,
        buttonEditColor: OptiAppColors.buttonEditColor,
        buttonDarkRedBackgroundColor:
            OptiAppColors.buttonDarkRedBackgroundColor,
        navIconUncheckedColor: OptiAppColors.navIconUncheckedColor,
        gradientFirstColor: OptiAppColors.gradientFirstColor,
        gradientSecondColor: OptiAppColors.gradientSecondColor,
        messageBackgroundColor: OptiAppColors.messageBackgroundColor,
        spacerBackgroundColor: OptiAppColors.spacerBackgroundColor,
        textDisabledColor: OptiAppColors.textDisabledColor,
        grayBackgroundColor: OptiAppColors.grayBackgroundColor,
        onPrimary: OptiAppColors.onPrimary,
        primaryContainer: OptiAppColors.primaryContainer,
        onPrimaryContainer: OptiAppColors.onPrimaryContainer,
        secondary: OptiAppColors.secondary,
        onSecondary: OptiAppColors.onSecondary,
        secondaryContainer: OptiAppColors.secondaryContainer,
        onSecondaryContainer: OptiAppColors.onSecondaryContainer,
        error: OptiAppColors.error,
        onError: OptiAppColors.onError,
        background: OptiAppColors.background,
        onBackground: OptiAppColors.onBackground,
        surface: OptiAppColors.surface,
        onSurface: OptiAppColors.onSurface,
        outline: OptiAppColors.outline,
        disabledColor: OptiAppColors.disabledColor,
      );

  @override
  AppColors copyWith({
    Color? backgroundWhite,
    Color? textPrimary,
    Color? textSecondary,
    Color? textBodyColor,
    Color? textFadeColor,
    Color? textLink,
    Color? backgroundGray,
    Color? border,
    Color? ctaPrimary,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? backgroundInput,
    Color? inputFocusShadow,
    Color? optiTextPrimaryColor,
    Color? defaultPrimaryColor,
    Color? primaryColor,
    Color? headerTextColor,
    Color? cursorColor,
    Color? denyTextColor,
    Color? dividerColor,
    Color? listBackgroundColor,
    Color? inStockColor,
    Color? lowStockColor,
    Color? outOfStockColor,
    Color? quantityPricingFirstBackgroundColor,
    Color? quantityPricingSecondBackgroundColor,
    Color? defaultBorderColor,
    Color? listBorderColor,
    Color? darkGrayTextColor,
    Color? mediumGrayTextColor,
    Color? lightGrayTextColor,
    Color? unselectedTextColor,
    Color? selectedTextColor,
    Color? hintTextColor,
    Color? invalidColor,
    Color? successColor,
    Color? successBackgroundColor,
    Color? textFieldBackgroundColor,
    Color? textFieldBorderColor,
    Color? textFieldBorderShadowColor,
    Color? buttonTextDisabledColor,
    Color? buttonBackgroundDisabledColor,
    Color? buttonBorderDisabledColor,
    Color? buttonBorderColor,
    Color? buttonAddColor,
    Color? buttonDeleteColor,
    Color? buttonLeaveColor,
    Color? buttonRefreshColor,
    Color? buttonEditColor,
    Color? buttonDarkRedBackgroundColor,
    Color? navIconUncheckedColor,
    Color? gradientFirstColor,
    Color? gradientSecondColor,
    Color? messageBackgroundColor,
    Color? spacerBackgroundColor,
    Color? textDisabledColor,
    Color? grayBackgroundColor,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? error,
    Color? onError,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? outline,
    Color? disabledColor,
  }) =>
      AppColors(
        backgroundWhite: backgroundWhite ?? this.backgroundWhite,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textBodyColor: textBodyColor ?? this.textBodyColor,
        textFadeColor: textFadeColor ?? this.textFadeColor,
        textLink: textLink ?? this.textLink,
        backgroundGray: backgroundGray ?? this.backgroundGray,
        border: border ?? this.border,
        ctaPrimary: ctaPrimary ?? this.ctaPrimary,
        iconPrimary: iconPrimary ?? this.iconPrimary,
        iconSecondary: iconSecondary ?? this.iconSecondary,
        backgroundInput: backgroundInput ?? this.backgroundInput,
        inputFocusShadow: inputFocusShadow ?? this.inputFocusShadow,
        optiTextPrimaryColor: optiTextPrimaryColor ?? this.optiTextPrimaryColor,
        defaultPrimaryColor: defaultPrimaryColor ?? this.defaultPrimaryColor,
        primaryColor: primaryColor ?? this.primaryColor,
        headerTextColor: headerTextColor ?? this.headerTextColor,
        cursorColor: cursorColor ?? this.cursorColor,
        denyTextColor: denyTextColor ?? this.denyTextColor,
        dividerColor: dividerColor ?? this.dividerColor,
        listBackgroundColor: listBackgroundColor ?? this.listBackgroundColor,
        inStockColor: inStockColor ?? this.inStockColor,
        lowStockColor: lowStockColor ?? this.lowStockColor,
        outOfStockColor: outOfStockColor ?? this.outOfStockColor,
        quantityPricingFirstBackgroundColor:
            quantityPricingFirstBackgroundColor ??
                this.quantityPricingFirstBackgroundColor,
        quantityPricingSecondBackgroundColor:
            quantityPricingSecondBackgroundColor ??
                this.quantityPricingSecondBackgroundColor,
        defaultBorderColor: defaultBorderColor ?? this.defaultBorderColor,
        listBorderColor: listBorderColor ?? this.listBorderColor,
        darkGrayTextColor: darkGrayTextColor ?? this.darkGrayTextColor,
        mediumGrayTextColor: mediumGrayTextColor ?? this.mediumGrayTextColor,
        lightGrayTextColor: lightGrayTextColor ?? this.lightGrayTextColor,
        unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        hintTextColor: hintTextColor ?? this.hintTextColor,
        invalidColor: invalidColor ?? this.invalidColor,
        successColor: successColor ?? this.successColor,
        successBackgroundColor:
            successBackgroundColor ?? this.successBackgroundColor,
        textFieldBackgroundColor:
            textFieldBackgroundColor ?? this.textFieldBackgroundColor,
        textFieldBorderColor: textFieldBorderColor ?? this.textFieldBorderColor,
        textFieldBorderShadowColor:
            textFieldBorderShadowColor ?? this.textFieldBorderShadowColor,
        buttonTextDisabledColor:
            buttonTextDisabledColor ?? this.buttonTextDisabledColor,
        buttonBackgroundDisabledColor:
            buttonBackgroundDisabledColor ?? this.buttonBackgroundDisabledColor,
        buttonBorderDisabledColor:
            buttonBorderDisabledColor ?? this.buttonBorderDisabledColor,
        buttonBorderColor: buttonBorderColor ?? this.buttonBorderColor,
        buttonAddColor: buttonAddColor ?? this.buttonAddColor,
        buttonDeleteColor: buttonDeleteColor ?? this.buttonDeleteColor,
        buttonLeaveColor: buttonLeaveColor ?? this.buttonLeaveColor,
        buttonRefreshColor: buttonRefreshColor ?? this.buttonRefreshColor,
        buttonEditColor: buttonEditColor ?? this.buttonEditColor,
        buttonDarkRedBackgroundColor:
            buttonDarkRedBackgroundColor ?? this.buttonDarkRedBackgroundColor,
        navIconUncheckedColor:
            navIconUncheckedColor ?? this.navIconUncheckedColor,
        gradientFirstColor: gradientFirstColor ?? this.gradientFirstColor,
        gradientSecondColor: gradientSecondColor ?? this.gradientSecondColor,
        messageBackgroundColor:
            messageBackgroundColor ?? this.messageBackgroundColor,
        spacerBackgroundColor:
            spacerBackgroundColor ?? this.spacerBackgroundColor,
        textDisabledColor: textDisabledColor ?? this.textDisabledColor,
        grayBackgroundColor: grayBackgroundColor ?? this.grayBackgroundColor,
        onPrimary: onPrimary ?? this.onPrimary,
        primaryContainer: primaryContainer ?? this.primaryContainer,
        onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
        secondary: secondary ?? this.secondary,
        onSecondary: onSecondary ?? this.onSecondary,
        secondaryContainer: secondaryContainer ?? this.secondaryContainer,
        onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
        error: error ?? this.error,
        onError: onError ?? this.onError,
        background: background ?? this.background,
        onBackground: onBackground ?? this.onBackground,
        surface: surface ?? this.surface,
        onSurface: onSurface ?? this.onSurface,
        outline: outline ?? this.outline,
        disabledColor: disabledColor ?? this.disabledColor,
      );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      backgroundWhite: l(backgroundWhite, other.backgroundWhite),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textBodyColor: l(textBodyColor, other.textBodyColor),
      textFadeColor: l(textFadeColor, other.textFadeColor),
      textLink: l(textLink, other.textLink),
      backgroundGray: l(backgroundGray, other.backgroundGray),
      border: l(border, other.border),
      ctaPrimary: l(ctaPrimary, other.ctaPrimary),
      iconPrimary: l(iconPrimary, other.iconPrimary),
      iconSecondary: l(iconSecondary, other.iconSecondary),
      backgroundInput: l(backgroundInput, other.backgroundInput),
      inputFocusShadow: l(inputFocusShadow, other.inputFocusShadow),
      optiTextPrimaryColor: l(optiTextPrimaryColor, other.optiTextPrimaryColor),
      defaultPrimaryColor: l(defaultPrimaryColor, other.defaultPrimaryColor),
      primaryColor: l(primaryColor, other.primaryColor),
      headerTextColor: l(headerTextColor, other.headerTextColor),
      cursorColor: l(cursorColor, other.cursorColor),
      denyTextColor: l(denyTextColor, other.denyTextColor),
      dividerColor: l(dividerColor, other.dividerColor),
      listBackgroundColor: l(listBackgroundColor, other.listBackgroundColor),
      inStockColor: l(inStockColor, other.inStockColor),
      lowStockColor: l(lowStockColor, other.lowStockColor),
      outOfStockColor: l(outOfStockColor, other.outOfStockColor),
      quantityPricingFirstBackgroundColor: l(
          quantityPricingFirstBackgroundColor,
          other.quantityPricingFirstBackgroundColor),
      quantityPricingSecondBackgroundColor: l(
          quantityPricingSecondBackgroundColor,
          other.quantityPricingSecondBackgroundColor),
      defaultBorderColor: l(defaultBorderColor, other.defaultBorderColor),
      listBorderColor: l(listBorderColor, other.listBorderColor),
      darkGrayTextColor: l(darkGrayTextColor, other.darkGrayTextColor),
      mediumGrayTextColor: l(mediumGrayTextColor, other.mediumGrayTextColor),
      lightGrayTextColor: l(lightGrayTextColor, other.lightGrayTextColor),
      unselectedTextColor: l(unselectedTextColor, other.unselectedTextColor),
      selectedTextColor: l(selectedTextColor, other.selectedTextColor),
      hintTextColor: l(hintTextColor, other.hintTextColor),
      invalidColor: l(invalidColor, other.invalidColor),
      successColor: l(successColor, other.successColor),
      successBackgroundColor:
          l(successBackgroundColor, other.successBackgroundColor),
      textFieldBackgroundColor:
          l(textFieldBackgroundColor, other.textFieldBackgroundColor),
      textFieldBorderColor: l(textFieldBorderColor, other.textFieldBorderColor),
      textFieldBorderShadowColor:
          l(textFieldBorderShadowColor, other.textFieldBorderShadowColor),
      buttonTextDisabledColor:
          l(buttonTextDisabledColor, other.buttonTextDisabledColor),
      buttonBackgroundDisabledColor:
          l(buttonBackgroundDisabledColor, other.buttonBackgroundDisabledColor),
      buttonBorderDisabledColor:
          l(buttonBorderDisabledColor, other.buttonBorderDisabledColor),
      buttonBorderColor: l(buttonBorderColor, other.buttonBorderColor),
      buttonAddColor: l(buttonAddColor, other.buttonAddColor),
      buttonDeleteColor: l(buttonDeleteColor, other.buttonDeleteColor),
      buttonLeaveColor: l(buttonLeaveColor, other.buttonLeaveColor),
      buttonRefreshColor: l(buttonRefreshColor, other.buttonRefreshColor),
      buttonEditColor: l(buttonEditColor, other.buttonEditColor),
      buttonDarkRedBackgroundColor:
          l(buttonDarkRedBackgroundColor, other.buttonDarkRedBackgroundColor),
      navIconUncheckedColor:
          l(navIconUncheckedColor, other.navIconUncheckedColor),
      gradientFirstColor: l(gradientFirstColor, other.gradientFirstColor),
      gradientSecondColor: l(gradientSecondColor, other.gradientSecondColor),
      messageBackgroundColor:
          l(messageBackgroundColor, other.messageBackgroundColor),
      spacerBackgroundColor:
          l(spacerBackgroundColor, other.spacerBackgroundColor),
      textDisabledColor: l(textDisabledColor, other.textDisabledColor),
      grayBackgroundColor: l(grayBackgroundColor, other.grayBackgroundColor),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryContainer: l(primaryContainer, other.primaryContainer),
      onPrimaryContainer: l(onPrimaryContainer, other.onPrimaryContainer),
      secondary: l(secondary, other.secondary),
      onSecondary: l(onSecondary, other.onSecondary),
      secondaryContainer: l(secondaryContainer, other.secondaryContainer),
      onSecondaryContainer: l(onSecondaryContainer, other.onSecondaryContainer),
      error: l(error, other.error),
      onError: l(onError, other.onError),
      background: l(background, other.background),
      onBackground: l(onBackground, other.onBackground),
      surface: l(surface, other.surface),
      onSurface: l(onSurface, other.onSurface),
      outline: l(outline, other.outline),
      disabledColor: l(disabledColor, other.disabledColor),
    );
  }
}
