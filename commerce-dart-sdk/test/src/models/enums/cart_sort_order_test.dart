import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CartSortOrder Tests', () {
    test('Check groupTitle, title, and value for each sort order', () {
      // Define the expected results for each sort order
      final expectedResults = {
        CartSortOrder.orderDateDescending: {
          'groupTitle': 'Order Date',
          'title': 'Order Date ↓',
          'value': 'OrderDate DESC',
        },
        CartSortOrder.orderDateAscending: {
          'groupTitle': 'Order Date',
          'title': 'Order Date ↑',
          'value': 'OrderDate ASC',
        },
        CartSortOrder.orderSubTotalDescending: {
          'groupTitle': 'Order SubTotal',
          'title': 'Order SubTotal ↓',
          'value': 'OrderSubTotal DESC',
        },
        CartSortOrder.orderSubTotalAscending: {
          'groupTitle': 'Order SubTotal',
          'title': 'Order SubTotal ↑',
          'value': 'OrderSubTotal ASC',
        },
      };

      for (var sortOrder in CartSortOrder.values) {
        // Validate each property
        expect(sortOrder.groupTitle, expectedResults[sortOrder]!['groupTitle']);
        expect(sortOrder.title, expectedResults[sortOrder]!['title']);
        expect(sortOrder.value, expectedResults[sortOrder]!['value']);
      }
    });

    test('sortOrderOptions should be null by default', () {
      for (var sortOrder in CartSortOrder.values) {
        expect(sortOrder.sortOrderOption, isNull);
      }
    });
  });
}
