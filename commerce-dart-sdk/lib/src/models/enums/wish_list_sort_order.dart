import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum WishListSortOrder implements SortOrderAttribute {
  modifiedOnDescending(
    groupTitle: "Date Updated",
    title: "Date Updated \u2713",
    value: "ModifiedOn DESC",
  ),

  nameDescending(
    groupTitle: "List Name",
    title: "List Name \u2193",
    value: "Name DESC",
  ),

  nameAscending(
    groupTitle: "List Name",
    title: "List Name \u2191",
    value: "Name ASC",
  ),
  ;

  const WishListSortOrder({
    required this.groupTitle,
    required this.title,
    required this.value,
    // ignore: unused_element
    this.sortOrderOptions,
  });

  @override
  final String groupTitle;
  @override
  final String title;
  @override
  final String value;
  final SortOrderOptions? sortOrderOptions;

  @override
  SortOrderOptions? get sortOrderOption => sortOrderOptions;
}
