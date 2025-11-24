import 'package:commerce_flutter_sdk/src/features/domain/usecases/add_shipping_address_usecase/add_shipping_address_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

void main() {
  final sl = GetIt.instance;

  late AddShippingAddressUsecase addShippingAddressUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockWebsiteService mockWebsiteService;

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockWebsiteService = MockWebsiteService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getWebsiteService())
        .thenReturn(mockWebsiteService);

    // Initialize the use case
    addShippingAddressUsecase = AddShippingAddressUsecase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('AddShippingAddressUsecase Tests', () {
    group('getCountries', () {
      test('should return Success when countries are fetched successfully',
          () async {
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
        final result = await addShippingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries?.countries, hasLength(2));
            expect(countries?.countries?.first.name, equals('United States'));
            expect(countries?.countries?.first.states, hasLength(2));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify that the correct parameters were passed
        verify(() => mockWebsiteService.getCountries(
              parameters: any(
                named: 'parameters',
                that: isA<CountriesQueryParameters>().having(
                  (p) => p.expand?.contains('states'),
                  'expand contains states',
                  isTrue,
                ),
              ),
            )).called(1);
      });

      test('should return Failure when API call fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(
          message: 'Failed to fetch countries',
        );

        final errorResult =
            Failure<CountryCollection, ErrorResponse>(errorResponse);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => errorResult);

        // Act
        final result = await addShippingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Failure<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Failed to fetch countries'));
        }

        // Verify that the API was called
        verify(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).called(1);
      });

      test('should pass correct parameters to getCountries', () async {
        // Arrange
        final mockCountries = CountryCollection(countries: []);
        final successResult =
            Success<CountryCollection, ErrorResponse>(mockCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        await addShippingAddressUsecase.getCountries();

        // Assert
        final captured = verify(() => mockWebsiteService.getCountries(
              parameters: captureAny(named: 'parameters'),
            )).captured;

        expect(captured, hasLength(1));
        final parameters = captured.first as CountriesQueryParameters;
        expect(parameters.expand, contains('states'));
      });

      test('should handle empty countries list', () async {
        // Arrange
        final emptyCountries = CountryCollection(countries: []);
        final successResult =
            Success<CountryCollection, ErrorResponse>(emptyCountries);

        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async => successResult);

        // Act
        final result = await addShippingAddressUsecase.getCountries();

        // Assert
        expect(result, isA<Success<CountryCollection, ErrorResponse>>());

        switch (result) {
          case Success(value: final countries):
            expect(countries?.countries, isEmpty);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle network timeout exception', () async {
        // Arrange
        when(() => mockWebsiteService.getCountries(
              parameters: any(named: 'parameters'),
            )).thenThrow(Exception('Network timeout'));

        // Act & Assert
        expect(
          () => addShippingAddressUsecase.getCountries(),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
