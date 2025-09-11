import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum WishListLineSortOrder implements SortOrderAttribute {
  customSort(
    groupTitle: 'Custom Sort',
    title: 'Custom Sort \u2713',
    value: 'sortorder',
  ),

  dateAdded(
    groupTitle: 'Date Added',
    title: 'Date Added \u2713',
    value: 'createdon desc',
  ),

  productNameDescending(
    groupTitle: 'Product Name',
    title: 'Product Name \u2193',
    value: 'product.shortdescription desc',
  ),

  productNameAscending(
    groupTitle: 'Product Name',
    title: 'Product Name \u2191',
    value: 'product.shortdescription',
  ),
  ;

  const WishListLineSortOrder({
    required this.groupTitle,
    required this.title,
    required this.value,
  });

  @override
  final String groupTitle;
  @override
  final String title;
  @override
  final String value;

  final SortOrderOptions? sortOrderOptions = null;

  @override
  SortOrderOptions? get sortOrderOption => sortOrderOptions;
}
