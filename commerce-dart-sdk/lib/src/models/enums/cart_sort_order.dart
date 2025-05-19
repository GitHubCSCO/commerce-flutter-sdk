import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum CartSortOrder implements SortOrderAttribute {
  orderDateDescending(
    groupTitle: 'Order Date',
    title: 'Order Date \u2193',
    value: 'OrderDate DESC',
  ),

  orderDateAscending(
    groupTitle: 'Order Date',
    title: 'Order Date \u2191',
    value: 'OrderDate ASC',
  ),

  orderSubTotalDescending(
    groupTitle: 'Order SubTotal',
    title: 'Order SubTotal \u2193',
    value: 'OrderSubTotal DESC',
  ),

  orderSubTotalAscending(
    groupTitle: 'Order SubTotal',
    title: 'Order SubTotal \u2191',
    value: 'OrderSubTotal ASC',
  ),
  ;

  const CartSortOrder({
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
