import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SortOrderAttribute {
  final String groupTitle;
  final String title;
  final String value;
  final SortOrderOptions? sortOrderOption;

  SortOrderAttribute({
    required this.groupTitle,
    required this.title,
    required this.value,
    this.sortOrderOption,
  });
}
