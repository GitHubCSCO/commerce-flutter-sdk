import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_product_lines_usecase/brand_product_lines_usecase.dart';
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

  late BrandProductLinesUseCase useCase;
  late MockBrandService mockBrandService;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockTrackingService mockTrackingService;

  setUpAll(() async {
    await sl.reset();
    registerFallbackValue(ProductLinesQueryParameters(brandId: ''));
  });

  setUp(() async {
    await sl.reset();
    mockBrandService = MockBrandService();
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockTrackingService = MockTrackingService();
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);
    when(() => mockCommerceAPIServiceProvider.getBrandService())
        .thenReturn(mockBrandService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Stub the trackError method to return Future<void>
    when(() => mockTrackingService.trackError(
          any(),
          trace: any(named: 'trace'),
          reason: any(named: 'reason'),
        )).thenAnswer((_) async {});

    useCase = BrandProductLinesUseCase();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('BrandProductLinesUseCase', () {
    test('returns product lines on success', () async {
      final brand = Brand(id: 'b1');
      final productLines = [BrandProductLine(id: 'pl1', name: 'PL1')];
      final result = GetBrandProductLinesResult(productLines: productLines);
      when(() => mockBrandService.getBrandProductLines(any()))
          .thenAnswer((_) async => Success(result));

      final lines = await useCase.getBrandProductLines(brand);
      expect(lines, isNotNull);
      expect(lines?.length, 1);
      expect(lines?.first.id, 'pl1');
      verify(() => mockBrandService.getBrandProductLines(any())).called(1);
    });

    test('returns null if result is Failure', () async {
      final brand = Brand(id: 'b1');
      when(() => mockBrandService.getBrandProductLines(any()))
          .thenAnswer((_) async => Failure(ErrorResponse(message: 'error')));
      final lines = await useCase.getBrandProductLines(brand);
      expect(lines, isNull);
      verify(() => mockBrandService.getBrandProductLines(any())).called(1);
    });

    test('returns null if result is Success but value is null', () async {
      final brand = Brand(id: 'b1');
      when(() => mockBrandService.getBrandProductLines(any()))
          .thenAnswer((_) async => const Success(null));
      final lines = await useCase.getBrandProductLines(brand);
      expect(lines, isNull);
      verify(() => mockBrandService.getBrandProductLines(any())).called(1);
    });

    test('returns null if productLines is null in Success', () async {
      final brand = Brand(id: 'b1');
      final result = GetBrandProductLinesResult(productLines: null);
      when(() => mockBrandService.getBrandProductLines(any()))
          .thenAnswer((_) async => Success(result));
      final lines = await useCase.getBrandProductLines(brand);
      expect(lines, isNull);
      verify(() => mockBrandService.getBrandProductLines(any())).called(1);
    });
  });
}
