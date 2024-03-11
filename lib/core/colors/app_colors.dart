import 'dart:ui';

class OptiAppColors {
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF707070);
  static const Color textLink = Color(0xFF0037FF);
  static const Color backgroundGray = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFD6D6D6);
  static const Color ctaPrimary = Color(0xFF0037FF);
  static const Color iconPrimary = Color(0xFF222222);
  static const Color iconSecondary = Color(0xFF9E9E9E);
  static const Color backgroundInput = Color(0xFFEDEDED);
  static const Color inputFocusShadow = Color(0xFFB3C3FF);

  static const optiTextPrimaryColor = Color(0xFF080736);
  static const defaultPrimaryColor = Color(0xFF0037FF);
  static const primaryColor = defaultPrimaryColor;
  static const headerTextColor = Color(0xFFFFFFFF);
  static const cursorColor = Color(0xFF7F7F7F);
  static const denyTextColor = Color(0xFFF76368);

  static const dividerColor = Color(0xFFC7C7C7);
  static const listBackgroundColor = Color(0xFFF4F4F4);

  static const inStockColor = Color(0xFF333333);
  static const lowStockColor = Color(0xFFD0BF00);
  static const outOfStockColor = Color(0xFFFF3B3D);

  static const quantityPricingFirstBackgroundColor = Color(0xFFF9F9F9);
  static const quantityPricingSecondBackgroundColor = Color(0xFFFFFFFF);

  static const defaultBorderColor = Color(0xFF666666);
  static const listBorderColor = Color(0xFFE4E4E4);

  static const darkGrayTextColor = Color(0xFF333333);
  static const mediumGrayTextColor = Color(0xFF666666);
  static const lightGrayTextColor = Color(0xFF999999);

  static const unselectedTextColor = Color(0xFF666666);
  static const selectedTextColor = Color(0xFF999999);

  static const hintTextColor = Color(0xFF999999);

  static const invalidColor = Color(0xFFFF3B30);
  static const successColor = Color(0xFF77BC1F);

  static const textFieldBackgroundColor = Color(0xFFFFFFFF);
  static const textFieldBorderColor = Color(0xFF9E9E9E);
  static const textFieldBorderShadowColor = Color(0xFF0037FF);

  static const buttonTextDisabledColor = Color(0xFF999999);
  static const buttonBackgroundDisabledColor = Color(0xFFF6F6F6);
  static const buttonBorderDisabledColor = Color(0xFFD8D8D8);
  static const buttonBorderColor = Color(0xFF999999);
  static const buttonAddColor = Color(0xFF1DB954);
  static const buttonDeleteColor = Color(0xFFFF3B30);
  static const buttonLeaveColor = Color(0xFFD0BF00);
  static const buttonRefreshColor = Color(0xFFCFCFCF);
  static const buttonEditColor = Color(0xFF039F38);
  static const buttonDarkRedBackgroudColor = Color(0xFFAD3029);

  static const navIconUncheckedColor = Color(0xFF999999);

  static const gradientFirstColor = Color(0xFFFFFFFF);
  static const gradientSecondColor = Color(0xFFEAEAEA);

  static const messageBackgroundColor = Color(0xFFE6E5EB);

  static const spacerBackgroundColor = Color(0xFFF5F5F5);

  static const textDisabledColor = Color(0xFF707070);

  static const grayBackgroundColor = Color(0xFFF5F5F5);

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}
