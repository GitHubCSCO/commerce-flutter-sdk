import 'dart:convert';
import 'dart:typed_data';

import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/content_configuration_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

// Mock dependencies
class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockMobileSpireContentService extends Mock
    implements IMobileSpireContentService {}

class MockMobileContentService extends Mock implements IMobileContentService {}

class MockCacheService extends Mock implements ICacheService {}

class MockPageContentManagement extends Mock implements PageContentManagement {}

class MockPageInformation extends Mock implements PageInformation {}

// Create fake for fallback values
class FakePageContentManagement extends Fake implements PageContentManagement {}

class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakePageContentManagementEntity extends Fake
    implements PageContentManagementEntity {}

class FakePageInformation extends Fake implements PageInformation {}

void main() {
  late ContentConfigurationService service;
  late MockCommerceAPIServiceProvider mockProvider;
  late MockMobileSpireContentService mockSpireService;
  late MockMobileContentService mockContentService;
  late MockCacheService mockCacheService;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(FakePageContentManagement());
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakePageContentManagementEntity());
    registerFallbackValue(FakePageInformation());
    registerFallbackValue('');
    registerFallbackValue(<int>[]);
    registerFallbackValue(Uint8List(0)); // Register fallback for Uint8List
  });

  setUp(() {
    mockProvider = MockCommerceAPIServiceProvider();
    mockSpireService = MockMobileSpireContentService();
    mockContentService = MockMobileContentService();
    mockCacheService = MockCacheService();

    // Setup default behavior for the provider
    when(() => mockProvider.getMobileSpireContentService())
        .thenReturn(mockSpireService);
    when(() => mockProvider.getMobileContentService())
        .thenReturn(mockContentService);
    when(() => mockProvider.getCacheService()).thenReturn(mockCacheService);

    service =
        ContentConfigurationService(commerceAPIServiceProvider: mockProvider);
  });

  group('ContentConfigurationService', () {
    test('getPageKeyForContentType returns correct keys', () {
      expect(service.getPageKeyForContentType(PageContentType.shop),
          equals('shop'));
      expect(service.getPageKeyForContentType(PageContentType.searchLanding),
          equals('search'));
      expect(service.getPageKeyForContentType(PageContentType.account),
          equals('account'));
      expect(service.getPageKeyForContentType(PageContentType.vmiMain),
          equals('vmimain'));
      expect(service.getPageKeyForContentType(PageContentType.cart),
          equals('mobileCart'));
    });

    test('getPersistenceKeyForContentType returns correct keys', () {
      expect(service.getPersistenceKeyForContentType(PageContentType.shop),
          equals('ShopContentManagementPersistenceKey'));
      expect(
          service
              .getPersistenceKeyForContentType(PageContentType.searchLanding),
          equals('SearchLandingContentManagementPersistenceKey'));
      expect(service.getPersistenceKeyForContentType(PageContentType.cart),
          equals('mobileCartContentManagementPersistenceKey'));
    });

    test('loadAndPersistLiveContentManagement calls spire service first',
        () async {
      // Arrange
      final pageInfo = PageInformation()..name = 'shop';

      final mockResponse = PageContentManagement()
        ..page = pageInfo
        ..statusCode = 200;

      when(() => mockSpireService.getPageContenManagmentSpire('shop'))
          .thenAnswer((_) async => Success(mockResponse));

      when(() => mockCacheService.persistBytesData(
              'ShopContentManagementPersistenceKey', any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await service
          .loadAndPersistLiveContentManagement(PageContentType.shop);

      // Assert
      verify(() => mockSpireService.getPageContenManagmentSpire('shop'))
          .called(1);
      verify(() => mockCacheService.persistBytesData(
          'ShopContentManagementPersistenceKey', any())).called(1);
      expect(
          result, isA<Success<PageContentManagementEntity, ErrorResponse>>());
    });

    test(
        'loadAndPersistLiveContentManagement falls back to classic service if spire fails',
        () async {
      // Arrange
      final mockSpireResponse = PageContentManagement()..statusCode = 404;

      final pageInfo = PageInformation()..name = 'shop';

      final mockClassicResponse = PageContentManagement()..page = pageInfo;

      when(() => mockSpireService.getPageContenManagmentSpire('shop'))
          .thenAnswer((_) async => Success(mockSpireResponse));

      when(() => mockContentService.getPageContentManagementClassic('shop'))
          .thenAnswer((_) async => Success(mockClassicResponse));

      when(() => mockCacheService.persistBytesData(
              'ShopContentManagementPersistenceKey', any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await service
          .loadAndPersistLiveContentManagement(PageContentType.shop);

      // Assert
      verify(() => mockSpireService.getPageContenManagmentSpire('shop'))
          .called(1);
      verify(() => mockContentService.getPageContentManagementClassic('shop'))
          .called(1);
      expect(
          result, isA<Success<PageContentManagementEntity, ErrorResponse>>());
    });

    test('getPersistedLiveContentManagement loads from cache', () async {
      // Arrange
      final mockJson =
          '{"page": {"name": "shop", "type": "page"}, "statusCode": 200}';
      final mockBytes = Uint8List.fromList(utf8.encode(mockJson));

      when(() => mockCacheService
              .loadPersistedBytesData('ShopContentManagementPersistenceKey'))
          .thenAnswer((_) async => mockBytes);

      // Act
      final result =
          await service.getPersistedLiveContentManagement(PageContentType.shop);

      // Assert
      verify(() => mockCacheService.loadPersistedBytesData(
          'ShopContentManagementPersistenceKey')).called(1);
      expect(result.page?.name, equals('shop'));
      expect(result.statusCode, equals(200));
    });

    test('persistContentManagementData correctly persists data', () {
      // Arrange
      final pageInfo = PageInformation()..name = 'shop';

      final mockData = PageContentManagement()
        ..page = pageInfo
        ..statusCode = 200;

      when(() => mockCacheService.persistBytesData(
              'ShopContentManagementPersistenceKey', any()))
          .thenAnswer((_) async => true);

      // Act
      service.persistContentManagementData(mockData, PageContentType.shop);

      // Assert
      verify(() => mockCacheService.persistBytesData(
          'ShopContentManagementPersistenceKey', any())).called(1);
    });
  });
}
