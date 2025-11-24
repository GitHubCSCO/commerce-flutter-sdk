import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockBrandService extends Mock implements IBrandService {}

class MockAutocompleteService extends Mock implements IAutocompleteService {}

void main() {
  final sl = GetIt.instance;

  late BrandUseCase brandUseCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockBrandService mockBrandService;
  late MockAutocompleteService mockAutocompleteService;
  late MockAppConfigurationService mockAppConfigurationService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    registerFallbackValue(BrandsQueryParameters());
    registerFallbackValue(BrandCategoriesQueryParameter());
    registerFallbackValue(ProductLinesQueryParameters());
    registerFallbackValue(BrandQueryParameters());
  });

  setUp(() async {
    await sl.reset();

    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockBrandService = MockBrandService();
    mockAutocompleteService = MockAutocompleteService();
    mockAppConfigurationService = MockAppConfigurationService();
    mockTrackingService = MockTrackingService();

    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    when(() => mockCommerceAPIServiceProvider.getBrandService())
        .thenReturn(mockBrandService);
    when(() => mockCommerceAPIServiceProvider.getAutocompleteService())
        .thenReturn(mockAutocompleteService);
    when(() => mockCoreServiceProvider.getAppConfigurationService())
        .thenReturn(mockAppConfigurationService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    brandUseCase = BrandUseCase();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('BrandUseCase Tests', () {
    test('getAlphabet returns success', () async {
      final expectedResult = BrandAlphabetResult(alphabet: []);
      when(() => mockBrandService.getAlphabetAsync())
          .thenAnswer((_) async => Success(expectedResult));

      final result = await brandUseCase.getAlphabet();

      expect(result, isA<Success<BrandAlphabetResult, ErrorResponse>>());
      verify(() => mockBrandService.getAlphabetAsync()).called(1);
    });
  });
}
