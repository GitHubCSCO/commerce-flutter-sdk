import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockAutocompleteService extends Mock implements IAutocompleteService {}

class MockVmiLocationsService extends Mock implements IVmiLocationsService {}

class MockProductService extends Mock implements IProductService {}

class MockCategoryService extends Mock implements ICategoryService {}

class MockBrandService extends Mock implements IBrandService {}

class MockSettingsService extends Mock implements ISettingsService {}

class MockVmiService extends Mock implements IVmiService {}

class MockVmiLocationModel extends Mock implements VmiLocationModel {}

class MockAutocompleteResult extends Mock implements AutocompleteResult {}

class MockGetVmiBinResult extends Mock implements GetVmiBinResult {}

class MockVmiBinModel extends Mock implements VmiBinModel {}

class MockProduct extends Mock implements Product {}

class MockBrand extends Mock implements Brand {}

class MockCategory extends Mock implements Category {}

class MockGetProductCollectionResult extends Mock
    implements GetProductCollectionResult {}

class MockMobileAppSettings extends Mock implements MobileAppSettings {}

// Create fake for fallback values
class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakeAutocompleteQueryParameters extends Fake
    implements AutocompleteQueryParameters {}

class FakeVmiBinQueryParameters extends Fake implements VmiBinQueryParameters {}

class FakeProductsQueryParameters extends Fake
    implements ProductsQueryParameters {}

class FakeCategoryQueryParameters extends Fake
    implements CategoryQueryParameters {}

class FakeAutocompleteResult extends Fake implements AutocompleteResult {}

class FakeGetVmiBinResult extends Fake implements GetVmiBinResult {}

class FakeGetProductCollectionResult extends Fake
    implements GetProductCollectionResult {}

class FakeCategory extends Fake implements Category {}

class FakeBrand extends Fake implements Brand {}

class FakeMobileAppSettings extends Fake implements MobileAppSettings {}

void main() {
  final sl = GetIt.instance;

  late SearchUseCase searchUseCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockAutocompleteService mockAutocompleteService;
  late MockVmiLocationsService mockVmiLocationsService;
  late MockProductService mockProductService;
  late MockCategoryService mockCategoryService;
  late MockBrandService mockBrandService;
  late MockSettingsService mockSettingsService;
  late MockVmiService mockVmiService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakeAutocompleteQueryParameters());
    registerFallbackValue(FakeVmiBinQueryParameters());
    registerFallbackValue(FakeProductsQueryParameters());
    registerFallbackValue(FakeCategoryQueryParameters());
    registerFallbackValue(FakeAutocompleteResult());
    registerFallbackValue(FakeGetVmiBinResult());
    registerFallbackValue(FakeGetProductCollectionResult());
    registerFallbackValue(FakeCategory());
    registerFallbackValue(FakeBrand());
    registerFallbackValue(FakeMobileAppSettings());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockAutocompleteService = MockAutocompleteService();
    mockVmiLocationsService = MockVmiLocationsService();
    mockProductService = MockProductService();
    mockCategoryService = MockCategoryService();
    mockBrandService = MockBrandService();
    mockSettingsService = MockSettingsService();
    mockVmiService = MockVmiService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock service provider dependencies
    when(() => mockCommerceAPIServiceProvider.getAutocompleteService())
        .thenReturn(mockAutocompleteService);
    when(() => mockCommerceAPIServiceProvider.getVmiLocationsService())
        .thenReturn(mockVmiLocationsService);
    when(() => mockCommerceAPIServiceProvider.getProductService())
        .thenReturn(mockProductService);
    when(() => mockCommerceAPIServiceProvider.getCategoryService())
        .thenReturn(mockCategoryService);
    when(() => mockCommerceAPIServiceProvider.getBrandService())
        .thenReturn(mockBrandService);
    when(() => mockCommerceAPIServiceProvider.getSettingsService())
        .thenReturn(mockSettingsService);
    when(() => mockCoreServiceProvider.getVmiService())
        .thenReturn(mockVmiService);

    // Initialize the use case
    searchUseCase = SearchUseCase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('SearchUseCase Tests', () {
    group('Inheritance and architecture tests', () {
      test('should properly extend BaseUseCase', () {
        expect(searchUseCase, isA<SearchUseCase>());
        // Verify that it can access BaseUseCase properties
        expect(
            searchUseCase.coreServiceProvider, equals(mockCoreServiceProvider));
        expect(searchUseCase.commerceAPIServiceProvider,
            equals(mockCommerceAPIServiceProvider));
      });

      test('should have correct service provider dependencies', () {
        // Act
        final coreProvider = searchUseCase.coreServiceProvider;
        final commerceProvider = searchUseCase.commerceAPIServiceProvider;

        // Assert
        expect(coreProvider, isA<ICoreServiceProvider>());
        expect(commerceProvider, isA<ICommerceAPIServiceProvider>());
        expect(coreProvider, equals(mockCoreServiceProvider));
        expect(commerceProvider, equals(mockCommerceAPIServiceProvider));
      });
    });

    group('loadAutocompleteResults', () {
      test('should return Success when autocomplete service succeeds',
          () async {
        // Arrange
        const searchQuery = 'test query';
        final mockResult = MockAutocompleteResult();

        when(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).thenAnswer(
          (_) async => Success<AutocompleteResult, ErrorResponse>(mockResult),
        );

        // Act
        final result = await searchUseCase.loadAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data, equals(mockResult));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify the correct parameters were passed
        final captured =
            verify(() => mockAutocompleteService.getAutocompleteResults(
                  captureAny(that: isA<AutocompleteQueryParameters>()),
                )).captured;

        final capturedParams = captured.first as AutocompleteQueryParameters;
        expect(capturedParams.query, equals(searchQuery));
        expect(capturedParams.categoryEnabled, isTrue);
        expect(capturedParams.brandEnabled, isTrue);
        expect(capturedParams.productEnabled, isTrue);
      });

      test('should return Failure when autocomplete service fails', () async {
        // Arrange
        const searchQuery = 'test query';
        final errorResponse = ErrorResponse(
          message: 'Autocomplete failed',
          errorDescription: 'Network error',
        );

        when(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).thenAnswer(
          (_) async =>
              Failure<AutocompleteResult, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.loadAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Failure<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Autocomplete failed'));
        }

        verify(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).called(1);
      });

      test('should handle empty search query', () async {
        // Arrange
        const searchQuery = '';
        final mockResult = MockAutocompleteResult();

        when(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).thenAnswer(
          (_) async => Success<AutocompleteResult, ErrorResponse>(mockResult),
        );

        // Act
        final result = await searchUseCase.loadAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());

        // Verify empty query was passed
        final captured =
            verify(() => mockAutocompleteService.getAutocompleteResults(
                  captureAny(that: isA<AutocompleteQueryParameters>()),
                )).captured;

        final capturedParams = captured.first as AutocompleteQueryParameters;
        expect(capturedParams.query, equals(''));
      });
    });

    group('loadVmiAutocompleteResults', () {
      test(
          'should return Success with converted products when service succeeds',
          () async {
        // Arrange
        const searchQuery = 'vmi query';
        const vmiLocationId = 'location123';

        final mockVmiLocationModel = MockVmiLocationModel();
        final mockProduct = MockProduct();
        final mockBrand = MockBrand();
        final mockVmiBinModel = MockVmiBinModel();
        final mockGetVmiBinResult = MockGetVmiBinResult();

        when(() => mockVmiLocationModel.id).thenReturn(vmiLocationId);
        when(() => mockVmiService.currentVmiLocation)
            .thenReturn(mockVmiLocationModel);

        // Mock product properties
        when(() => mockProduct.id).thenReturn('product123');
        when(() => mockProduct.shortDescription)
            .thenReturn('Short Description');
        when(() => mockProduct.pageTitle).thenReturn('Page Title');
        when(() => mockProduct.mediumImagePath).thenReturn('/image/path.jpg');
        when(() => mockProduct.name).thenReturn('Product Name');
        when(() => mockProduct.erpNumber).thenReturn('ERP123');
        when(() => mockProduct.brand).thenReturn(mockBrand);
        when(() => mockProduct.properties).thenReturn({'key': 'value'});
        when(() => mockBrand.name).thenReturn('Brand Name');
        when(() => mockBrand.logoSmallImagePath).thenReturn('/brand/logo.jpg');

        when(() => mockVmiBinModel.product).thenReturn(mockProduct);
        when(() => mockVmiBinModel.binNumber).thenReturn('BIN001');
        when(() => mockGetVmiBinResult.vmiBins).thenReturn([mockVmiBinModel]);

        when(() => mockVmiLocationsService.getVmiBins(
              parameters: any(named: 'parameters'),
            )).thenAnswer(
          (_) async =>
              Success<GetVmiBinResult, ErrorResponse>(mockGetVmiBinResult),
        );

        // Act
        final result =
            await searchUseCase.loadVmiAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data?.products, isNotNull);
            expect(data?.products!, hasLength(1));

            final product = data?.products!.first;
            expect(product?.id, equals('product123'));
            expect(product?.title, equals('Short Description'));
            expect(product?.subtitle, equals('Page Title'));
            expect(product?.image, equals('/image/path.jpg'));
            expect(product?.name, equals('Product Name'));
            expect(product?.erpNumber, equals('ERP123'));
            expect(product?.brandName, equals('Brand Name'));
            expect(product?.brandDetailPagePath, equals('/brand/logo.jpg'));
            expect(product?.binNumber, equals('BIN001'));
            expect(product?.properties, equals({'key': 'value'}));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify the correct parameters were passed
        final captured = verify(() => mockVmiLocationsService.getVmiBins(
              parameters: captureAny(named: 'parameters'),
            )).captured;

        final capturedParams = captured.first as VmiBinQueryParameters;
        expect(capturedParams.vmiLocationId, equals(vmiLocationId));
        expect(capturedParams.filter, equals(searchQuery));
        expect(capturedParams.expand, equals('product'));
      });

      test('should handle null currentVmiLocation', () async {
        // Arrange
        const searchQuery = 'vmi query';
        final mockGetVmiBinResult = MockGetVmiBinResult();

        when(() => mockVmiService.currentVmiLocation).thenReturn(null);
        when(() => mockGetVmiBinResult.vmiBins).thenReturn([]);

        when(() => mockVmiLocationsService.getVmiBins(
              parameters: any(named: 'parameters'),
            )).thenAnswer(
          (_) async =>
              Success<GetVmiBinResult, ErrorResponse>(mockGetVmiBinResult),
        );

        // Act
        final result =
            await searchUseCase.loadVmiAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());

        // Verify empty string was used for vmiLocationId
        final captured = verify(() => mockVmiLocationsService.getVmiBins(
              parameters: captureAny(named: 'parameters'),
            )).captured;

        final capturedParams = captured.first as VmiBinQueryParameters;
        expect(capturedParams.vmiLocationId, equals(''));
      });

      test('should handle empty vmiBins list', () async {
        // Arrange
        const searchQuery = 'vmi query';
        final mockVmiLocationModel = MockVmiLocationModel();
        final mockGetVmiBinResult = MockGetVmiBinResult();

        when(() => mockVmiLocationModel.id).thenReturn('location123');
        when(() => mockVmiService.currentVmiLocation)
            .thenReturn(mockVmiLocationModel);
        when(() => mockGetVmiBinResult.vmiBins).thenReturn([]);

        when(() => mockVmiLocationsService.getVmiBins(
              parameters: any(named: 'parameters'),
            )).thenAnswer(
          (_) async =>
              Success<GetVmiBinResult, ErrorResponse>(mockGetVmiBinResult),
        );

        // Act
        final result =
            await searchUseCase.loadVmiAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data?.products ?? [], isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle null vmiBins', () async {
        // Arrange
        const searchQuery = 'vmi query';
        final mockVmiLocationModel = MockVmiLocationModel();
        final mockGetVmiBinResult = MockGetVmiBinResult();

        when(() => mockVmiLocationModel.id).thenReturn('location123');
        when(() => mockVmiService.currentVmiLocation)
            .thenReturn(mockVmiLocationModel);
        when(() => mockGetVmiBinResult.vmiBins).thenReturn(<VmiBinModel>[]);

        when(() => mockVmiLocationsService.getVmiBins(
              parameters: any(named: 'parameters'),
            )).thenAnswer(
          (_) async =>
              Success<GetVmiBinResult, ErrorResponse>(mockGetVmiBinResult),
        );

        // Act
        final result =
            await searchUseCase.loadVmiAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Success<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data?.products ?? [], isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should return Failure when vmi service fails', () async {
        // Arrange
        const searchQuery = 'vmi query';
        final mockVmiLocationModel = MockVmiLocationModel();
        final errorResponse = ErrorResponse(
          message: 'VMI service failed',
          errorDescription: 'Service unavailable',
        );

        when(() => mockVmiLocationModel.id).thenReturn('location123');
        when(() => mockVmiService.currentVmiLocation)
            .thenReturn(mockVmiLocationModel);

        when(() => mockVmiLocationsService.getVmiBins(
              parameters: any(named: 'parameters'),
            )).thenAnswer(
          (_) async => Failure<GetVmiBinResult, ErrorResponse>(errorResponse),
        );

        // Act
        final result =
            await searchUseCase.loadVmiAutocompleteResults(searchQuery);

        // Assert
        expect(result, isA<Failure<AutocompleteResult, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('VMI service failed'));
        }
      });
    });

    group('loadSearchProductsResults', () {
      test('should return Success when product service succeeds', () async {
        // Arrange
        const searchQuery = 'search products';
        const currentPage = 1;
        final mockResult = MockGetProductCollectionResult();

        when(() => mockProductService.getProducts(
              any(that: isA<ProductsQueryParameters>()),
            )).thenAnswer(
          (_) async =>
              Success<GetProductCollectionResult, ErrorResponse>(mockResult),
        );

        // Act
        final result = await searchUseCase.loadSearchProductsResults(
          searchQuery,
          currentPage,
        );

        // Assert
        expect(
            result, isA<Success<GetProductCollectionResult, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data, equals(mockResult));
          case Failure():
            fail('Expected Success but got Failure');
          case null:
            fail('Expected Success but got null');
        }

        // Verify correct parameters
        final captured = verify(() => mockProductService.getProducts(
              captureAny(that: isA<ProductsQueryParameters>()),
            )).captured;

        final capturedParams = captured.first as ProductsQueryParameters;
        expect(capturedParams.query, equals(searchQuery));
        expect(capturedParams.page, equals(currentPage));
        expect(capturedParams.expand, contains('pricing'));
        expect(capturedParams.expand, contains('facets'));
        expect(capturedParams.expand, contains('brand'));
        expect(capturedParams.expand, contains('varianttraits'));
        expect(capturedParams.expand, contains('styledproducts'));
      });

      test('should pass all optional parameters correctly', () async {
        // Arrange
        const searchQuery = 'search products';
        const currentPage = 2;
        final selectedSortOrder = SortOrderAttribute(
          groupTitle: 'Price',
          title: 'Price Low to High',
          value: 'price_asc',
        );
        const selectedAttributeValueIds = ['attr1', 'attr2'];
        const selectedBrandIds = ['brand1', 'brand2'];
        const selectedProductLineIds = ['line1', 'line2'];
        const selectedCategoryId = 'category123';
        const previouslyPurchased = true;
        const selectedStockedItems = false;

        final mockResult = MockGetProductCollectionResult();

        when(() => mockProductService.getProducts(
              any(that: isA<ProductsQueryParameters>()),
            )).thenAnswer(
          (_) async =>
              Success<GetProductCollectionResult, ErrorResponse>(mockResult),
        );

        // Act
        final result = await searchUseCase.loadSearchProductsResults(
          searchQuery,
          currentPage,
          selectedSortOrder: selectedSortOrder,
          selectedAttributeValueIds: selectedAttributeValueIds,
          selectedBrandIds: selectedBrandIds,
          selectedProductLineIds: selectedProductLineIds,
          selectedCategoryId: selectedCategoryId,
          previouslyPurchased: previouslyPurchased,
          selectedStockedItems: selectedStockedItems,
        );

        // Assert
        expect(
            result, isA<Success<GetProductCollectionResult, ErrorResponse>>());

        // Verify all parameters were passed correctly
        final captured = verify(() => mockProductService.getProducts(
              captureAny(that: isA<ProductsQueryParameters>()),
            )).captured;

        final capturedParams = captured.first as ProductsQueryParameters;
        expect(capturedParams.query, equals(searchQuery));
        expect(capturedParams.page, equals(currentPage));
        expect(capturedParams.sort, equals(selectedSortOrder.value));
        expect(capturedParams.attributeValueIds,
            equals(selectedAttributeValueIds));
        expect(capturedParams.brandIds, equals(selectedBrandIds));
        expect(capturedParams.productLineIds, equals(selectedProductLineIds));
        expect(capturedParams.categoryId, equals(selectedCategoryId));
        expect(capturedParams.previouslyPurchasedProducts,
            equals(previouslyPurchased));
        expect(capturedParams.stockedItemsOnly, equals(selectedStockedItems));
      });

      test('should return Failure when product service fails', () async {
        // Arrange
        const searchQuery = 'search products';
        const currentPage = 1;
        final errorResponse = ErrorResponse(
          message: 'Product search failed',
          errorDescription: 'Database error',
        );

        when(() => mockProductService.getProducts(
              any(that: isA<ProductsQueryParameters>()),
            )).thenAnswer(
          (_) async =>
              Failure<GetProductCollectionResult, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.loadSearchProductsResults(
          searchQuery,
          currentPage,
        );

        // Assert
        expect(
            result, isA<Failure<GetProductCollectionResult, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Product search failed'));
          case null:
            fail('Expected Failure but got null');
        }
      });
    });

    group('getCategory', () {
      test('should return Success when category service succeeds', () async {
        // Arrange
        const categoryId = 'category123';
        final mockCategory = MockCategory();

        when(() => mockCategoryService.getCategory(categoryId)).thenAnswer(
          (_) async => Success<Category, ErrorResponse>(mockCategory),
        );

        // Act
        final result = await searchUseCase.getCategory(categoryId);

        // Assert
        expect(result, isA<Success<Category, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data, equals(mockCategory));
          case Failure():
            fail('Expected Success but got Failure');
        }

        verify(() => mockCategoryService.getCategory(categoryId)).called(1);
      });

      test('should return Failure when category service fails', () async {
        // Arrange
        const categoryId = 'category123';
        final errorResponse = ErrorResponse(
          message: 'Category not found',
          errorDescription: 'Invalid category ID',
        );

        when(() => mockCategoryService.getCategory(categoryId)).thenAnswer(
          (_) async => Failure<Category, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.getCategory(categoryId);

        // Assert
        expect(result, isA<Failure<Category, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Category not found'));
        }

        verify(() => mockCategoryService.getCategory(categoryId)).called(1);
      });
    });

    group('getCategoryList', () {
      test('should return Success when category service succeeds', () async {
        // Arrange
        final parameters = CategoryQueryParameters(
          startCategoryId: 'start123',
          maxDepth: 3,
        );
        final mockCategories = [MockCategory(), MockCategory()];

        when(() => mockCategoryService.getCategoryList(
              parameters: parameters,
            )).thenAnswer(
          (_) async => Success<List<Category>, ErrorResponse>(mockCategories),
        );

        // Act
        final result = await searchUseCase.getCategoryList(parameters);

        // Assert
        expect(result, isA<Success<List<Category>, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data, equals(mockCategories));
            expect(data, hasLength(2));
          case Failure():
            fail('Expected Success but got Failure');
        }

        verify(() => mockCategoryService.getCategoryList(
              parameters: parameters,
            )).called(1);
      });

      test('should return Failure when category service fails', () async {
        // Arrange
        final parameters = CategoryQueryParameters(
          startCategoryId: 'start123',
          maxDepth: 3,
        );
        final errorResponse = ErrorResponse(
          message: 'Categories not found',
          errorDescription: 'Database error',
        );

        when(() => mockCategoryService.getCategoryList(
              parameters: parameters,
            )).thenAnswer(
          (_) async => Failure<List<Category>, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.getCategoryList(parameters);

        // Assert
        expect(result, isA<Failure<List<Category>, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Categories not found'));
        }
      });
    });

    group('getBrand', () {
      test('should return Success when brand service succeeds', () async {
        // Arrange
        const brandId = 'brand123';
        final mockBrand = MockBrand();

        when(() => mockBrandService.getBrand(brandId)).thenAnswer(
          (_) async => Success<Brand, ErrorResponse>(mockBrand),
        );

        // Act
        final result = await searchUseCase.getBrand(brandId);

        // Assert
        expect(result, isA<Success<Brand, ErrorResponse>>());
        switch (result) {
          case Success(value: final data):
            expect(data, equals(mockBrand));
          case Failure():
            fail('Expected Success but got Failure');
        }

        verify(() => mockBrandService.getBrand(brandId)).called(1);
      });

      test('should return Failure when brand service fails', () async {
        // Arrange
        const brandId = 'brand123';
        final errorResponse = ErrorResponse(
          message: 'Brand not found',
          errorDescription: 'Invalid brand ID',
        );

        when(() => mockBrandService.getBrand(brandId)).thenAnswer(
          (_) async => Failure<Brand, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.getBrand(brandId);

        // Assert
        expect(result, isA<Failure<Brand, ErrorResponse>>());
        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Brand not found'));
        }

        verify(() => mockBrandService.getBrand(brandId)).called(1);
      });
    });

    group('getAvailableSortOrders', () {
      test('should return converted sort order attributes', () {
        // Arrange
        final sortOptions = [
          SortOption(displayName: 'Price Low to High', sortType: 'price_asc'),
          SortOption(displayName: 'Price High to Low', sortType: 'price_desc'),
        ];

        // Act
        final result = searchUseCase.getAvailableSortOrders(
          sortOptions: sortOptions,
        );

        // Assert
        expect(result, isA<List<SortOrderAttribute>>());
        expect(result, hasLength(2));
        expect(result[0].title, equals('Price Low to High'));
        expect(result[0].value, equals('price_asc'));
        expect(result[1].title, equals('Price High to Low'));
        expect(result[1].value, equals('price_desc'));
      });

      test('should handle empty sort options list', () {
        // Arrange
        final sortOptions = <SortOption>[];

        // Act
        final result = searchUseCase.getAvailableSortOrders(
          sortOptions: sortOptions,
        );

        // Assert
        expect(result, isA<List<SortOrderAttribute>>());
        expect(result, isEmpty);
      });
    });

    group('getSelectedSortOrder', () {
      test('should return correct selected sort order', () {
        // Arrange
        final availableSortOrders = [
          SortOrderAttribute(
              groupTitle: 'Price',
              title: 'Price Low to High',
              value: 'price_asc'),
          SortOrderAttribute(
              groupTitle: 'Price',
              title: 'Price High to Low',
              value: 'price_desc'),
          SortOrderAttribute(
              groupTitle: 'Name', title: 'Name A-Z', value: 'name_asc'),
        ];
        const selectedSortOrderType = 'price_desc';

        // Act
        final result = searchUseCase.getSelectedSortOrder(
          availableSortOrders: availableSortOrders,
          selectedSortOrderType: selectedSortOrderType,
        );

        // Assert
        expect(result, isA<SortOrderAttribute>());
        expect(result.title, equals('Price High to Low'));
        expect(result.value, equals('price_desc'));
      });
    });

    group('canAddToCartInProductList', () {
      test('should return true when mobile settings allow add to cart',
          () async {
        // Arrange
        final mockMobileSettings = MockMobileAppSettings();
        when(() => mockMobileSettings.addToCartInProductList).thenReturn(true);

        when(() => mockSettingsService.getMobileAppSettingAsync()).thenAnswer(
          (_) async =>
              Success<MobileAppSettings, ErrorResponse>(mockMobileSettings),
        );

        // Act
        final result = await searchUseCase.canAddToCartInProductList();

        // Assert
        expect(result, isTrue);
        verify(() => mockSettingsService.getMobileAppSettingAsync()).called(1);
      });

      test('should return false when mobile settings disable add to cart',
          () async {
        // Arrange
        final mockMobileSettings = MockMobileAppSettings();
        when(() => mockMobileSettings.addToCartInProductList).thenReturn(false);

        when(() => mockSettingsService.getMobileAppSettingAsync()).thenAnswer(
          (_) async =>
              Success<MobileAppSettings, ErrorResponse>(mockMobileSettings),
        );

        // Act
        final result = await searchUseCase.canAddToCartInProductList();

        // Assert
        expect(result, isFalse);
        verify(() => mockSettingsService.getMobileAppSettingAsync()).called(1);
      });

      test('should return false when mobile settings is null', () async {
        // Arrange
        when(() => mockSettingsService.getMobileAppSettingAsync()).thenAnswer(
          (_) async => const Success<MobileAppSettings, ErrorResponse>(null),
        );

        // Act
        final result = await searchUseCase.canAddToCartInProductList();

        // Assert
        expect(result, isFalse);
        verify(() => mockSettingsService.getMobileAppSettingAsync()).called(1);
      });

      test('should return false when addToCartInProductList is null', () async {
        // Arrange
        final mockMobileSettings = MockMobileAppSettings();
        when(() => mockMobileSettings.addToCartInProductList).thenReturn(null);

        when(() => mockSettingsService.getMobileAppSettingAsync()).thenAnswer(
          (_) async =>
              Success<MobileAppSettings, ErrorResponse>(mockMobileSettings),
        );

        // Act
        final result = await searchUseCase.canAddToCartInProductList();

        // Assert
        expect(result, isFalse);
        verify(() => mockSettingsService.getMobileAppSettingAsync()).called(1);
      });

      test('should return false when settings service fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(
          message: 'Settings failed',
          errorDescription: 'Service error',
        );

        when(() => mockSettingsService.getMobileAppSettingAsync()).thenAnswer(
          (_) async => Failure<MobileAppSettings, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await searchUseCase.canAddToCartInProductList();

        // Assert
        expect(result, isFalse);
        verify(() => mockSettingsService.getMobileAppSettingAsync()).called(1);
      });
    });

    group('Error handling and edge cases', () {
      test('should handle exceptions during loadAutocompleteResults gracefully',
          () async {
        // Arrange
        const searchQuery = 'test query';
        when(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () => searchUseCase.loadAutocompleteResults(searchQuery),
          throwsA(isA<Exception>()),
        );
      });

      test(
          'should handle exceptions during loadSearchProductsResults gracefully',
          () async {
        // Arrange
        const searchQuery = 'search products';
        const currentPage = 1;
        when(() => mockProductService.getProducts(
              any(that: isA<ProductsQueryParameters>()),
            )).thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () =>
              searchUseCase.loadSearchProductsResults(searchQuery, currentPage),
          throwsA(isA<Exception>()),
        );
      });

      test(
          'should handle exceptions during canAddToCartInProductList gracefully',
          () async {
        // Arrange
        when(() => mockSettingsService.getMobileAppSettingAsync())
            .thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () => searchUseCase.canAddToCartInProductList(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('Integration tests', () {
      test(
          'should maintain service provider consistency throughout multiple calls',
          () async {
        // Arrange
        const searchQuery = 'test';
        const categoryId = 'cat123';
        const brandId = 'brand123';

        final mockAutocompleteResult = MockAutocompleteResult();
        final mockCategory = MockCategory();
        final mockBrand = MockBrand();

        when(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).thenAnswer(
          (_) async => Success<AutocompleteResult, ErrorResponse>(
              mockAutocompleteResult),
        );
        when(() => mockCategoryService.getCategory(categoryId)).thenAnswer(
          (_) async => Success<Category, ErrorResponse>(mockCategory),
        );
        when(() => mockBrandService.getBrand(brandId)).thenAnswer(
          (_) async => Success<Brand, ErrorResponse>(mockBrand),
        );

        // Act - Multiple calls
        await searchUseCase.loadAutocompleteResults(searchQuery);
        await searchUseCase.getCategory(categoryId);
        await searchUseCase.getBrand(brandId);

        // Assert service provider consistency
        expect(searchUseCase.commerceAPIServiceProvider,
            equals(mockCommerceAPIServiceProvider));
        expect(
            searchUseCase.coreServiceProvider, equals(mockCoreServiceProvider));

        verify(() => mockAutocompleteService.getAutocompleteResults(
              any(that: isA<AutocompleteQueryParameters>()),
            )).called(1);
        verify(() => mockCategoryService.getCategory(categoryId)).called(1);
        verify(() => mockBrandService.getBrand(brandId)).called(1);
      });
    });
  });
}
