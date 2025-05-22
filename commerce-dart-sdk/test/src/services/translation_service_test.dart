import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late TranslationService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = TranslationService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('getMaxLengthOfTranslationText', () {
    test('should return correct max length of translation text', () {
      // Act
      final result = sut.getMaxLengthOfTranslationText();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<int>());
    });
  });

  group('getTranslations', () {
    test('should return translations when successful', () async {
      // Arrange
      final expectedTranslations = TranslationResults(translationDictionaries: [
        TranslationDictionary(
          keyword: 'hello',
          source: 'Hello',
          translation: 'Hola',
          languageId: '1',
          languageCode: 'es',
        ),
        TranslationDictionary(
          keyword: 'world',
          source: 'World',
          translation: 'Mundo',
          languageId: '1',
          languageCode: 'es',
        ),
        TranslationDictionary(
          keyword: 'hello',
          source: 'Hello',
          translation: 'Hello',
          languageId: '2',
          languageCode: 'en',
        ),
        TranslationDictionary(
          keyword: 'world',
          source: 'World',
          translation: 'World',
          languageId: '2',
          languageCode: 'en',
        ),
      ]);

      when(() => networkService.isOnline()).thenAnswer((_) async => true);

      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: expectedTranslations.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await sut.getTranslations();

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value, isNotNull);
          expect(value?.translationDictionaries, isNotEmpty);
          verify(() => clientService.getAsync(any())).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut.getTranslations();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('No internet found'));
          verifyNever(() => clientService.getAsync(any()));
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await sut.getTranslations();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('Some error'));
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.getAsync(any())).called(1);
      }
    });
  });
}
