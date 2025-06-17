import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:intl/intl.dart';

String formatDateByLocale(DateTime date) {
  var languageService = sl<ILocalizationService>();
  var locale = languageService.getCurrentLanguage();
  var languageCodeStr =
      locale?.languageCode?.toLowerCase() ?? LanguageCode.enUs.code;

  // Find the matching LanguageCode enum
  var languageCode = LanguageCode.values.firstWhere(
    (e) => e.code == languageCodeStr,
    orElse: () => LanguageCode.enUs,
  );

  String format;

  switch (languageCode) {
    case LanguageCode.enUs:
      format = 'MM/dd/yyyy'; // US format
      break;
    case LanguageCode.enCa:
      format = 'yyyy-MM-dd'; // Canadian format
      break;
    case LanguageCode.frCa:
      format = 'dd/MM/yyyy'; // French Canadian format
      break;
    case LanguageCode.deDe:
      format = 'dd.MM.yyyy'; // German format
      break;
    default:
      format = 'MM/dd/yyyy'; // Default to US format
  }

  return DateFormat(format).format(date);
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
