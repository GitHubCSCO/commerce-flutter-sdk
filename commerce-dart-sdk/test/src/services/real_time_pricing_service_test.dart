import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late RealTimePricingService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = RealTimePricingService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('getProductRealTimePrices', () {
    test('should return real-time prices when successful', () async {
      // Arrange
      final parameters = RealTimePricingParameters(
        productPriceParameters: [ProductPriceQueryParameter(productId: 'P123')],
      );
      final expectedResult = GetRealTimePricingResult(realTimePricingResults: [
        ProductPrice(productId: 'P123', unitNetPrice: 100.0),
      ]);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(
            any(),
            any(),
          )).thenAnswer((_) async => Success(Response(
            data: expectedResult.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          )));

      // Act
      final result = await sut.getProductRealTimePrices(parameters);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.realTimePricingResults, isNotEmpty);
          expect(
              value?.realTimePricingResults?.first.productId, equals('P123'));
          expect(
              value?.realTimePricingResults?.first.unitNetPrice, equals(100.0));
          verify(() => clientService.postAsync(
                CommerceAPIConstants.realTimePricingUrl,
                parameters.toJson(),
              )).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      final parameters = RealTimePricingParameters(productPriceParameters: [
        ProductPriceQueryParameter(productId: 'P123')
      ]);
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut.getProductRealTimePrices(parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.message, equals('No internet connection'));
          verifyNever(() => clientService.postAsync(any(), any()));
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final parameters = RealTimePricingParameters(productPriceParameters: [
        ProductPriceQueryParameter(productId: 'P123')
      ]);
      final errorResponse = ErrorResponse(
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await sut.getProductRealTimePrices(parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.postAsync(any(), any())).called(1);
      }
    });
  });
}
