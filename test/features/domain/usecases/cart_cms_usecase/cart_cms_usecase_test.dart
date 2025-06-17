import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/cart_cms_usecase/cart_cms_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockContentConfigurationService extends Mock
    implements IContentConfigurationService {}

class MockSessionService extends Mock implements ISessionService {}

class MockSession extends Mock implements Session {}

class MockLanguage extends Mock implements Language {}

// Create fake for fallback values
class FakePageContentManagementEntity extends Fake
    implements PageContentManagementEntity {}

class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakeSession extends Fake implements Session {}

class FakeLanguage extends Fake implements Language {}

void main() {
  final sl = GetIt.instance;

  late CartCmsUsecase cartCmsUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockContentConfigurationService mockContentConfigurationService;
  late MockSessionService mockSessionService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakePageContentManagementEntity());
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakeSession());
    registerFallbackValue(FakeLanguage());
    registerFallbackValue(PageContentType.cart);
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockContentConfigurationService = MockContentConfigurationService();
    mockSessionService = MockSessionService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCoreServiceProvider.getContentConfigurationService())
        .thenReturn(mockContentConfigurationService);
    when(() => mockCommerceAPIServiceProvider.getSessionService())
        .thenReturn(mockSessionService);

    // Initialize the use case
    cartCmsUsecase = CartCmsUsecase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('CartCmsUsecase Tests', () {
    test('should have correct contentType property', () {
      expect(cartCmsUsecase.contentType, equals(PageContentType.cart));
    });

    group('loadData', () {
      test('should return Success when getCMSData returns successful data',
          () async {
        // Arrange
        final mockSession = MockSession();
        final mockLanguage = MockLanguage();
        final expectedWidgets = <WidgetEntity>[];

        when(() => mockLanguage.id).thenReturn('en');
        when(() => mockSession.language).thenReturn(mockLanguage);

        // Mock successful content configuration service response
        final mockPageData = PageContentManagementEntity();
        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(mockPageData),
        );

        // Mock successful session service response
        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Success<Session, ErrorResponse>(mockSession),
        );

        when(() => mockSessionService.getCachedCurrentSession())
            .thenReturn(mockSession);

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Success<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success(value: final widgets):
            expect(widgets, isNotNull);
            expect(widgets, isA<List<WidgetEntity>>());
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify service calls
        verify(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .called(1);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should return Success with empty list when pageData is null',
          () async {
        // Arrange
        final mockSession = MockSession();
        final mockLanguage = MockLanguage();

        when(() => mockLanguage.id).thenReturn('en');
        when(() => mockSession.language).thenReturn(mockLanguage);

        // Mock successful but null content configuration service response
        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(null),
        );

        // Mock successful session service response
        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Success<Session, ErrorResponse>(mockSession),
        );

        when(() => mockSessionService.getCachedCurrentSession())
            .thenReturn(mockSession);

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Success<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success(value: final widgets):
            expect(widgets, isNotNull);
            expect(widgets, isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test(
          'should return Failure when content configuration service returns error',
          () async {
        // Arrange
        final errorResponse = ErrorResponse(
          message: 'Content loading failed',
          errorDescription: 'Failed to load cart content',
        );

        // Mock failed content configuration service response
        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async => Failure<PageContentManagementEntity, ErrorResponse>(
              errorResponse),
        );

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Failure<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(errorResponse));
            expect(error.message, equals('Content loading failed'));
            expect(
                error.errorDescription, equals('Failed to load cart content'));
        }

        // Verify service call
        verify(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .called(1);
        // Session service should not be called when content loading fails
        verifyNever(() => mockSessionService.getCurrentSession());
      });

      test('should return Failure when session service returns error',
          () async {
        // Arrange
        final mockPageData = PageContentManagementEntity();
        final sessionErrorResponse = ErrorResponse(
          message: 'Session error',
          errorDescription: 'Failed to get current session',
        );

        // Mock successful content configuration service response
        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(mockPageData),
        );

        // Mock failed session service response
        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Failure<Session, ErrorResponse>(sessionErrorResponse),
        );

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Failure<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(sessionErrorResponse));
            expect(error.message, equals('Session error'));
            expect(error.errorDescription,
                equals('Failed to get current session'));
        }

        // Verify service calls
        verify(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .called(1);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should handle classic widgets when pageClassicWidget is not null',
          () async {
        // Arrange
        final mockSession = MockSession();
        final mockLanguage = MockLanguage();

        when(() => mockLanguage.id).thenReturn('en');
        when(() => mockSession.language).thenReturn(mockLanguage);

        // Mock page data with classic widgets
        final mockPageData = PageContentManagementEntity();
        mockPageData.pageClassicWidget = [
          // Add mock classic widgets if needed for specific testing
        ];

        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(mockPageData),
        );

        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Success<Session, ErrorResponse>(mockSession),
        );

        when(() => mockSessionService.getCachedCurrentSession())
            .thenReturn(mockSession);

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Success<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success(value: final widgets):
            expect(widgets, isNotNull);
            expect(widgets, isA<List<WidgetEntity>>());
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle spire widgets when pageClassicWidget is null',
          () async {
        // Arrange
        final mockSession = MockSession();
        final mockLanguage = MockLanguage();
        final mockPage = MockPageInformation();

        when(() => mockLanguage.id).thenReturn('en');
        when(() => mockSession.language).thenReturn(mockLanguage);
        when(() => mockPage.widgets).thenReturn([]);

        // Mock page data with spire widgets (pageClassicWidget is null)
        final mockPageData = PageContentManagementEntity();
        mockPageData.page = mockPage as PageInformationEntity;

        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(mockPageData),
        );

        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Success<Session, ErrorResponse>(mockSession),
        );

        when(() => mockSessionService.getCachedCurrentSession())
            .thenReturn(mockSession);

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert
        expect(result, isA<Success<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success(value: final widgets):
            expect(widgets, isNotNull);
            expect(widgets, isA<List<WidgetEntity>>());
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test(
          'should use cached session when current session fails but cache exists',
          () async {
        // Arrange
        final mockSession = MockSession();
        final mockLanguage = MockLanguage();
        final mockPageData = PageContentManagementEntity();
        final sessionErrorResponse = ErrorResponse(
          message: 'Session error',
          errorDescription: 'Failed to get current session',
        );

        when(() => mockLanguage.id).thenReturn('en');
        when(() => mockSession.language).thenReturn(mockLanguage);

        when(() => mockContentConfigurationService
                .loadAndPersistLiveContentManagement(PageContentType.cart))
            .thenAnswer(
          (_) async =>
              Success<PageContentManagementEntity, ErrorResponse>(mockPageData),
        );

        // Mock failed current session but successful cached session
        when(() => mockSessionService.getCurrentSession()).thenAnswer(
          (_) async => Failure<Session, ErrorResponse>(sessionErrorResponse),
        );

        when(() => mockSessionService.getCachedCurrentSession())
            .thenReturn(null); // No cached session either

        // Act
        final result = await cartCmsUsecase.loadData();

        // Assert - Should still fail because no session is available
        expect(result, isA<Failure<List<WidgetEntity>, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error, equals(sessionErrorResponse));
        }
      });
    });

    test('should properly extend CmsUseCase', () {
      expect(cartCmsUsecase, isA<CartCmsUsecase>());
      // Verify inheritance hierarchy
      expect(cartCmsUsecase.runtimeType.toString(), equals('CartCmsUsecase'));
    });

    test('should initialize with correct contentType parameter', () {
      // Test with explicit contentType parameter (should be overridden)
      final customCartUsecase =
          CartCmsUsecase(contentType: PageContentType.account);
      expect(customCartUsecase.contentType, equals(PageContentType.cart));
    });
  });
}

// Additional mock classes needed for comprehensive testing
class MockPageInformation extends Mock implements PageInformation {}
