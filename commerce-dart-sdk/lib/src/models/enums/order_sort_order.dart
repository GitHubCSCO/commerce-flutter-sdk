import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum OrderSortOrder implements SortOrderAttribute {
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

  orderNumberDescending(
    groupTitle: 'Order Number',
    title: 'Order Number \u2193',
    value: 'WebOrderNumber DESC',
  ),

  orderNumberAscending(
    groupTitle: 'Order Number',
    title: 'Order Number \u2191',
    value: 'WebOrderNumber ASC',
  ),

  shippingAddressDescending(
    groupTitle: 'Shipping Address',
    title: 'Shipping Address \u2193',
    value: 'CustomerSequence DESC',
  ),

  shippingAddressAscending(
    groupTitle: 'Shipping Address',
    title: 'Shipping Address \u2191',
    value: 'CustomerSequence ASC',
  ),

  statusDescending(
    groupTitle: 'Status',
    title: 'Status \u2193',
    value: 'Status DESC',
  ),

  statusAscending(
    groupTitle: 'Status',
    title: 'Status \u2191',
    value: 'Status ASC',
  ),

  poNumberDescending(
    groupTitle: 'PO Number',
    title: 'PO Number \u2193',
    value: 'CustomerPO DESC',
  ),

  poNumberAscending(
    groupTitle: 'PO Number',
    title: 'PO Number \u2191',
    value: 'CustomerPO ASC',
  ),

  orderTotalDescending(
    groupTitle: 'Total',
    title: 'Total \u2193',
    value: 'OrderTotal DESC',
  ),

  orderTotalAscending(
    groupTitle: 'Total',
    title: 'Total \u2191',
    value: 'OrderTotal ASC',
  ),

  orderErpNumberDescending(
    groupTitle: 'Order ERP Number',
    title: 'Order ERP Number \u2193',
    value: 'ERPOrderNumber DESC',
    sortOrderOptions: SortOrderOptions.doNotDisplay,
  ),

  orderErpNumberAscending(
    groupTitle: 'Order ERP Number',
    title: 'Order ERP Number \u2191',
    value: 'ERPOrderNumber ASC',
    sortOrderOptions: SortOrderOptions.doNotDisplay,
  ),
  ;

  const OrderSortOrder({
    required this.groupTitle,
    required this.title,
    required this.value,
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
