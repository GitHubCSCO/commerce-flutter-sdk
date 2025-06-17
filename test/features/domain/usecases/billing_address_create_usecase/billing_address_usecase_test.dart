import 'package:commerce_flutter_sdk/src/features/domain/usecases/billing_address_create_usecase/billing_address_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class FakeCountriesQueryParameters extends Fake
    implements CountriesQueryParameters {}

class FakeSession extends Fake implements Session {}

void main() {
  final sl = GetIt.instance;

  late BillingAddressUsecase billingAddressUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockWebsiteService mockWebsiteService;
  late MockSessionService mockSessionService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeCountriesQueryParameters());
    registerFallbackValue(FakeSession());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockWebsiteService = MockWebsiteService();
    mockSessionService = MockSessionService();
    mockTrackingService = MockTrackingService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getWebsiteService())
        .thenReturn(mockWebsiteService);
    when(() => mockCommerceAPIServiceProvider.getSessionService())
        .thenReturn(mockSessionService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Set up tracking service mock
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    // Initialize the use case
    billingAddressUsecase = BillingAddressUsecase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('BillingAddressUsecase Tests', () {
    group('getCountries', () {
      test('should return success when API call succeeds', () async {
        // Arrange
        final mockCountries = CountryCollection(
          countries: [
            Country(
              id: 'US',
              name: 'United States',
              abbreviation: 'US',
              states: [
                StateModel(
                  id: 'CA',
                  name: 'California',
                  abbreviation: 'CA',
                ),
                StateModel(
                  id: 'NY',
                  name: 'New York',
                  abbreviation: 'NY',
                ),
              ],
            ),
            Country(
              id: 'CA',
              name: 'Canada',
              abbreviation: 'CA',
              states: [
                StateModel(
                  id: 'ON',
                  name: 'Ontario',
                  abbreviation: 'ON',
                ),
              ],
            ),
          ],
        );

        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, hasLength(2));
            expect(countries.countries?.first.name, equals('United States'));
            expect(countries.countries?.first.states, hasLength(2));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify that the correct parameters were passed
        final captured = verify(() => mockWebsiteService.getCountries(
              parameters: captureAny(named: 'parameters'),
            )).captured.single as CountriesQueryParameters;

        expect(captured.expand, isNotNull);
        expect(captured.expand, contains('states'));
      });

      test('should return failure when API call fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(message: 'Network error');
        final failureResult =
            Failure<CountryCollection, ErrorResponse>(errorResponse);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => failureResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Failure<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Network error'));
        }

        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(1);
      });

      test('should always request countries with states expanded', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        await billingAddressUsecase.getCountries();

        // Assert
        final captured = verify(() => mockWebsiteService.getCountries(
              parameters: captureAny(named: 'parameters'),
            )).captured.single as CountriesQueryParameters;

        expect(captured.expand, isNotNull);
        expect(captured.expand, hasLength(1));
        expect(captured.expand, contains('states'));
      });

      test('should handle empty countries response', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle null countries collection', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: null);
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, isNull);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle exception during API call', () async {
        // Arrange
        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenThrow(Exception('Network error'));

        // Act & Assert
        expect(() => billingAddressUsecase.getCountries(), throwsException);

        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(1);
      });
    });

    group('getCurrentSession', () {
      test('should return success when session exists', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
          billTo: BillTo(isDefault: true),
          shipTo: ShipTo(isDefault: false),
        );
        final successResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(result, isA<Success<Session, ErrorResponse>>());

        switch (result) {
          case Success(value: final session):
            expect(session, isNotNull);
            expect(session!.userName, equals('testuser'));
            expect(session.isAuthenticated, isTrue);
          case Failure():
            fail('Expected Success but got Failure');
        }

        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should return failure when session service fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(message: 'Session not found');
        final failureResult = Failure<Session, ErrorResponse>(errorResponse);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => failureResult);

        // Act
        final result = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(result, isA<Failure<Session, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Session not found'));
        }

        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should handle null session response', () async {
        // Arrange
        final successResult = Success<Session, ErrorResponse>(null);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(result, isA<Success<Session, ErrorResponse>>());

        switch (result) {
          case Success(value: final session):
            expect(session, isNull);
          case Failure():
            fail('Expected Success but got Failure');
        }

        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should handle exception during session fetch', () async {
        // Arrange
        when(() => mockSessionService.getCurrentSession())
            .thenThrow(Exception('Session service error'));

        // Act & Assert
        expect(() => billingAddressUsecase.getCurrentSession(), throwsException);

        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should handle unauthenticated session', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: false,
          userName: null,
          billTo: null,
          shipTo: null,
        );
        final successResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(result, isA<Success<Session, ErrorResponse>>());

        switch (result) {
          case Success(value: final session):
            expect(session, isNotNull);
            expect(session!.isAuthenticated, isFalse);
            expect(session.userName, isNull);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });
    });

    group('integration tests', () {
      test('should handle complete workflow for billing address setup', () async {
        // Arrange
        final mockCountries = CountryCollection(
          countries: [
            Country(
              id: 'US',
              name: 'United States',
              abbreviation: 'US',
              states: [
                StateModel(id: 'CA', name: 'California', abbreviation: 'CA'),
              ],
            ),
          ],
        );
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
          billTo: BillTo(isDefault: true),
        );

        final countriesResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);
        final sessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => countriesResult);
        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => sessionResult);

        // Act
        final countriesResponse = await billingAddressUsecase.getCountries();
        final sessionResponse = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(countriesResponse, isA<Success<CountryCollection, ErrorResponse>>());
        expect(sessionResponse, isA<Success<Session, ErrorResponse>>());

        switch (countriesResponse) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, hasLength(1));
          case Failure():
            fail('Expected Success but got Failure');
        }

        switch (sessionResponse) {
          case Success(value: final session):
            expect(session, isNotNull);
            expect(session!.isAuthenticated, isTrue);
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify service calls
        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(1);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should handle mixed success and failure scenarios', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final countriesResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);
        final sessionError = ErrorResponse(message: 'Session expired');
        final sessionResult = Failure<Session, ErrorResponse>(sessionError);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => countriesResult);
        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => sessionResult);

        // Act
        final countriesResponse = await billingAddressUsecase.getCountries();
        final sessionResponse = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(countriesResponse, isA<Success<CountryCollection, ErrorResponse>>());
        expect(sessionResponse, isA<Failure<Session, ErrorResponse>>());

        switch (sessionResponse) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Session expired'));
        }
      });

      test('should handle multiple consecutive calls to the same methods', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final mockSession = Session(isAuthenticated: true);
        final countriesResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);
        final sessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => countriesResult);
        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => sessionResult);

        // Act
        final countries1 = await billingAddressUsecase.getCountries();
        final countries2 = await billingAddressUsecase.getCountries();
        final session1 = await billingAddressUsecase.getCurrentSession();
        final session2 = await billingAddressUsecase.getCurrentSession();

        // Assert
        expect(countries1, isA<Success<CountryCollection, ErrorResponse>>());
        expect(countries2, isA<Success<CountryCollection, ErrorResponse>>());
        expect(session1, isA<Success<Session, ErrorResponse>>());
        expect(session2, isA<Success<Session, ErrorResponse>>());

        // Verify service calls
        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(2);
        verify(() => mockSessionService.getCurrentSession()).called(2);
      });
    });

    group('edge cases', () {
      test('should handle rapid successive calls', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final mockSession = Session(isAuthenticated: true);
        final countriesResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);
        final sessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => countriesResult);
        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => sessionResult);

        // Act - Make multiple rapid calls
        final countriesFutures = List.generate(3, (index) => billingAddressUsecase.getCountries());
        final sessionFutures = List.generate(3, (index) => billingAddressUsecase.getCurrentSession());

        final countriesResults = await Future.wait(countriesFutures);
        final sessionResults = await Future.wait(sessionFutures);

        // Assert
        expect(countriesResults, everyElement(isA<Success<CountryCollection, ErrorResponse>>()));
        expect(sessionResults, everyElement(isA<Success<Session, ErrorResponse>>()));
        expect(countriesResults, hasLength(3));
        expect(sessionResults, hasLength(3));

        // Verify all calls were made
        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(3);
        verify(() => mockSessionService.getCurrentSession()).called(3);
      });

      test('should handle slow service responses', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final countriesResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 100));
          return countriesResult;
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await billingAddressUsecase.getCountries();
        stopwatch.stop();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));

        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(1);
      });

      test('should handle countries with empty states lists', () async {
        // Arrange
        final mockCountries = CountryCollection(
          countries: [
            Country(
              id: 'US',
              name: 'United States',
              abbreviation: 'US',
              states: [], // Empty states list
            ),
          ],
        );
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, hasLength(1));
            expect(countries.countries?.first.states, isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle countries with null states', () async {
        // Arrange
        final mockCountries = CountryCollection(
          countries: [
            Country(
              id: 'US',
              name: 'United States',
              abbreviation: 'US',
              states: null, // Null states
            ),
          ],
        );
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await billingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries, isNotNull);
            expect(countries!.countries, hasLength(1));
            expect(countries.countries?.first.states, isNull);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });
    });
  });
}
