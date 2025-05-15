import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('Result classes', () {
    test('Success', () {
      final success = Success<int, String>(42, statusCode: 200);

      expect(success.value, 42);
      expect(success.statusCode, 200);
    });

    test('Failure', () {
      final failure = Failure<int, String>('Error message');

      expect(failure.errorResponse, 'Error message');
    });

    test('ApiResult', () {
      final apiResult = Future.value(Success<int, String>(42, statusCode: 200));

      expect(apiResult, isA<Future<Result<int, String>>>());
    });
  });
}
