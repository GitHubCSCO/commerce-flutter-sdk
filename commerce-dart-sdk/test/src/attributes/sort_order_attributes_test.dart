import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('SortOrderAttribute', () {
    test('Constructor should initialize fields correctly', () {
      // Create a SortOrderOptions object for testing
      final sortOrderOption = SortOrderOptions.doNotDisplay;

      // Create a SortOrderAttribute object
      final attribute = SortOrderAttribute(
        groupTitle: 'Group Title',
        title: 'Title',
        value: 'Value',
        sortOrderOption: sortOrderOption,
      );

      // Verify that fields are initialized correctly
      expect(attribute.groupTitle, 'Group Title');
      expect(attribute.title, 'Title');
      expect(attribute.value, 'Value');
      expect(attribute.sortOrderOption, sortOrderOption);
    });
  });
}
