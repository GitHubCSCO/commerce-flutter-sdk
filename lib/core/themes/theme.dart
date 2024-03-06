import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = _getTheme();

const _primary = Color.fromRGBO(0, 55, 255, 1);
const _secondary = Colors.amber;

const _background = Color(0xFFF5F5F5);
const _lightest = Colors.white;
const _darkest = Colors.black;
const _darker = Color(0xFF222222);
const _divider = Color(0xFFD6D6D6);
const _disabled = Colors.grey;

const _red = Colors.red;

final _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // Primary
  primary: _primary,
  onPrimary: _lightest,
  primaryContainer: _primary.withOpacity(0.2),
  onPrimaryContainer: _lightest,
  // Secondary
  secondary: _secondary,
  onSecondary: _darkest,
  secondaryContainer: _secondary.withOpacity(0.2),
  onSecondaryContainer: _darkest,
  // Error
  error: _red,
  onError: _lightest,
  // Background
  background: _background,
  onBackground: _darkest,
  // Surface
  surface: _lightest,
  onSurface: _darkest,
  // Outline
  outline: _divider,
);

ThemeData _getTheme() {
  final colorScheme = _lightColorScheme;

  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  const buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  final buttonTextStyle = OptiTextStyles.titleSmall;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    disabledColor: _disabled,
    dividerTheme: const DividerThemeData(
      color: _divider,
      space: 1,
      thickness: 1,
    ),
    // chipTheme: ChipThemeData(
    //   labelStyle: textTheme.labelSmall,
    //   side: const BorderSide(
    //     width: 0,
    //   ),
    // ),
    // cardTheme: const CardTheme(
    //   clipBehavior: Clip.antiAlias,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(6)),
    //     side: BorderSide(
    //       width: 1,
    //       color: _divider,
    //     ),
    //   ),
    //   color: _background,
    //   surfaceTintColor: Colors.transparent,
    //   margin: EdgeInsets.zero,
    // ),
    // popupMenuTheme: PopupMenuThemeData(
    //   color: _background,
    //   surfaceTintColor: colorScheme.background,
    // ),
    // bottomSheetTheme: const BottomSheetThemeData(
    //   showDragHandle: false,
    //   backgroundColor: _background,
    //   surfaceTintColor: Colors.transparent,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(20),
    //     ),
    //   ),
    // ),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   type: BottomNavigationBarType.fixed,
    //   showSelectedLabels: true,
    //   showUnselectedLabels: true,
    // ),
    // navigationRailTheme: const NavigationRailThemeData(
    //   labelType: NavigationRailLabelType.all,
    //   groupAlignment: 0,
    // ),
    // appBarTheme: AppBarTheme(
    //   titleTextStyle: textTheme.titleLarge,
    //   backgroundColor: _background,
    // ),
    // dialogTheme: DialogTheme(
    //   backgroundColor: colorScheme.background,
    //   surfaceTintColor: colorScheme.background,
    //   titleTextStyle: textTheme.titleLarge,
    // ),
    // snackBarTheme: SnackBarThemeData(
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: _darkest,
    //   contentTextStyle: primaryTextTheme.bodyLarge,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(8)),
    //   ),
    // ),
    // listTileTheme: ListTileThemeData(
    //   iconColor: colorScheme.primary,
    // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   floatingLabelBehavior: FloatingLabelBehavior.auto,
    //   contentPadding: const EdgeInsets.symmetric(
    //     horizontal: 24,
    //     vertical: 16,
    //   ),
    //   border: const OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(8)),
    //     borderSide: BorderSide.none,
    //   ),
    //   hintStyle: textTheme.bodyLarge,
    //   labelStyle: textTheme.bodyLarge!.copyWith(
    //     color: Colors.black38,
    //     fontWeight: FontWeight.normal,
    //   ),
    // ),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: colorScheme.secondary,
    //   foregroundColor: Colors.white,
    //   iconSize: 24,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(60),
    //   ),
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: buttonShape,
    //     padding: buttonPadding,
    //     backgroundColor: colorScheme.primary,
    //     foregroundColor: colorScheme.onPrimary,
    //     textStyle: buttonTextStyle,
    //     elevation: 2,
    //   ),
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     shape: buttonShape,
    //     padding: buttonPadding,
    //     side: BorderSide(
    //       color: colorScheme.primary,
    //       width: 1,
    //     ),
    //     foregroundColor: colorScheme.primary,
    //     textStyle: buttonTextStyle,
    //     elevation: 0,
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     shape: buttonShape,
    //     padding: buttonPadding,
    //     foregroundColor: colorScheme.primary,
    //     textStyle: buttonTextStyle,
    //   ),
    // ),
  );
}

class OptiTextStyles {
  static const headlineColor = _darker;
  static const headlineWeight = FontWeight.w400;

  static const titleColor = _darker;
  static const titleWeight = FontWeight.w600;

  static const bodyColor = _darkest;
  static const bodyWeight = FontWeight.w400;
  static const bodyHighlightWeight = FontWeight.w600;

  static const linkColor = _primary;
  static const linkWeight = FontWeight.w500;

  static const labelColor = titleColor;

  static TextStyle _getInterFontStyle(TextStyle style) {
    return GoogleFonts.inter(
      textStyle: style,
    );
  }

  // Headline
  static TextStyle get header2 => _getInterFontStyle(
        const TextStyle(
          fontSize: 20,
          color: headlineColor,
          fontWeight: headlineWeight,
        ),
      );

  static TextStyle get header3 => _getInterFontStyle(
        const TextStyle(
          fontSize: 18,
          color: headlineColor,
          fontWeight: headlineWeight,
        ),
      );

  // Title
  static TextStyle get titleLarge => _getInterFontStyle(
        const TextStyle(
          fontSize: 18,
          color: titleColor,
          fontWeight: titleWeight,
        ),
      );

  static TextStyle get titleSmall => _getInterFontStyle(
        const TextStyle(
          fontSize: 16,
          color: titleColor,
          fontWeight: titleWeight,
        ),
      );

  static TextStyle get subtitle => _getInterFontStyle(
        const TextStyle(
          fontSize: 14,
          color: titleColor,
          fontWeight: titleWeight,
        ),
      );

  // Body
  static TextStyle get body => _getInterFontStyle(
        const TextStyle(
          fontSize: 14,
          color: bodyColor,
          fontWeight: bodyWeight,
        ),
      );

  static TextStyle get bodySmall => _getInterFontStyle(
        const TextStyle(
          fontSize: 12,
          color: bodyColor,
          fontWeight: bodyWeight,
        ),
      );

  static TextStyle get bodySmallHighlight => _getInterFontStyle(
        const TextStyle(
          fontSize: 12,
          color: bodyColor,
          fontWeight: bodyHighlightWeight,
        ),
      );

  static TextStyle get link => _getInterFontStyle(
        const TextStyle(
          fontSize: 12,
          color: _primary,
          fontWeight: linkWeight,
        ),
      );
}
