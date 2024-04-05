import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DisplayOption {
  Future<void> Function() action;

  String title;

  SortOrderAttribute? sortOrder;

  SortOrderAttribute? oppositeSortOrder;

  DisplayOption({
    required this.action,
    required this.title,
    this.sortOrder,
    this.oppositeSortOrder,
  });
}
