import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import '../../mocks/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockDioException());
    registerFallbackValue(MockRequestOptions());
    registerFallbackValue(MockResponse());
  });
  group('LoggerInterceptor', () {
    test('onError', () {
      final interceptor = LoggerInterceptor();
      final mockHandler = MockErrorInterceptorHandler();
      final options = RequestOptions(path: '/test');

      interceptor.onError(
        DioException(
            requestOptions: options,
            error: 'error',
            type: DioExceptionType.unknown),
        mockHandler,
      );

      verify(() => mockHandler.next(any()))
          .called(1); // Ensure handler.next() is called
    });

    test('onRequest', () {
      final interceptor = LoggerInterceptor();
      final mockHandler = MockRequestInterceptorHandler();
      final options = RequestOptions(path: '/test');

      interceptor.onRequest(options, mockHandler);

      verify(() => mockHandler.next(any()))
          .called(1); // Ensure handler.next() is called
    });

    test('onResponse', () {
      final interceptor = LoggerInterceptor();
      final mockHandler = MockResponseInterceptorHandler();
      final options = RequestOptions(path: '/test');
      final response = Response(
          data: {'key': 'value'}, requestOptions: options, statusCode: 200);

      interceptor.onResponse(response, mockHandler);

      verify(() => mockHandler.next(any()))
          .called(1); // Ensure handler.next() is called
    });
  });
}
