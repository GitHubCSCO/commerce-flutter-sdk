import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String formatDate({required String format}) {
    if (this != null) {
      return DateFormat(format).format(this!);
    }
    return '';
  }
}
