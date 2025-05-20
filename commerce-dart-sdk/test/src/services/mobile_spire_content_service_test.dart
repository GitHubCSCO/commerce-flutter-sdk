import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late MobileSpireContentService mobileSpireContentService;
  late MockClientService clientService;
  late MockCacheService cacheService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    cacheService = MockCacheService();
    networkService = MockNetworkService();

    mobileSpireContentService = MobileSpireContentService(
      clientService: clientService,
      cacheService: cacheService,
      networkService: networkService,
    );

    registerFallbackValue(Uri());
  });

  group('MobileSpireContentService', () {
    const pageName = 'home';
    const mockPageContentJson = {
      'page': {
        'nodeId': '123',
        'name': 'Home Page',
      },
      'statusCode': 200,
      'redirectTo': null,
      'authorizationFailed': false,
    };

    test('getPageContenManagmentSpire returns PageContentManagement on success',
        () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(Response(
            data: mockPageContentJson, requestOptions: RequestOptions())),
      );

      // Act
      final result =
          await mobileSpireContentService.getPageContenManagmentSpire(pageName);

      // Assert
      expect(result, isA<Success>());
      final success = result as Success;
      expect(success.value.page?.name, 'Home Page');
      verify(() => clientService.getAsync(any())).called(1);
    });

    test('getPageContenManagmentSpire fails if pageName is empty', () async {
      // Act
      final result =
          await mobileSpireContentService.getPageContenManagmentSpire('');

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.message, 'pageName is required');
    });

    test('getPageContenManagmentSpire handles network failure gracefully',
        () async {
      // Arrange
      final requestOptions = RequestOptions(path: '/api/page');
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(ErrorResponse(
          error: "Connection timeout",
          exception: DioException(
            requestOptions: requestOptions,
            type: DioExceptionType.connectionTimeout,
          ),
        )),
      );

      // Act
      final result =
          await mobileSpireContentService.getPageContenManagmentSpire(pageName);

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.error, contains('Connection timeout'));
      verify(() => clientService.getAsync(any())).called(1);
    });
  });
}
