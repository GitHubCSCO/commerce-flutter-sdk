import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:intl/intl.dart';

const _formatMap = {
  LanguageCode.enUs: CoreConstants.enUsDateFormatString,
  LanguageCode.enCa: CoreConstants.enCaDateFormatString,
  LanguageCode.frCa: CoreConstants.frCaDateFormatString,
  LanguageCode.deDe: CoreConstants.deDeDateFormatString,
};

String formatDateByLocale(DateTime? date, {bool isDateAndTime = false}) {
  final languageService = sl<ILocalizationService>();
  final locale = languageService.getCurrentLanguage();
  final languageCodeStr =
      locale?.languageCode?.toLowerCase() ?? LanguageCode.enUs.code;

  final languageCode = LanguageCode.values.firstWhere(
    (e) => e.code == languageCodeStr,
    orElse: () => LanguageCode.enUs,
  );

  var format = _formatMap[languageCode] ?? CoreConstants.enUsDateFormatString;

  if (isDateAndTime) {
    format = CoreConstants.localizedDateFormatFullString.format([format]);
  }

  return date != null ? DateFormat(format).format(date) : '';
}

enum LanguageCode {
  enUs('en-us'),
  enCa('en-ca'),
  frCa('fr-ca'),
  deDe('de-de');

  final String code;

  const LanguageCode(this.code);

  @override
  String toString() => code;
}
