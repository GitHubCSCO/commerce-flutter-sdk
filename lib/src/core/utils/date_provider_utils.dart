import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:intl/intl.dart';

String formatDateByLocale(DateTime? date, {bool isDateAndTime = false}) {
  final languageService = sl<ILocalizationService>();
  final locale = languageService.getCurrentLanguage();
  final languageCodeStr = locale?.languageCode ?? 'en_US';

  DateFormat dateFormat;
  try {
    dateFormat = DateFormat.yMd(languageCodeStr);
  } catch (e) {
    dateFormat = DateFormat.yMd('en_US');
  }

  if (isDateAndTime) {
    dateFormat = dateFormat.add_Hms();
  }

  return date != null ? dateFormat.format(date) : '';
}
