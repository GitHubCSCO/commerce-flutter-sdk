import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('SortOrderOptions Tests', () {
    test('Verify SortOrderOptions enum values', () {
      // Check the values of the SortOrderOptions enum
      expect(SortOrderOptions.values.length, 1);
      expect(SortOrderOptions.doNotDisplay.toString(),
          'SortOrderOptions.doNotDisplay');
    });
  });
}
