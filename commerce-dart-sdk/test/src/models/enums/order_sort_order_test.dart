import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('OrderSortOrder', () {
    test('orderDateDescending', () {
      expect(OrderSortOrder.orderDateDescending.groupTitle, 'Order Date');
      expect(OrderSortOrder.orderDateDescending.title, 'Order Date ↓');
      expect(OrderSortOrder.orderDateDescending.value, 'OrderDate DESC');
      expect(OrderSortOrder.orderDateDescending.sortOrderOptions, isNull);
    });

    test('orderDateAscending', () {
      expect(OrderSortOrder.orderDateAscending.groupTitle, 'Order Date');
      expect(OrderSortOrder.orderDateAscending.title, 'Order Date ↑');
      expect(OrderSortOrder.orderDateAscending.value, 'OrderDate ASC');
      expect(OrderSortOrder.orderDateAscending.sortOrderOptions, isNull);
    });

    test('orderNumberDescending', () {
      expect(OrderSortOrder.orderNumberDescending.groupTitle, 'Order Number');
      expect(OrderSortOrder.orderNumberDescending.title, 'Order Number ↓');
      expect(OrderSortOrder.orderNumberDescending.value, 'WebOrderNumber DESC');
      expect(OrderSortOrder.orderNumberDescending.sortOrderOptions, isNull);
    });

    test('orderNumberAscending', () {
      expect(OrderSortOrder.orderNumberAscending.groupTitle, 'Order Number');
      expect(OrderSortOrder.orderNumberAscending.title, 'Order Number ↑');
      expect(OrderSortOrder.orderNumberAscending.value, 'WebOrderNumber ASC');
      expect(OrderSortOrder.orderNumberAscending.sortOrderOptions, isNull);
    });

    test('shippingAddressDescending', () {
      expect(OrderSortOrder.shippingAddressDescending.groupTitle,
          'Shipping Address');
      expect(
          OrderSortOrder.shippingAddressDescending.title, 'Shipping Address ↓');
      expect(OrderSortOrder.shippingAddressDescending.value,
          'CustomerSequence DESC');
      expect(OrderSortOrder.shippingAddressDescending.sortOrderOptions, isNull);
    });

    test('shippingAddressAscending', () {
      expect(OrderSortOrder.shippingAddressAscending.groupTitle,
          'Shipping Address');
      expect(
          OrderSortOrder.shippingAddressAscending.title, 'Shipping Address ↑');
      expect(OrderSortOrder.shippingAddressAscending.value,
          'CustomerSequence ASC');
      expect(OrderSortOrder.shippingAddressAscending.sortOrderOptions, isNull);
    });

    test('statusDescending', () {
      expect(OrderSortOrder.statusDescending.groupTitle, 'Status');
      expect(OrderSortOrder.statusDescending.title, 'Status ↓');
      expect(OrderSortOrder.statusDescending.value, 'Status DESC');
      expect(OrderSortOrder.statusDescending.sortOrderOptions, isNull);
    });

    test('statusAscending', () {
      expect(OrderSortOrder.statusAscending.groupTitle, 'Status');
      expect(OrderSortOrder.statusAscending.title, 'Status ↑');
      expect(OrderSortOrder.statusAscending.value, 'Status ASC');
      expect(OrderSortOrder.statusAscending.sortOrderOptions, isNull);
    });

    test('poNumberDescending', () {
      expect(OrderSortOrder.poNumberDescending.groupTitle, 'PO Number');
      expect(OrderSortOrder.poNumberDescending.title, 'PO Number ↓');
      expect(OrderSortOrder.poNumberDescending.value, 'CustomerPO DESC');
      expect(OrderSortOrder.poNumberDescending.sortOrderOptions, isNull);
    });

    test('poNumberAscending', () {
      expect(OrderSortOrder.poNumberAscending.groupTitle, 'PO Number');
      expect(OrderSortOrder.poNumberAscending.title, 'PO Number ↑');
      expect(OrderSortOrder.poNumberAscending.value, 'CustomerPO ASC');
      expect(OrderSortOrder.poNumberAscending.sortOrderOptions, isNull);
    });

    test('orderTotalDescending', () {
      expect(OrderSortOrder.orderTotalDescending.groupTitle, 'Total');
      expect(OrderSortOrder.orderTotalDescending.title, 'Total ↓');
      expect(OrderSortOrder.orderTotalDescending.value, 'OrderTotal DESC');
      expect(OrderSortOrder.orderTotalDescending.sortOrderOptions, isNull);
    });

    test('orderTotalAscending', () {
      expect(OrderSortOrder.orderTotalAscending.groupTitle, 'Total');
      expect(OrderSortOrder.orderTotalAscending.title, 'Total ↑');
      expect(OrderSortOrder.orderTotalAscending.value, 'OrderTotal ASC');
      expect(OrderSortOrder.orderTotalAscending.sortOrderOptions, isNull);
    });

    test('orderErpNumberDescending', () {
      expect(OrderSortOrder.orderErpNumberDescending.groupTitle,
          'Order ERP Number');
      expect(
          OrderSortOrder.orderErpNumberDescending.title, 'Order ERP Number ↓');
      expect(
          OrderSortOrder.orderErpNumberDescending.value, 'ERPOrderNumber DESC');
      expect(OrderSortOrder.orderErpNumberDescending.sortOrderOptions,
          SortOrderOptions.doNotDisplay);
    });

    test('orderErpNumberAscending', () {
      expect(OrderSortOrder.orderErpNumberAscending.groupTitle,
          'Order ERP Number');
      expect(
          OrderSortOrder.orderErpNumberAscending.title, 'Order ERP Number ↑');
      expect(
          OrderSortOrder.orderErpNumberAscending.value, 'ERPOrderNumber ASC');
      expect(OrderSortOrder.orderErpNumberAscending.sortOrderOptions,
          SortOrderOptions.doNotDisplay);
    });

    test('sortOrderOption', () {
      expect(OrderSortOrder.orderErpNumberDescending.sortOrderOption,
          SortOrderOptions.doNotDisplay);
      expect(OrderSortOrder.orderErpNumberAscending.sortOrderOption,
          SortOrderOptions.doNotDisplay);
    });
  });
}
