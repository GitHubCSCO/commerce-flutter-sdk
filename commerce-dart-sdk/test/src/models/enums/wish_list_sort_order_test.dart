import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('WishListSortOrder Tests', () {
    test('Check groupTitle, title, and value for each sort order', () {
      // Define the expected results for each sort order
      final expectedResults = {
        WishListSortOrder.modifiedOnDescending: {
          'groupTitle': 'Date Updated',
          'title': 'Date Updated ✓',
          'value': 'ModifiedOn DESC',
        },
        WishListSortOrder.nameDescending: {
          'groupTitle': 'List Name',
          'title': 'List Name ↓',
          'value': 'Name DESC',
        },
        WishListSortOrder.nameAscending: {
          'groupTitle': 'List Name',
          'title': 'List Name ↑',
          'value': 'Name ASC',
        },
      };

      for (var sortOrder in WishListSortOrder.values) {
        // Validate each property
        expect(sortOrder.groupTitle, expectedResults[sortOrder]!['groupTitle']);
        expect(sortOrder.title, expectedResults[sortOrder]!['title']);
        expect(sortOrder.value, expectedResults[sortOrder]!['value']);
      }
    });

    test('sortOrderOptions should be null by default', () {
      for (var sortOrder in WishListSortOrder.values) {
        expect(sortOrder.sortOrderOption, isNull);
      }
    });
  });
}
