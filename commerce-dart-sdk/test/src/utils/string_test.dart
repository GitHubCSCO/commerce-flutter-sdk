import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CompatibilityExtension', () {
    test('isNullOrEmpty', () {
      expect(''.isNullOrEmpty, true);
      expect('hello'.isNullOrEmpty, false);
      expect(null.isNullOrEmpty, true);
    });

    test('isNullorWhitespace', () {
      expect(''.isNullorWhitespace, true);
      expect('  '.isNullorWhitespace, true);
      expect('hello'.isNullorWhitespace, false);
      expect(null.isNullorWhitespace, true);
    });

    test('equalsIgnoreCase', () {
      expect('hello'.equalsIgnoreCase('HELLO'), true);
      expect('hello'.equalsIgnoreCase('world'), false);
      expect(null.equalsIgnoreCase('hello'), false);
      expect('hello'.equalsIgnoreCase(null), false);
    });

    test('stripHtml', () {
      expect('<p>Hello</p>'.stripHtml(), 'Hello');
      expect('<div><p>Hello</p></div>'.stripHtml(), 'Hello');
      expect('Hello'.stripHtml(), 'Hello');
      expect(null.stripHtml(), isNull);
    });
  });
}
