import 'package:commerce_flutter_sdk/src/core/theme/extensions/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle header2;
  final TextStyle header3;

  final TextStyle titleLarge;
  final TextStyle titleLargeHighLight;
  final TextStyle titleSmall;

  final TextStyle subtitle;
  final TextStyle subtitleFade;
  final TextStyle subtitleHighlight;

  final TextStyle body;
  final TextStyle bodyFade;
  final TextStyle bodySmall;
  final TextStyle bodySmallHighlight;
  final TextStyle bodyExtraSmall;

  final TextStyle link;
  final TextStyle linkMedium;

  final TextStyle badgesStyle;
  final TextStyle errorTextStyles;
  final TextStyle errorText;

  const AppTextStyles({
    required this.header2,
    required this.header3,
    required this.titleLarge,
    required this.titleLargeHighLight,
    required this.titleSmall,
    required this.subtitle,
    required this.subtitleFade,
    required this.subtitleHighlight,
    required this.body,
    required this.bodyFade,
    required this.bodySmall,
    required this.bodySmallHighlight,
    required this.bodyExtraSmall,
    required this.link,
    required this.linkMedium,
    required this.badgesStyle,
    required this.errorTextStyles,
    required this.errorText,
  });

  factory AppTextStyles.from(ColorScheme scheme, AppColors colors) {
    TextStyle getInterFontStyle(TextStyle style) => GoogleFonts.inter(
          textStyle: style,
        );

    const headlineWeight = FontWeight.w400;
    const titleWeight = FontWeight.w600;
    const bodyWeight = FontWeight.w400;
    const bodyHighlightWeight = FontWeight.w600;
    const linkWeight = FontWeight.w500;

    return AppTextStyles(
      header2: getInterFontStyle(
        TextStyle(
          fontSize: 20,
          color: colors.textPrimary,
          fontWeight: headlineWeight,
        ),
      ),
      header3: getInterFontStyle(
        TextStyle(
          fontSize: 16,
          color: colors.textPrimary,
          fontWeight: headlineWeight,
        ),
      ),
      titleLarge: getInterFontStyle(
        TextStyle(
          fontSize: 18,
          color: colors.textPrimary,
          fontWeight: titleWeight,
        ),
      ),
      titleLargeHighLight: getInterFontStyle(
        TextStyle(
          fontSize: 18,
          color: scheme.primary,
          fontWeight: titleWeight,
        ),
      ),
      titleSmall: getInterFontStyle(
        TextStyle(
          fontSize: 16,
          color: colors.textPrimary,
          fontWeight: titleWeight,
        ),
      ),
      subtitle: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: colors.textPrimary,
          fontWeight: titleWeight,
        ),
      ),
      subtitleFade: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: colors.textFadeColor,
          fontWeight: titleWeight,
        ),
      ),
      subtitleHighlight: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: scheme.primary,
          fontWeight: titleWeight,
        ),
      ),
      body: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: colors.textBodyColor,
          fontWeight: bodyWeight,
        ),
      ),
      bodyFade: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: colors.textFadeColor,
          fontWeight: bodyWeight,
        ),
      ),
      bodySmall: getInterFontStyle(
        TextStyle(
          fontSize: 12,
          color: colors.textBodyColor,
          fontWeight: bodyWeight,
        ),
      ),
      bodySmallHighlight: getInterFontStyle(
        TextStyle(
          fontSize: 12,
          color: colors.textBodyColor,
          fontWeight: bodyHighlightWeight,
        ),
      ),
      bodyExtraSmall: getInterFontStyle(
        TextStyle(
          fontSize: 11,
          color: colors.textBodyColor,
          fontWeight: bodyWeight,
        ),
      ),
      link: getInterFontStyle(
        TextStyle(
          fontSize: 12,
          color: scheme.primary,
          fontWeight: linkWeight,
        ),
      ),
      linkMedium: getInterFontStyle(
        TextStyle(
          fontSize: 15,
          color: scheme.primary,
          fontWeight: linkWeight,
        ),
      ),
      badgesStyle: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: scheme.onPrimary,
          fontWeight: titleWeight,
        ),
      ),
      errorTextStyles: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: scheme.onError,
          fontWeight: titleWeight,
        ),
      ),
      errorText: getInterFontStyle(
        TextStyle(
          fontSize: 14,
          color: colors.error,
          fontWeight: bodyWeight,
        ),
      ),
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? header2,
    TextStyle? header3,
    TextStyle? titleLarge,
    TextStyle? titleLargeHighLight,
    TextStyle? titleSmall,
    TextStyle? subtitle,
    TextStyle? subtitleFade,
    TextStyle? subtitleHighlight,
    TextStyle? body,
    TextStyle? bodyFade,
    TextStyle? bodySmall,
    TextStyle? bodySmallHighlight,
    TextStyle? bodyExtraSmall,
    TextStyle? link,
    TextStyle? linkMedium,
    TextStyle? badgesStyle,
    TextStyle? errorTextStyles,
    TextStyle? errorText,
  }) =>
      AppTextStyles(
        header2: header2 ?? this.header2,
        header3: header3 ?? this.header3,
        titleLarge: titleLarge ?? this.titleLarge,
        titleLargeHighLight: titleLargeHighLight ?? this.titleLargeHighLight,
        titleSmall: titleSmall ?? this.titleSmall,
        subtitle: subtitle ?? this.subtitle,
        subtitleFade: subtitleFade ?? this.subtitleFade,
        subtitleHighlight: subtitleHighlight ?? this.subtitleHighlight,
        body: body ?? this.body,
        bodyFade: bodyFade ?? this.bodyFade,
        bodySmall: bodySmall ?? this.bodySmall,
        bodySmallHighlight: bodySmallHighlight ?? this.bodySmallHighlight,
        bodyExtraSmall: bodyExtraSmall ?? this.bodyExtraSmall,
        link: link ?? this.link,
        linkMedium: linkMedium ?? this.linkMedium,
        badgesStyle: badgesStyle ?? this.badgesStyle,
        errorTextStyles: errorTextStyles ?? this.errorTextStyles,
        errorText: errorText ?? this.errorText,
      );

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    TextStyle l(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return AppTextStyles(
      header2: l(header2, other.header2),
      header3: l(header3, other.header3),
      titleLarge: l(titleLarge, other.titleLarge),
      titleLargeHighLight: l(titleLargeHighLight, other.titleLargeHighLight),
      titleSmall: l(titleSmall, other.titleSmall),
      subtitle: l(subtitle, other.subtitle),
      subtitleFade: l(subtitleFade, other.subtitleFade),
      subtitleHighlight: l(subtitleHighlight, other.subtitleHighlight),
      body: l(body, other.body),
      bodyFade: l(bodyFade, other.bodyFade),
      bodySmall: l(bodySmall, other.bodySmall),
      bodySmallHighlight: l(bodySmallHighlight, other.bodySmallHighlight),
      bodyExtraSmall: l(bodyExtraSmall, other.bodyExtraSmall),
      link: l(link, other.link),
      linkMedium: l(linkMedium, other.linkMedium),
      badgesStyle: l(badgesStyle, other.badgesStyle),
      errorTextStyles: l(errorTextStyles, other.errorTextStyles),
      errorText: l(errorText, other.errorText),
    );
  }
}
