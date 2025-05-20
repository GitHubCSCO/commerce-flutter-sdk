import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('JsonEncodingMethods', () {
    test('convertAttributesToString', () {
      final inputMap = {
        'key1': 123,
        'key2': true,
        'key3': 'string',
      };
      final expectedMap = {
        'key1': '123',
        'key2': 'true',
        'key3': 'string',
      };

      final result = JsonEncodingMethods.convertAttributesToString(inputMap);

      expect(result, expectedMap);
    });

    test('commaSeparatedJson', () {
      final inputList = ['apple', 'banana', 'orange'];
      final expectedString = 'apple,banana,orange';

      final result = JsonEncodingMethods.commaSeparatedJson(inputList);

      expect(result, expectedString);
    });

    test('commaSeparatedJson with null list', () {
      final inputList = null;

      final result = JsonEncodingMethods.commaSeparatedJson(inputList);

      expect(result, isNull);
    });
  });
}
