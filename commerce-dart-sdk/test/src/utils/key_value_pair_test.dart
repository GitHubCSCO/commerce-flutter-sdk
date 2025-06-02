import 'package:optimizely_commerce_api/src/utils/key_value_pair.dart';
import 'package:test/test.dart';

void main() {
  group('KeyValuePair', () {
    test('toJson', () {
      final pair = KeyValuePair<int, String>(1, 'value');

      final json = pair.toJson();

      expect(json, {'key': 1, 'value': 'value'});
    });

    test('fromJson', () {
      final json = {'key': 2, 'value': 'another_value'};

      final pair = KeyValuePair.fromJson(json);

      expect(pair.key, 2);
      expect(pair.value, 'another_value');
    });

    test('equality', () {
      final pair1 = KeyValuePair<int, String>(1, 'value');
      final pair2 = KeyValuePair<int, String>(1, 'value');
      final pair3 = KeyValuePair<int, String>(2, 'value');

      expect(pair1 == pair2, true);
      expect(pair1 == pair3, false);
    });

    test('hashCode', () {
      final pair1 = KeyValuePair<int, String>(1, 'value');
      final pair2 = KeyValuePair<int, String>(1, 'value');
      final pair3 = KeyValuePair<int, String>(2, 'value');

      expect(pair1.hashCode == pair2.hashCode, true);
      expect(pair1.hashCode == pair3.hashCode, false);
    });
  });
}
