import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_category_usecase/brand_category_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockTrackingService extends Mock implements ITrackingService {}

void main() {
  final sl = GetIt.instance;

  late BrandCategoryUseCase brandCategoryUseCase;
  late MockBrandService mockBrandService;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockTrackingService mockTrackingService;

  setUpAll(() async {
    // Reset GetIt before all tests
    await sl.reset();
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockBrandService = MockBrandService();
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockTrackingService = MockTrackingService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getBrandService())
        .thenReturn(mockBrandService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Initialize the use case
    brandCategoryUseCase = BrandCategoryUseCase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('BrandCategoryUseCase Tests', () {
    group('getBrandCategories', () {
      test(
          'should return Success when brand categories are fetched successfully',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter();
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [
            BrandCategory(
              brandId: '1',
              categoryId: 'cat-1',
              categoryName: 'Electronics',
              categoryShortDescription: 'Electronic products',
            ),
            BrandCategory(
              brandId: '2',
              categoryId: 'cat-2',
              categoryName: 'Clothing',
              categoryShortDescription: 'Fashion and apparel',
            ),
          ],
          pagination: Pagination(
            currentPage: 1,
            totalItemCount: 2,
            numberOfPages: 1,
          ),
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.brandCategories?.length, equals(2));
        expect(successResult.value?.brandCategories?.first.categoryName,
            equals('Electronics'));
        expect(successResult.value?.brandCategories?.last.categoryName,
            equals('Clothing'));

        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should return Failure when brand service returns an error',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter();
        final errorResponse = ErrorResponse(
          message: 'Failed to fetch brand categories',
          error: 'NetworkError',
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Failure(errorResponse));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Failure<GetBrandCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandCategoriesResult, ErrorResponse>;
        expect(failureResult.errorResponse.message,
            equals('Failed to fetch brand categories'));

        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should return empty result when no brand categories are found',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter();
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [],
          pagination: Pagination(
            currentPage: 1,
            totalItemCount: 0,
            numberOfPages: 0,
          ),
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.brandCategories?.isEmpty, isTrue);
        expect(successResult.value?.pagination?.totalItemCount, equals(0));

        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should handle exception when brand service throws an error',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter();

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenThrow(Exception('Network connection failed'));

        // Act & Assert
        expect(
          () => brandCategoryUseCase.getBrandCategories(queryParameter),
          throwsException,
        );

        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should pass correct query parameters to brand service', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          page: 2,
          pageSize: 10,
          sort: 'name',
          maximumDepth: 3,
        );
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [],
          pagination: Pagination(currentPage: 2, totalItemCount: 0),
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });
    });

    group('getBrandCategorySubCategories', () {
      test(
          'should return Success when brand sub-categories are fetched successfully',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'electronics-category',
        );
        final expectedResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          categoryId: 'electronics-category',
          categoryName: 'Electronics',
          subCategories: [
            GetBrandSubCategoriesResult(
              brandId: 'brand123',
              categoryId: 'sub1',
              categoryName: 'Smartphones',
            ),
            GetBrandSubCategoriesResult(
              brandId: 'brand123',
              categoryId: 'sub2',
              categoryName: 'Laptops',
            ),
          ],
          pagination: Pagination(
            currentPage: 1,
            totalItemCount: 2,
            numberOfPages: 1,
          ),
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Success<GetBrandSubCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(successResult.value?.subCategories?.length, equals(2));
        expect(successResult.value?.subCategories?.first.categoryName,
            equals('Smartphones'));
        expect(successResult.value?.subCategories?.last.categoryName,
            equals('Laptops'));

        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });

      test('should return Failure when brand service returns an error',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'invalid-category',
        );
        final errorResponse = ErrorResponse(
          message: 'Category not found',
          error: 'NotFound',
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Failure(errorResponse));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Failure<GetBrandSubCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(
            failureResult.errorResponse.message, equals('Category not found'));

        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });

      test('should return empty result when no sub-categories are found',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'empty-category',
        );
        final expectedResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          categoryId: 'empty-category',
          subCategories: [],
          pagination: Pagination(
            currentPage: 1,
            totalItemCount: 0,
            numberOfPages: 0,
          ),
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Success<GetBrandSubCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(successResult.value?.subCategories?.isEmpty, isTrue);
        expect(successResult.value?.pagination?.totalItemCount, equals(0));

        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });

      test('should handle exception when brand service throws an error',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'test-category',
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenThrow(Exception('Database connection failed'));

        // Act & Assert
        expect(
          () => brandCategoryUseCase
              .getBrandCategorySubCategories(queryParameter),
          throwsException,
        );

        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });

      test(
          'should pass correct query parameters to brand service for sub-categories',
          () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'electronics',
          page: 3,
          pageSize: 20,
          sort: 'name',
          maximumDepth: 2,
        );
        final expectedResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          categoryId: 'electronics',
          subCategories: [],
          pagination: Pagination(currentPage: 3, totalItemCount: 0),
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });
    });

    group('Integration Tests', () {
      test('should handle multiple concurrent requests correctly', () async {
        // Arrange
        final queryParameter1 = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          page: 1,
        );
        final queryParameter2 = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'electronics',
          page: 1,
        );

        final categoriesResult = GetBrandCategoriesResult(
          brandCategories: [
            BrandCategory(
              brandId: 'brand123',
              categoryId: '1',
              categoryName: 'Electronics',
            ),
          ],
        );
        final subCategoriesResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          categoryId: 'electronics',
          subCategories: [
            GetBrandSubCategoriesResult(
              brandId: 'brand123',
              categoryId: 'sub1',
              categoryName: 'Smartphones',
            ),
          ],
        );

        when(() => mockBrandService.getBrandCategories(queryParameter1))
            .thenAnswer((_) async => Success(categoriesResult));
        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter2))
            .thenAnswer((_) async => Success(subCategoriesResult));

        // Act
        final futures = await Future.wait([
          brandCategoryUseCase.getBrandCategories(queryParameter1),
          brandCategoryUseCase.getBrandCategorySubCategories(queryParameter2),
        ]);

        // Assert
        expect(futures[0],
            isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        expect(futures[1],
            isA<Success<GetBrandSubCategoriesResult, ErrorResponse>>());

        verify(() => mockBrandService.getBrandCategories(queryParameter1))
            .called(1);
        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter2))
            .called(1);
      });

      test('should maintain state independence between method calls', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final categoriesResult = GetBrandCategoriesResult(brandCategories: []);
        final subCategoriesResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          subCategories: [],
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(categoriesResult));
        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Success(subCategoriesResult));

        // Act
        await brandCategoryUseCase.getBrandCategories(queryParameter);
        await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);
        await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(2);
        verify(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .called(1);
      });
    });

    group('Error Handling Edge Cases', () {
      test('should handle invalid query parameter gracefully', () async {
        // Arrange
        final invalidParameter = BrandCategoriesQueryParameter();

        when(() => mockBrandService.getBrandCategories(invalidParameter))
            .thenThrow(ArgumentError('Invalid query parameter'));

        // Act & Assert
        expect(
          () => brandCategoryUseCase.getBrandCategories(invalidParameter),
          throwsArgumentError,
        );
      });

      test('should handle timeout errors appropriately', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final timeoutError = ErrorResponse(
          message: 'Request timed out',
          error: 'TimeoutError',
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Failure(timeoutError));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Failure<GetBrandCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandCategoriesResult, ErrorResponse>;
        expect(failureResult.errorResponse.error, equals('TimeoutError'));
      });

      test('should handle authentication errors for sub-categories', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'restricted',
        );
        final authError = ErrorResponse(
          message: 'Unauthorized access',
          error: 'AuthenticationError',
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Failure(authError));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Failure<GetBrandSubCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(
            failureResult.errorResponse.error, equals('AuthenticationError'));
      });

      test('should handle malformed response data gracefully', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final malformedError = ErrorResponse(
          message: 'Invalid response format',
          error: 'ParseError',
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Failure(malformedError));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Failure<GetBrandCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandCategoriesResult, ErrorResponse>;
        expect(failureResult.errorResponse.message,
            equals('Invalid response format'));
      });

      test('should handle network connectivity issues', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'electronics',
        );
        final networkError = ErrorResponse(
          message: 'Network unavailable',
          error: 'NetworkError',
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Failure(networkError));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Failure<GetBrandSubCategoriesResult, ErrorResponse>>());
        final failureResult =
            result as Failure<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(
            failureResult.errorResponse.message, equals('Network unavailable'));
      });
    });

    group('Parameter Validation Tests', () {
      test('should handle query parameters with special characters', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand-with-special-chars!@#',
          categoryId: 'category_with_underscores',
          sort: 'name desc',
        );
        final expectedResult = GetBrandCategoriesResult(brandCategories: []);

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should handle maximum depth parameter correctly', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          maximumDepth: 5,
        );
        final expectedResult = GetBrandCategoriesResult(brandCategories: []);

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });

      test('should handle large page sizes', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          page: 1,
          pageSize: 1000,
        );
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [],
          pagination: Pagination(
            currentPage: 1,
            pageSize: 1000,
            totalItemCount: 0,
          ),
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.pagination?.pageSize, equals(1000));

        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(1);
      });
    });

    group('Data Validation Tests', () {
      test('should handle null pagination gracefully', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [
            BrandCategory(
              brandId: 'brand123',
              categoryId: 'cat1',
              categoryName: 'Test Category',
            ),
          ],
          pagination: null, // Null pagination
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.brandCategories?.length, equals(1));
        expect(successResult.value?.pagination, isNull);
      });

      test('should handle empty category names gracefully', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: [
            BrandCategory(
              brandId: 'brand123',
              categoryId: 'cat1',
              categoryName: '', // Empty name
            ),
            BrandCategory(
              brandId: 'brand123',
              categoryId: 'cat2',
              categoryName: null, // Null name
            ),
          ],
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.brandCategories?.length, equals(2));
        expect(successResult.value?.brandCategories?.first.categoryName,
            equals(''));
        expect(successResult.value?.brandCategories?.last.categoryName, isNull);
      });

      test('should handle nested sub-categories correctly', () async {
        // Arrange
        final queryParameter = BrandCategoriesQueryParameter(
          brandId: 'brand123',
          categoryId: 'electronics',
        );
        final expectedResult = GetBrandSubCategoriesResult(
          brandId: 'brand123',
          categoryId: 'electronics',
          categoryName: 'Electronics',
          subCategories: [
            GetBrandSubCategoriesResult(
              brandId: 'brand123',
              categoryId: 'phones',
              categoryName: 'Phones',
              subCategories: [
                GetBrandSubCategoriesResult(
                  brandId: 'brand123',
                  categoryId: 'smartphones',
                  categoryName: 'Smartphones',
                ),
              ],
            ),
          ],
        );

        when(() =>
                mockBrandService.getBrandCategorySubCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result = await brandCategoryUseCase
            .getBrandCategorySubCategories(queryParameter);

        // Assert
        expect(
            result, isA<Success<GetBrandSubCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandSubCategoriesResult, ErrorResponse>;
        expect(successResult.value?.subCategories?.length, equals(1));
        expect(successResult.value?.subCategories?.first.subCategories?.length,
            equals(1));
        expect(
            successResult
                .value?.subCategories?.first.subCategories?.first.categoryName,
            equals('Smartphones'));
      });
    });

    group('Performance Tests', () {
      test('should handle large numbers of brand categories', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final largeCategoryList = List.generate(
            100,
            (index) => BrandCategory(
                  brandId: 'brand123',
                  categoryId: 'cat$index',
                  categoryName: 'Category $index',
                ));
        final expectedResult = GetBrandCategoriesResult(
          brandCategories: largeCategoryList,
          pagination: Pagination(
            currentPage: 1,
            totalItemCount: 100,
            numberOfPages: 10,
            pageSize: 10,
          ),
        );

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        final result =
            await brandCategoryUseCase.getBrandCategories(queryParameter);

        // Assert
        expect(result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        final successResult =
            result as Success<GetBrandCategoriesResult, ErrorResponse>;
        expect(successResult.value?.brandCategories?.length, equals(100));
        expect(successResult.value?.pagination?.totalItemCount, equals(100));
      });

      test('should handle sequential calls efficiently', () async {
        // Arrange
        final queryParameter =
            BrandCategoriesQueryParameter(brandId: 'brand123');
        final expectedResult = GetBrandCategoriesResult(brandCategories: []);

        when(() => mockBrandService.getBrandCategories(queryParameter))
            .thenAnswer((_) async => Success(expectedResult));

        // Act
        for (int i = 0; i < 5; i++) {
          final result =
              await brandCategoryUseCase.getBrandCategories(queryParameter);
          expect(
              result, isA<Success<GetBrandCategoriesResult, ErrorResponse>>());
        }

        // Assert
        verify(() => mockBrandService.getBrandCategories(queryParameter))
            .called(5);
      });
    });
  });
}
