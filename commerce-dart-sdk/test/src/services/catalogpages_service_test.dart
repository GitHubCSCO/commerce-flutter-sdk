import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late CatalogpagesService catalogpagesService;
  late MockClientService clientService;
  late MockNetworkService networkService;
  late MockCacheService cacheService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    cacheService = MockCacheService();
    catalogpagesService = CatalogpagesService(
      clientService: clientService,
      networkService: networkService,
      cacheService: cacheService,
    );
  });

  group('getProductCatalogInformation', () {
    const productPath = '/path/to/product';
    final catalogPage = CatalogPage(
      category: Category(name: 'Electronics'),
      brandId: 'BR123',
      productLineId: 'PL456',
      productId: 'PR789',
      productName: 'Smartphone',
      title: 'Smartphone Product Page',
      metaDescription: 'Description of the smartphone.',
      metaKeywords: 'smartphone, electronics, mobile',
      canonicalPath: '/smartphone',
      alternateLanguageUrls: {'fr': '/fr/smartphone'},
      isReplacementProduct: false,
      breadCrumbs: [
        BreadCrumb(text: 'Home', url: '/'),
        BreadCrumb(text: 'Electronics', url: '/electronics'),
        BreadCrumb(text: 'Smartphone', url: '/smartphone'),
      ],
      obsoletePath: false,
      needRedirect: false,
      redirectUrl: null,
      primaryImagePath: '/images/smartphone.jpg',
      openGraphTitle: 'Smartphone Product',
      openGraphImage: '/images/smartphone-og.jpg',
      openGraphUrl: '/smartphone',
    );

    test('should return CatalogPage when successful', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: catalogPage.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result =
          await catalogpagesService.getProductCatalogInformation(productPath);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value, isNotNull);
          expect(value?.productId, equals('PR789'));
          expect(value?.productName, equals('Smartphone'));
          expect(value?.category?.name, equals('Electronics'));
          verify(() => clientService.getAsync(
              '${CommerceAPIConstants.catalogPageUrl}$productPath')).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result =
          await catalogpagesService.getProductCatalogInformation(productPath);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('No internet found'));
          verifyNever(() => clientService.getAsync(any()));
      }
    });

    test('should return failure when API call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result =
          await catalogpagesService.getProductCatalogInformation(productPath);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('Some error'));
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.getAsync(
              '${CommerceAPIConstants.catalogPageUrl}$productPath')).called(1);
      }
    });
  });
}
