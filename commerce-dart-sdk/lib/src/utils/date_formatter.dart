import 'package:intl/intl.dart';

class DateFormatter {
  static String toYyyyMmDd(DateTime? date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return date != null ? formatter.format(date) : '';
  }
}
