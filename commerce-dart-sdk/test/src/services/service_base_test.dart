import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockClientService mockClientService;
  late MockCacheService mockCacheService;
  late MockNetworkService mockNetworkService;
  late ServiceBase serviceBase;

  setUp(() {
    mockClientService = MockClientService();
    mockCacheService = MockCacheService();
    mockNetworkService = MockNetworkService();

    serviceBase = ServiceBase(
      clientService: mockClientService,
      cacheService: mockCacheService,
      networkService: mockNetworkService,
    );
  });

  group('ServiceBase - getAsyncNoCache', () {
    test('returns Success when online and response is valid', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));
      when(() => mockClientService.getAsync(any())).thenAnswer((_) async =>
          Success(Response(
              data: {'key': 'value'}, requestOptions: RequestOptions())));

      final result = await serviceBase.getAsyncNoCache<Map<String, dynamic>>(
        '/test',
        (json) => json,
      );

      expect(result, isA<Success>());
      expect((result as Success).value, {'key': 'value'});
    });

    test('returns Failure when offline', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(false));

      final result = await serviceBase.getAsyncNoCache<Map<String, dynamic>>(
        '/test',
        (json) => json,
      );

      expect(result, isA<Failure>());
      expect((result as Failure).errorResponse.error, 'No internet found');
    });

    test('returns Failure when an error occurs in clientService', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));
      when(() => mockClientService.getAsync(any()))
          .thenAnswer((_) async => Failure(ErrorResponse(error: 'Error')));

      final result = await serviceBase.getAsyncNoCache<Map<String, dynamic>>(
        '/test',
        (json) => json,
      );

      expect(result, isA<Failure>());
      expect((result as Failure).errorResponse.error, 'Error');
    });
  });
}
