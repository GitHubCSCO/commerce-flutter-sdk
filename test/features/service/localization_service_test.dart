import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/exceptions/language_exceptions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/localization_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

// Define proper mock classes
class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockSessionService extends Mock implements ISessionService {}

class MockTranslationService extends Mock implements ITranslationService {}

class MockCacheService extends Mock implements ICacheService {}

class MockTrackingService extends Mock implements ITrackingService {}

class MockSession extends Mock implements Session {}

class MockLanguage extends Mock implements Language {}

class MockTranslationResults extends Mock implements TranslationResults {}

// Create necessary mock data class
class MockTranslationDictionary implements TranslationDictionary {
  final String? _keyword;
  final String? _translation;

  MockTranslationDictionary({String? keyword, String? translation})
      : _keyword = keyword,
        _translation = translation;

  @override
  String? get keyword => _keyword;

  @override
  String? get translation => _translation;

  // Implement any other required methods/properties
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late LocalizationService localizationService;
  late MockCommerceAPIServiceProvider mockCommerceSP;
  late MockCoreServiceProvider mockCoreSP;
  late MockSessionService mockSessionService;
  late MockTranslationService mockTranslationService;
  late MockCacheService mockCacheService;
  late MockTrackingService mockTrackingService;
  late MockLanguage mockLanguage;

  setUp(() {
    registerFallbackValue(StackTrace.current);
    registerFallbackValue({});
    registerFallbackValue('');
    registerFallbackValue(<String, String>{});

    mockCommerceSP = MockCommerceAPIServiceProvider();
    mockCoreSP = MockCoreServiceProvider();
    mockSessionService = MockSessionService();
    mockTranslationService = MockTranslationService();
    mockCacheService = MockCacheService();
    mockTrackingService = MockTrackingService();
    mockLanguage = MockLanguage();

    // Set up common mock returns
    when(() => mockCommerceSP.getSessionService())
        .thenReturn(mockSessionService);
    when(() => mockCommerceSP.getTranslationService())
        .thenReturn(mockTranslationService);
    when(() => mockCommerceSP.getCacheService()).thenReturn(mockCacheService);
    when(() => mockCoreSP.getTrackingService()).thenReturn(mockTrackingService);
    when(() => mockTranslationService.getMaxLengthOfTranslationText())
        .thenReturn(1000);
    when(() => mockLanguage.languageCode).thenReturn('en-US');
    when(() => mockLanguage.id).thenReturn('1');
    when(() => mockLanguage.toJson())
        .thenReturn({'id': '1', 'languageCode': 'en-US'});

    // Set up mock methods that return Future<bool> to avoid null issues
    when(() => mockCacheService.persistData(
            "translation_dictionary", any<Map<String, String>>()))
        .thenAnswer((_) async => true);
    when(() => mockCacheService.persistData(any(), any()))
        .thenAnswer((_) async => true);
    when(() => mockCacheService.removePersistedData(any()))
        .thenAnswer((_) async => true);
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});
    when(() => mockCacheService.loadPersistedData<Map<String, String>>(any()))
        .thenAnswer((_) async => <String, String>{});

    localizationService = LocalizationService(
      commerceAPIServiceProvider: mockCommerceSP,
      coreServiceProvider: mockCoreSP,
    );
  });

  group('changeLanguage', () {
    test('returns failure when language is null', () async {
      // Act
      final result = await localizationService.changeLanguage(null);

      // Assert
      expect(result, isA<Failure<bool, ErrorResponse>>());

      if (result case Failure(errorResponse: final errorResponse)) {
        expect(errorResponse.exception, isA<ChangeLanguageException>());
      } else {
        fail('Expected Failure but got Success');
      }
    });

    test('successfully changes language', () async {
      // Arrange
      final mockSession = MockSession();
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Success(mockSession));

      // Mock successful translation fetch
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key', translation: 'Test Translation')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      when(() => mockSession.language).thenReturn(mockLanguage);
      when(() => mockSessionService.patchSession(mockSession))
          .thenAnswer((_) async => Success(mockSession));

      // Act
      final result = await localizationService.changeLanguage(mockLanguage);

      // Assert
      expect(result, isA<Success<bool, ErrorResponse>>());
      verify(() => mockSessionService.patchSession(mockSession)).called(1);
    });

    test('returns failure when session is null', () async {
      // Arrange
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => const Success(null));

      // Mock successful translation fetch
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key', translation: 'Test Translation')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      // Act
      final result = await localizationService.changeLanguage(mockLanguage);

      // Assert
      expect(result, isA<Failure<bool, ErrorResponse>>());

      if (result case Failure(errorResponse: final errorResponse)) {
        expect(errorResponse.exception, isA<ChangeLanguageException>());
      } else {
        fail('Expected Failure but got Success');
      }
    });

    test('returns failure when session patch fails', () async {
      // Arrange
      final mockSession = MockSession();
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Success(mockSession));

      // Mock successful translation fetch
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key', translation: 'Test Translation')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      final errorResponse = ErrorResponse(message: 'Patch failed');
      when(() => mockSessionService.patchSession(mockSession))
          .thenAnswer((_) async => Failure(errorResponse));

      // Act
      final result = await localizationService.changeLanguage(mockLanguage);

      // Assert
      expect(result, isA<Failure<bool, ErrorResponse>>());

      if (result case Failure(errorResponse: final error)) {
        expect(error.message, 'Patch failed');
      } else {
        fail('Expected Failure but got Success');
      }
    });
  });

  group('loadCurrentLanguage', () {
    test('successfully loads current language', () async {
      // Arrange
      final mockSession = MockSession();
      when(() => mockSession.language).thenReturn(mockLanguage);
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Success(mockSession));

      // Mock successful translation fetch
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key', translation: 'Test Translation')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      // Act
      final result = await localizationService.loadCurrentLanguage();

      // Assert
      expect(result, isA<Success<bool, ErrorResponse>>());
      expect(localizationService.getCurrentLanguage(), mockLanguage);
    });

    test('returns failure when session cannot be loaded', () async {
      // Arrange
      final errorResponse = ErrorResponse(message: 'Session load failed');
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Failure(errorResponse));

      // Act
      final result = await localizationService.loadCurrentLanguage();

      // Assert
      expect(result, isA<Failure<bool, ErrorResponse>>());
    });

    test('loads persisted dictionary when translation fetch fails', () async {
      // Arrange
      final mockSession = MockSession();
      when(() => mockSession.language).thenReturn(mockLanguage);
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Success(mockSession));

      // Mock failed translation fetch
      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async =>
              Failure(ErrorResponse(message: 'Translation fetch failed')));

      // Mock successful persisted data retrieval
      final persistedData = {'saved_key': 'Saved Value'};
      when(() => mockCacheService.loadPersistedData<Map<String, String>>(any()))
          .thenAnswer((_) async => persistedData);

      // Act
      final result = await localizationService.loadCurrentLanguage();

      // Assert
      expect(result, isA<Success<bool, ErrorResponse>>());
      expect(localizationService.translationDictionary, persistedData);
    });
  });

  group('removeCurrentLanguage', () {
    test('successfully removes language and dictionary', () async {
      // Arrange
      final mockSession = MockSession();
      when(() => mockSession.language).thenReturn(mockLanguage);
      when(() => mockSessionService.getCurrentSession())
          .thenAnswer((_) async => Success(mockSession));

      // First load a language
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key', translation: 'Test Translation')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      await localizationService.loadCurrentLanguage();
      expect(localizationService.getCurrentLanguage(), isNotNull);

      // Act
      await localizationService.removeCurrentLanguage();

      // Assert
      expect(localizationService.getCurrentLanguage(), isNull);
      expect(localizationService.translationDictionary, isEmpty);
      verify(() => mockCacheService.removePersistedData(any())).called(1);
    });
  });

  group('fetchTranslations', () {
    test('successfully fetches and stores translations', () async {
      // Arrange
      final mockResults = MockTranslationResults();
      final translationDictionaries = <TranslationDictionary>[
        MockTranslationDictionary(
            keyword: 'test_key1', translation: 'Test Translation 1'),
        MockTranslationDictionary(
            keyword: 'test_key2', translation: 'Test Translation 2')
      ];
      when(() => mockResults.translationDictionaries)
          .thenReturn(translationDictionaries);

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResults));

      // Act
      final result = await localizationService.fetchTranslations(
          mockLanguage, 'test_key1,test_key2', 2);

      // Assert
      expect(result, isTrue);
      expect(localizationService.translationDictionary?['test_key1'],
          'Test Translation 1');
      expect(localizationService.translationDictionary?['test_key2'],
          'Test Translation 2');
    });

    test('handles null translation list', () async {
      // Arrange
      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => const Success(null));

      // Act
      final result = await localizationService.fetchTranslations(
          mockLanguage, 'test_key', 1);

      // Assert
      expect(result, isFalse);
      verify(() => mockTrackingService.trackError(any(),
          trace: any(named: 'trace'), reason: any(named: 'reason'))).called(1);
    });

    test('handles translation service failure', () async {
      // Arrange
      final errorResponse =
          ErrorResponse(message: 'Translation service failed');

      when(() => mockTranslationService.getTranslations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Failure(errorResponse));

      // Act
      final result = await localizationService.fetchTranslations(
          mockLanguage, 'test_key', 1);

      // Assert
      expect(result, isFalse);
      verify(() => mockTrackingService.trackError(errorResponse,
          trace: any(named: 'trace'), reason: any(named: 'reason'))).called(1);
    });
  });
}
