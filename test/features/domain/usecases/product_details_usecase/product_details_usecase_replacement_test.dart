import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockProductService extends Mock implements IProductService {}

class MockRealTimeInventoryService extends Mock
    implements IRealTimeInventoryService {}

class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakeProductQueryParameters extends Fake
    implements ProductQueryParameters {}

class FakeRealTimeInventoryParameters extends Fake
    implements RealTimeInventoryParameters {}

void main() {
  final sl = GetIt.instance;

  const originalProductId = 'original-product-id';
  const replacementProductId = 'replacement-product-id';

  late ProductDetailsUseCase useCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockProductService mockProductService;
  late MockRealTimeInventoryService mockRealTimeInventoryService;

  Product buildProduct(
    String id, {
    bool? isDiscontinued,
    bool? trackInventory,
    String? replacementId,
  }) {
    return Product(
      id: id,
      productTitle: id,
      isDiscontinued: isDiscontinued,
      trackInventory: trackInventory,
      detail: ProductDetail(replacementProductId: replacementId),
    );
  }

  void stubGetProduct(String id, Product product) {
    when(() => mockProductService.getProduct(id,
            parameters: any(named: 'parameters')))
        .thenAnswer((_) async => Success(GetProductResult(product: product)));
  }

  void stubInventory(String id, num? qtyOnHand) {
    when(() => mockRealTimeInventoryService.getProductRealTimeInventory(
            parameters: any(named: 'parameters')))
        .thenAnswer((_) async => Success(GetRealTimeInventoryResult(
              realTimeInventoryResults: [
                ProductInventory(productId: id, qtyOnHand: qtyOnHand),
              ],
            )));
  }

  setUpAll(() {
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakeProductQueryParameters());
    registerFallbackValue(FakeRealTimeInventoryParameters());
  });

  setUp(() async {
    await sl.reset();

    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockProductService = MockProductService();
    mockRealTimeInventoryService = MockRealTimeInventoryService();

    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    when(() => mockCommerceAPIServiceProvider.getProductService())
        .thenReturn(mockProductService);
    when(() => mockCommerceAPIServiceProvider.getRealTimeInventoryService())
        .thenReturn(mockRealTimeInventoryService);

    useCase = ProductDetailsUseCase();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('getProductDetails replacement-product redirect', () {
    test(
        'stays on a discontinued product that tracks inventory and has stock on hand',
        () async {
      // Precondition from the bug report: Discontinued=Yes, TrackInventory=Yes,
      // has a replacement, and stock remains -> must NOT redirect.
      stubGetProduct(
          originalProductId,
          buildProduct(originalProductId,
              isDiscontinued: true,
              trackInventory: true,
              replacementId: replacementProductId));
      stubInventory(originalProductId, 5);

      final result =
          await useCase.getProductDetails(originalProductId, null, null, null);

      expect(result, isA<Success<ProductEntity, ErrorResponse>>());
      expect((result as Success).value?.id, originalProductId);
      verifyNever(() => mockProductService.getProduct(replacementProductId,
          parameters: any(named: 'parameters')));
    });

    test(
        'redirects to replacement when discontinued, tracks inventory, and is out of stock',
        () async {
      stubGetProduct(
          originalProductId,
          buildProduct(originalProductId,
              isDiscontinued: true,
              trackInventory: true,
              replacementId: replacementProductId));
      stubGetProduct(replacementProductId, buildProduct(replacementProductId));
      stubInventory(originalProductId, 0);

      final result =
          await useCase.getProductDetails(originalProductId, null, null, null);

      expect((result as Success).value?.id, replacementProductId);
    });

    test(
        'redirects to replacement when discontinued and inventory is not tracked',
        () async {
      stubGetProduct(
          originalProductId,
          buildProduct(originalProductId,
              isDiscontinued: true,
              trackInventory: false,
              replacementId: replacementProductId));
      stubGetProduct(replacementProductId, buildProduct(replacementProductId));

      final result =
          await useCase.getProductDetails(originalProductId, null, null, null);

      expect((result as Success).value?.id, replacementProductId);
      // No inventory lookup is needed when inventory is not tracked.
      verifyNever(() => mockRealTimeInventoryService
          .getProductRealTimeInventory(parameters: any(named: 'parameters')));
    });

    test('stays on a product that is not discontinued', () async {
      stubGetProduct(
          originalProductId,
          buildProduct(originalProductId,
              isDiscontinued: false,
              trackInventory: true,
              replacementId: replacementProductId));

      final result =
          await useCase.getProductDetails(originalProductId, null, null, null);

      expect((result as Success).value?.id, originalProductId);
      verifyNever(() => mockProductService.getProduct(replacementProductId,
          parameters: any(named: 'parameters')));
    });
  });
}
