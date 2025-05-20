import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late CategoryService categoryService;
  late MockClientService clientService;
  late MockNetworkService networkService;
  late MockCacheService cacheService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    cacheService = MockCacheService();
    categoryService = CategoryService(
      clientService: clientService,
      networkService: networkService,
      cacheService: cacheService,
    );
  });

  group('getCategory', () {
    const categoryId = 'CAT123';
    final category = Category(
      id: categoryId,
      name: 'Electronics',
      isFeatured: true,
    );

    test('should return category when successful', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: category.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await categoryService.getCategory(categoryId);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.id, equals(categoryId));
          expect(value?.name, equals('Electronics'));
          verify(() => clientService.getAsync(
              '${CommerceAPIConstants.categoryUrl}/$categoryId')).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when API call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'API Error',
        message: 'Failed to fetch category',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await categoryService.getCategory(categoryId);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('API Error'));
          expect(errorResponse.message, equals('Failed to fetch category'));
          verify(() => clientService.getAsync(
              '${CommerceAPIConstants.categoryUrl}/$categoryId')).called(1);
      }
    });
  });

  group('getCategoryList', () {
    final categories = [
      Category(id: 'CAT123', name: 'Electronics'),
      Category(id: 'CAT124', name: 'Appliances'),
    ];

    test('should return category list when successful', () async {
      // Arrange
      final result = CategoryResult(categories: categories);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: result.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final actualResult = await categoryService.getCategoryList();

      // Assert
      switch (actualResult) {
        case Success(value: final value):
          expect(value, isNotEmpty);
          expect(value?.length, equals(2));
          verify(() => clientService.getAsync(CommerceAPIConstants.categoryUrl))
              .called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when API call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'API Error',
        message: 'Failed to fetch categories',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await categoryService.getCategoryList();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('API Error'));
          expect(response.message, equals('Failed to fetch categories'));
          verify(() => clientService.getAsync(CommerceAPIConstants.categoryUrl))
              .called(1);
      }
    });
  });

  group('getFeaturedCategories', () {
    final categories = [
      Category(id: 'CAT123', name: 'Electronics', isFeatured: true),
      Category(id: 'CAT124', name: 'Appliances', isFeatured: false),
    ];

    test('should return featured categories when successful', () async {
      // Arrange
      final result = CategoryResult(categories: categories);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: result.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final actualResult = await categoryService.getFeaturedCategories();

      // Assert
      switch (actualResult) {
        case Success(value: final value):
          expect(value, isNotEmpty);
          expect(value?.length, equals(1));
          expect(value?[0].name, equals('Electronics'));
          verify(() => clientService.getAsync(CommerceAPIConstants.categoryUrl))
              .called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });
  });

  group('hasCategoryCache', () {
    const categoryId = 'CAT123';
    const sessionStateKey = 'mockSessionStateKey';

    test('should return true if cache exists', () async {
      // Arrange
      when(() => clientService.sessionStateKey)
          .thenAnswer((_) async => sessionStateKey);
      when(() => cacheService.hasOnlineCache(any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await categoryService.hasCategoryCache(categoryId);

      // Assert
      expect(result, isTrue);
      verify(() => cacheService.hasOnlineCache(any())).called(1);
    });

    test('should return false if cache does not exist', () async {
      // Arrange
      when(() => clientService.sessionStateKey)
          .thenAnswer((_) async => sessionStateKey);
      when(() => cacheService.hasOnlineCache(any()))
          .thenAnswer((_) async => false);

      // Act
      final result = await categoryService.hasCategoryCache(categoryId);

      // Assert
      expect(result, isFalse);
      verify(() => cacheService.hasOnlineCache(any())).called(1);
    });
  });
}
