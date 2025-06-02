import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late WarehouseService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = WarehouseService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('getWarehouses', () {
    test('should return warehouses when successful', () async {
      // Arrange
      final expectedWarehouses = [
        Warehouse(id: 'WH1', name: 'Warehouse 1'),
        Warehouse(id: 'WH2', name: 'Warehouse 2'),
      ];
      final expectedResult =
          GetWarehouseCollectionResult(warehouses: expectedWarehouses);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any()))
          .thenAnswer((_) async => Success(Response(
                data: expectedResult.toJson(),
                requestOptions: RequestOptions(),
                statusCode: 200,
              )));

      // Act
      final result = await sut.getWarehouses();

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.warehouses, isNotEmpty);
          expect(value?.warehouses?.length, equals(2));
          verify(() => clientService.getAsync(any())).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut.getWarehouses();

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
      final result = await sut.getWarehouses();

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
