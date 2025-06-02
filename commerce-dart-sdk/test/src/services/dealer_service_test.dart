import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late DealerService dealerService;
  late MockClientService clientService;
  late MockNetworkService networkService;
  late MockCacheService cacheService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    cacheService = MockCacheService();
    dealerService = DealerService(
      clientService: clientService,
      networkService: networkService,
      cacheService: cacheService,
    );
  });

  group('getDealers', () {
    final mockDealer = Dealer(
      id: '1',
      name: 'Test Dealer',
      address1: '123 Test St',
      city: 'Test City',
      state: 'TS',
      postalCode: '12345',
      countryId: 'US',
      phone: '123-456-7890',
      latitude: 40.7128,
      longitude: -74.0060,
      webSiteUrl: 'https://dealerwebsite.com',
      distance: 10.0,
    );

    final mockDealerCollectionResult = GetDealerCollectionResult(
      dealers: [mockDealer],
      defaultLatitude: 40.0,
      defaultLongitude: -75.0,
      defaultRadius: 50.0,
      distanceUnitOfMeasure: 'miles',
    );

    final mockParameters = DealerLocationFinderQueryParameters(
      latitude: 40.7128,
      longitude: -74.0060,
      radius: 50.0,
      page: 1,
      pageSize: 10,
    );

    test('should return dealers when API call is successful', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: mockDealerCollectionResult.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await dealerService.getDealers(parameters: mockParameters);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.dealers, isNotNull);
          expect(value?.dealers?.length, equals(1));
          expect(value?.dealers?[0].name, equals('Test Dealer'));
          verify(() => clientService.getAsync(any())).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when API call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'API Error',
        message: 'Failed to fetch dealers',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await dealerService.getDealers(parameters: mockParameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('API Error'));
          expect(errorResponse.message, equals('Failed to fetch dealers'));
          verify(() => clientService.getAsync(any())).called(1);
      }
    });
    //
    // test('should handle request cancellation gracefully', () async {
    //   // Arrange
    //   final cancelToken = CancelToken();
    //   final mockRequestOptions = RequestOptions(path: 'test-path');
    //
    //   when(() => networkService.isOnline()).thenAnswer((_) async => true);
    //   when(() => clientService.getAsync(any())).thenThrow(
    //     DioException(
    //       requestOptions: mockRequestOptions,
    //       type: DioExceptionType.cancel,
    //     ),
    //   );
    //
    //   // Act
    //   final result = await dealerService.getDealers(
    //     parameters: mockParameters,
    //     cancelToken: cancelToken,
    //   );
    //
    //   // Assert
    //   switch (result) {
    //     case Success():
    //       fail('Expected Failure but got Success');
    //     case Failure(errorResponse: final errorResponse):
    //       expect(errorResponse.message, contains('Request was cancelled'));
    //       verify(() => clientService.getAsync(any())).called(1);
    //   }
    // });

    test('should construct URL with query parameters correctly', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: mockDealerCollectionResult.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await dealerService.getDealers(parameters: mockParameters);

      // Assert
      switch (result) {
        case Success():
          final captured = verify(() => clientService.getAsync(captureAny()))
              .captured
              .single;
          expect(captured, contains('latitude=40.7128'));
          expect(captured, contains('longitude=-74.006'));
          expect(captured, contains('radius=50.0'));
          expect(captured, contains('page=1'));
          expect(captured, contains('pageSize=10'));
        case Failure():
          fail('Expected Success but got Failure');
      }
    });
  });
}
