import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = _getTheme();

const _primary = Colors.indigo;
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
  final textTheme = _getTextTheme(colorScheme);
  final primaryTextTheme = textTheme;

  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );
  const buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );
  final buttonTextStyle = textTheme.titleMedium;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    textTheme: textTheme,
    // primaryTextTheme: primaryTextTheme,
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

TextTheme _getTextTheme(ColorScheme colorScheme) {
  const headlineColor = _darker;
  const headlineWeight = FontWeight.w400;
  const headlineLargeHeight = 1.2;
  const headlineMediumHeight = 1.1;
  const headlineSmallHeight = 1.1;
  const headlineLetterSpacing = 0.0;

  const titleColor = _darker;
  const titleWeight = FontWeight.w600;
  const titleLargeHeight = 1.56;
  const titleMediumHeight = 1.5;
  const titleSmallHeight = 1.43;
  const titleLetterSpacing = 0.0;

  const bodyColor = _darkest;
  const bodyWeight = FontWeight.w400;
  const bodyLargeHeight = 1.43;
  const bodyMediumHeight = 1.25;
  const bodySmallHeight = 1.45;
  const bodyLetterSpacing = 0.0;

  const labelColor = titleColor;

  const textTheme = TextTheme(
    // Headline
    headlineLarge: TextStyle(
      fontSize: 20,
      height: headlineLargeHeight,
      letterSpacing: headlineLetterSpacing,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      height: headlineMediumHeight,
      letterSpacing: headlineLetterSpacing,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      height: headlineSmallHeight,
      letterSpacing: headlineLetterSpacing,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),

    // Title
    titleLarge: TextStyle(
      fontSize: 18,
      height: titleLargeHeight,
      letterSpacing: titleLetterSpacing,
      color: titleColor,
      fontWeight: titleWeight,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: titleMediumHeight,
      letterSpacing: titleLetterSpacing,
      color: titleColor,
      fontWeight: titleWeight,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: titleSmallHeight,
      letterSpacing: titleLetterSpacing,
      color: titleColor,
      fontWeight: titleWeight,
    ),

    // Body
    bodyLarge: TextStyle(
      fontSize: 14,
      height: bodyLargeHeight,
      letterSpacing: bodyLetterSpacing,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      height: bodyMediumHeight,
      letterSpacing: bodyLetterSpacing,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: bodySmallHeight,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),

    // Label
    // labelLarge: TextStyle(
    //   fontSize: 16,
    //   height: bodyHeight,
    //   letterSpacing: bodyLetterSpacing,
    //   color: labelColor,
    //   fontWeight: bodyWeight,
    // ),
    // labelMedium: TextStyle(
    //   fontSize: 14,
    //   height: bodyHeight,
    //   letterSpacing: bodyLetterSpacing,
    //   color: labelColor,
    //   fontWeight: bodyWeight,
    // ),
    // labelSmall: TextStyle(
    //   fontSize: 12,
    //   height: bodyHeight,
    //   letterSpacing: bodyLetterSpacing,
    //   color: labelColor,
    //   fontWeight: bodyWeight,
    // ),
  );

  return GoogleFonts.interTextTheme(textTheme);
}

