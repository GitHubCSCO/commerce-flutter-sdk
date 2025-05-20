import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CartType', () {
    test('CartType enumValues', () {
      expect(CartType.values.length, equals(3));
      expect(CartType.current, equals(CartType.current));
      expect(CartType.regular, equals(CartType.regular));
      expect(CartType.alternate, equals(CartType.alternate));
    });
  });
}
