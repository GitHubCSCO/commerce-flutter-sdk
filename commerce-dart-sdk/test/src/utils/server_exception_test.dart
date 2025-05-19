import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {
  final options = RequestOptions(path: '/test');
  group('ServerException', () {
    test('should handle DioExceptionType.cancel', () {
      final exception = ServerException(
          DioException(requestOptions: options, type: DioExceptionType.cancel));
      expect(exception.exceptionType, ServerExceptionType.requestCancelled);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Request to the server has been canceled');
    });
    test('should handle DioExceptionType.connectionTimeout', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.connectionTimeout));
      expect(exception.exceptionType, ServerExceptionType.requestTimeout);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Connection timeout');
    });
    test('should handle DioExceptionType.receiveTimeout', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.receiveTimeout));
      expect(exception.exceptionType, ServerExceptionType.recieveTimeout);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Receive timeout');
    });
    test('should handle DioExceptionType.sendTimeout', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.sendTimeout));
      expect(exception.exceptionType, ServerExceptionType.sendTimeout);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Send timeout');
    });
    test('should handle DioExceptionType.connectionError', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.unknown));
      expect(exception.exceptionType, ServerExceptionType.unexpectedError);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Unexpected error');
    });
    test('should handle DioExceptionType.badCertificate', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.unknown));
      expect(exception.exceptionType, ServerExceptionType.unexpectedError);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Unexpected error');
    });
    test('should handle unknown DioExceptionType', () {
      final exception = ServerException(DioException(
          requestOptions: options, type: DioExceptionType.unknown));
      expect(exception.exceptionType, ServerExceptionType.unexpectedError);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Unexpected error');
    });
    test('should handle badResponse with specific status codes', () {
      final response = Response(requestOptions: options, statusCode: 400);
      final exception = ServerException(DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: response));
      expect(exception.exceptionType, ServerExceptionType.badRequest);
      expect(exception.statusCode, 400);
      expect(exception.message, 'Bad request.');
    });

    test('should handle status code (cloudflareGatewayTimeout) 524', () {
      final response = Response(requestOptions: options, statusCode: 524);
      final exception = ServerException(DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: response));
      expect(exception.exceptionType,
          ServerExceptionType.cloudflareGatewayTimeout);
      expect(exception.statusCode, 524);
      expect(exception.message, 'Cloudflare gateway timeout');
    });

    test('should handle unknown DioException', () {
      final exception = ServerException(Exception());
      expect(exception.exceptionType, ServerExceptionType.unexpectedError);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Unexpected error');
    });

    test('should handle FormatException', () {
      final exception = ServerException(FormatException('Format error'));
      expect(exception.exceptionType, ServerExceptionType.formatException);
      expect(exception.statusCode, isNull);
      expect(exception.message, 'Format error');
    });
  });
}
