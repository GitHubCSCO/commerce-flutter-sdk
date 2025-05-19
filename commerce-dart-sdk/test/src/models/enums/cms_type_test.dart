import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CmsType', () {
    test('CmsType enumValues', () {
      expect(CmsType.values.length, equals(3));
      expect(CmsType.classic, equals(CmsType.classic));
      expect(CmsType.spire, equals(CmsType.spire));
      expect(CmsType.headless, equals(CmsType.headless));
    });
  });
}
