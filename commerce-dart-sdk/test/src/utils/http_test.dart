import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('StatusCodeExtension', () {
    test('isSuccessStatusCode', () {
      expect(StatusCodeExtension.isSuccessStatusCode(200), true);
      expect(StatusCodeExtension.isSuccessStatusCode(299), true);
      expect(StatusCodeExtension.isSuccessStatusCode(300), false);
      expect(StatusCodeExtension.isSuccessStatusCode(199), false);
    });
  });
}
