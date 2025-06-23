import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/content_management_usecase/cms_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCmsUseCase extends Mock implements CmsUseCase {}

class MockAccountService extends Mock implements IAccountService {}

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockDeviceService extends Mock implements IDeviceService {}

class MockContentConfigurationService extends Mock
    implements IContentConfigurationService {}

void main() {
  final sl = GetIt.instance;

  late AccountUseCase accountUseCase;
  late MockAccountService mockAccountService;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockDeviceService mockDeviceService;
  late MockContentConfigurationService mockContentConfigurationService;
  late MockSessionService mockSessionService;

  setUp(() {
    // Reset GetIt before each test
    sl.reset();

    // Create mock instances
    mockAccountService = MockAccountService();
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockDeviceService = MockDeviceService();
    mockContentConfigurationService = MockContentConfigurationService();
    mockSessionService = MockSessionService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getAccountService())
        .thenReturn(mockAccountService);
    when(() => mockCoreServiceProvider.getDeviceService())
        .thenReturn(mockDeviceService);
    when(() => mockCoreServiceProvider.getContentConfigurationService())
        .thenReturn(mockContentConfigurationService);
    when(() => mockCommerceAPIServiceProvider.getSessionService())
        .thenReturn(mockSessionService);

    // Mock account data
    when(() => mockAccountService.currentAccount).thenReturn(
      Account(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        userName: 'johndoe',
      ),
    );

    // Mock session data
    when(() => mockSessionService.getCurrentSession()).thenAnswer(
      (_) async => Success(Session(language: Language(id: 'en'))),
    );
    when(() => mockSessionService.getCachedCurrentSession()).thenReturn(
      Session(language: Language(id: 'en')),
    );

    // Mock device service data
    when(() => mockDeviceService.currentVersion).thenReturn('1.0.0+1');

    // Mock content configuration service
    when(() => mockContentConfigurationService
            .loadAndPersistLiveContentManagement(PageContentType.account))
        .thenAnswer(
      (_) async => Success<PageContentManagementEntity, ErrorResponse>(
        PageContentManagementEntity(),
      ),
    );

    // Initialize the use case
    accountUseCase = AccountUseCase();
  });

  tearDown(() {
    // Reset GetIt after each test
    sl.reset();
  });

  group('AccountUseCase Tests', () {
    test('loadData should return Success when CMS data is fetched successfully',
        () async {
      final mockCmsUseCase = MockCmsUseCase();

      // Mock the CMS data fetching
      when(() => mockCmsUseCase.getCMSData()).thenAnswer(
        (_) async => Success<List<WidgetEntity>, ErrorResponse>([]),
      );

      final result = await accountUseCase.loadData();

      // Assert that the result is a Success
      expect(result, isA<Success<List<WidgetEntity>, ErrorResponse>>());
    });

    test('firstName should return the correct value', () {
      expect(accountUseCase.firstName, equals('John'));
    });

    test('lastName should return the correct value', () {
      expect(accountUseCase.lastName, equals('Doe'));
    });

    test('email should return the correct value', () {
      expect(accountUseCase.email, equals('john.doe@example.com'));
    });

    test('userName should return the correct value', () {
      expect(accountUseCase.userName, equals('johndoe'));
    });

    test('getAppVersionAndBuildNumber should return the correct value', () {
      expect(accountUseCase.getAppVersionAndBuildNumber, equals('1.0.0+1'));
    });
  });
}
