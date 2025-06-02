import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('WishListLineSortOrder', () {
    test('customSort', () {
      expect(WishListLineSortOrder.customSort.groupTitle, 'Custom Sort');
      expect(WishListLineSortOrder.customSort.title, 'Custom Sort ✓');
      expect(WishListLineSortOrder.customSort.value, 'sortorder');
      expect(WishListLineSortOrder.customSort.sortOrderOptions, isNull);
    });

    test('dateAdded', () {
      expect(WishListLineSortOrder.dateAdded.groupTitle, 'Date Added');
      expect(WishListLineSortOrder.dateAdded.title, 'Date Added ✓');
      expect(WishListLineSortOrder.dateAdded.value, 'createdon desc');
      expect(WishListLineSortOrder.dateAdded.sortOrderOptions, isNull);
    });

    test('productNameDescending', () {
      expect(WishListLineSortOrder.productNameDescending.groupTitle,
          'Product Name');
      expect(
          WishListLineSortOrder.productNameDescending.title, 'Product Name ↓');
      expect(WishListLineSortOrder.productNameDescending.value,
          'product.shortdescription desc');
      expect(
          WishListLineSortOrder.productNameDescending.sortOrderOptions, isNull);
    });

    test('productNameAscending', () {
      expect(WishListLineSortOrder.productNameAscending.groupTitle,
          'Product Name');
      expect(
          WishListLineSortOrder.productNameAscending.title, 'Product Name ↑');
      expect(WishListLineSortOrder.productNameAscending.value,
          'product.shortdescription');
      expect(
          WishListLineSortOrder.productNameAscending.sortOrderOptions, isNull);
    });

    test('sortOrderOption', () {
      expect(WishListLineSortOrder.customSort.sortOrderOption, isNull);
      expect(WishListLineSortOrder.dateAdded.sortOrderOption, isNull);
      expect(
          WishListLineSortOrder.productNameDescending.sortOrderOption, isNull);
      expect(
          WishListLineSortOrder.productNameAscending.sortOrderOption, isNull);
    });
  });
}
