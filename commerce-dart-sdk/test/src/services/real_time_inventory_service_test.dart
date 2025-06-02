import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late RealTimeInventoryService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = RealTimeInventoryService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('getProductRealTimeInventory', () {
    test('should return inventory results when successful', () async {
      // Arrange
      final parameters = RealTimeInventoryParameters(productIds: ['P123']);
      final expectedResult = GetRealTimeInventoryResult(
        realTimeInventoryResults: [
          ProductInventory(productId: 'P123', qtyOnHand: 10)
        ],
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(
            any(),
            any(),
          )).thenAnswer((_) async => Success(Response(
            statusCode: 200,
            requestOptions: RequestOptions(),
            data: expectedResult.toJson(),
          )));

      // Act
      final result =
          await sut.getProductRealTimeInventory(parameters: parameters);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value, isNotNull);
          expect(value?.realTimeInventoryResults, isNotNull);
          expect(value?.realTimeInventoryResults, isNotEmpty);
          expect(value?.realTimeInventoryResults?.first.productId, 'P123');
          verify(() => clientService.postAsync(any(), any())).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      final parameters = RealTimeInventoryParameters(productIds: ['P123']);
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result =
          await sut.getProductRealTimeInventory(parameters: parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.message, 'No internet connection');
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final parameters = RealTimeInventoryParameters(productIds: ['P123']);
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result =
          await sut.getProductRealTimeInventory(parameters: parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.message, 'An unexpected error occurred');
      }
    });
  });
}
