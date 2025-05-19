import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../../mocks/mocks.dart';

void main() {
  late MockClientService mockClientService;
  late MockCacheService mockCacheService;
  late MockNetworkService mockNetworkService;
  late AutoCompleteService autoCompleteService;

  setUp(() {
    mockClientService = MockClientService();
    mockCacheService = MockCacheService();
    mockNetworkService = MockNetworkService();

    autoCompleteService = AutoCompleteService(
      clientService: mockClientService,
      cacheService: mockCacheService,
      networkService: mockNetworkService,
    );
  });

  group('AutoCompleteService - getAutocompleteBrands', () {
    test('returns Success with brands when response is valid', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));

      when(() => mockClientService.getAsync(any())).thenAnswer((_) async =>
          Success(Response(
              data: {'brands': []}, requestOptions: RequestOptions())));

      final result = await autoCompleteService.getAutocompleteBrands('query');

      expect(result, isA<Success>());
      expect((result as Success).value, isA<List<AutocompleteBrand>>());
    });

    test('returns Failure when clientService fails', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));

      when(() => mockClientService.getAsync(any())).thenAnswer(
        (_) async => Failure(
          ErrorResponse(error: 'Error', message: 'Failed to fetch brands'),
        ),
      );

      final result = await autoCompleteService.getAutocompleteBrands('query');

      expect(result, isA<Failure>());
      expect(
          (result as Failure).errorResponse.message, 'Failed to fetch brands');
    });
  });

  group('AutoCompleteService - getAutocompleteProducts', () {
    test('returns Success with products when response is valid', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));

      when(() => mockClientService.getAsync(any())).thenAnswer((_) async =>
          Success(Response(
              data: {'products': []}, requestOptions: RequestOptions())));

      final result = await autoCompleteService.getAutocompleteProducts('query');

      expect(result, isA<Success>());
      expect((result as Success).value, isA<List<AutocompleteProduct>>());
    });

    test('returns Failure when clientService fails', () async {
      when(mockNetworkService.isOnline).thenAnswer((_) => Future.value(true));

      when(() => mockClientService.getAsync(any())).thenAnswer(
        (_) async => Failure(
          ErrorResponse(error: 'Error', message: 'Failed to fetch products'),
        ),
      );

      final result = await autoCompleteService.getAutocompleteProducts('query');

      expect(result, isA<Failure>());
      expect((result as Failure).errorResponse.message,
          'Failed to fetch products');
    });
  });
}
