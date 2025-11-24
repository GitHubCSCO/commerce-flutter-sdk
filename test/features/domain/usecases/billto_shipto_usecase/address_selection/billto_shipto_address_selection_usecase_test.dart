import 'package:commerce_flutter_sdk/src/features/domain/usecases/billto_shipto_usecase/address_selection/billto_shipto_address_selection_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class FakeBillTosQueryParameters extends Fake
    implements BillTosQueryParameters {}

class FakeShipTosQueryParameters extends Fake
    implements ShipTosQueryParameters {}

void main() {
  final sl = GetIt.instance;

  late BillToShipToAddressSelectionUseCase useCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockBillToService mockBillToService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeBillTosQueryParameters());
    registerFallbackValue(FakeShipTosQueryParameters());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockBillToService = MockBillToService();
    mockTrackingService = MockTrackingService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getBillToService())
        .thenReturn(mockBillToService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Set up tracking service mock
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    // Initialize the use case
    useCase = BillToShipToAddressSelectionUseCase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('BillToShipToAddressSelectionUseCase Tests', () {
    group('getBillToAddresses', () {
      test('should return success when API call succeeds', () async {
        // Arrange
        const searchQuery = 'test search';
        const currentPage = 1;

        final mockBillTos = [
          BillTo(isDefault: true),
          BillTo(isDefault: false),
        ];
        final mockResult = GetBillTosResult(billTos: mockBillTos);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result =
            await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetBillTosResult, ErrorResponse>>());

        switch (result) {
          case Success(value: final billTosResult):
            expect(billTosResult, isNotNull);
            expect(billTosResult!.billTos?.length, equals(2));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify the service was called with correct parameters
        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.filter, equals(searchQuery));
        expect(captured.page, equals(currentPage));
        expect(captured.exclude, contains('excludeshowall'));
        expect(captured.exclude, contains('showall'));
      });

      test('should return failure when API call fails', () async {
        // Arrange
        const searchQuery = 'test search';
        const currentPage = 1;

        final errorResponse = ErrorResponse(message: 'Network error');
        final failureResult =
            Failure<GetBillTosResult, ErrorResponse>(errorResponse);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => failureResult);

        // Act
        final result =
            await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        expect(result, isA<Failure<GetBillTosResult, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Network error'));
        }

        verify(() => mockBillToService.getBillTosAsync(
            parameters: any(named: 'parameters'))).called(1);
      });

      test('should handle empty search query', () async {
        // Arrange
        const searchQuery = '';
        const currentPage = 1;

        final mockBillTos = <BillTo>[];
        final mockResult = GetBillTosResult(billTos: mockBillTos);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result =
            await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetBillTosResult, ErrorResponse>>());

        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.filter, equals(''));
      });

      test('should handle different page numbers', () async {
        // Arrange
        const searchQuery = 'test';
        const currentPage = 5;

        final mockResult = GetBillTosResult(billTos: []);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.page, equals(5));
      });

      test('should always exclude showall and excludeshowall parameters',
          () async {
        // Arrange
        const searchQuery = 'test';
        const currentPage = 1;

        final mockResult = GetBillTosResult(billTos: []);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.exclude, isNotNull);
        expect(captured.exclude, hasLength(2));
        expect(captured.exclude, contains('excludeshowall'));
        expect(captured.exclude, contains('showall'));
      });
    });

    group('getShipToAddresses', () {
      test('should return success when API call succeeds', () async {
        // Arrange
        const billToId = 'billto123';
        const searchQuery = 'test search';
        const currentPage = 1;

        final mockShipTos = [
          ShipTo(isDefault: true),
          ShipTo(isDefault: false),
        ];
        final mockResult = GetShipTosResult(shipTos: mockShipTos);
        final successResult =
            Success<GetShipTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetShipTosResult, ErrorResponse>>());

        switch (result) {
          case Success(value: final shipTosResult):
            expect(shipTosResult, isNotNull);
            expect(shipTosResult!.shipTos?.length, equals(2));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify the service was called with correct parameters
        final captured = verify(() => mockBillToService.getShipTosAsync(
                billToId,
                parameters: captureAny(named: 'parameters'))).captured.single
            as ShipTosQueryParameters;

        expect(captured.filter, equals(searchQuery));
        expect(captured.page, equals(currentPage));
        expect(captured.exclude, contains('excludeshowall'));
        expect(captured.exclude, contains('showall'));
      });

      test('should return failure when API call fails', () async {
        // Arrange
        const billToId = 'billto123';
        const searchQuery = 'test search';
        const currentPage = 1;

        final errorResponse = ErrorResponse(message: 'BillTo not found');
        final failureResult =
            Failure<GetShipTosResult, ErrorResponse>(errorResponse);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => failureResult);

        // Act
        final result = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(result, isA<Failure<GetShipTosResult, ErrorResponse>>());

        switch (result) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('BillTo not found'));
        }

        verify(() => mockBillToService.getShipTosAsync(billToId,
            parameters: any(named: 'parameters'))).called(1);
      });

      test('should handle empty billToId', () async {
        // Arrange
        const billToId = '';
        const searchQuery = 'test';
        const currentPage = 1;

        final mockResult = GetShipTosResult(shipTos: []);
        final successResult =
            Success<GetShipTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetShipTosResult, ErrorResponse>>());

        verify(() => mockBillToService.getShipTosAsync('',
            parameters: any(named: 'parameters'))).called(1);
      });

      test('should handle empty search query for ship to addresses', () async {
        // Arrange
        const billToId = 'billto123';
        const searchQuery = '';
        const currentPage = 1;

        final mockResult = GetShipTosResult(shipTos: []);
        final successResult =
            Success<GetShipTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetShipTosResult, ErrorResponse>>());

        final captured = verify(() => mockBillToService.getShipTosAsync(
                billToId,
                parameters: captureAny(named: 'parameters'))).captured.single
            as ShipTosQueryParameters;

        expect(captured.filter, equals(''));
      });

      test('should handle different page numbers for ship to addresses',
          () async {
        // Arrange
        const billToId = 'billto123';
        const searchQuery = 'test';
        const currentPage = 3;

        final mockResult = GetShipTosResult(shipTos: []);
        final successResult =
            Success<GetShipTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getShipToAddresses(billToId, searchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getShipTosAsync(
                billToId,
                parameters: captureAny(named: 'parameters'))).captured.single
            as ShipTosQueryParameters;

        expect(captured.page, equals(3));
      });

      test(
          'should always exclude showall and excludeshowall parameters for ship to addresses',
          () async {
        // Arrange
        const billToId = 'billto123';
        const searchQuery = 'test';
        const currentPage = 1;

        final mockResult = GetShipTosResult(shipTos: []);
        final successResult =
            Success<GetShipTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getShipToAddresses(billToId, searchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getShipTosAsync(
                billToId,
                parameters: captureAny(named: 'parameters'))).captured.single
            as ShipTosQueryParameters;

        expect(captured.exclude, isNotNull);
        expect(captured.exclude, hasLength(2));
        expect(captured.exclude, contains('excludeshowall'));
        expect(captured.exclude, contains('showall'));
      });
    });

    group('integration tests', () {
      test('should handle complete workflow for address selection', () async {
        // Arrange
        const searchQuery = 'test company';
        const currentPage = 1;
        const billToId = 'billto123';

        final mockBillTos = [BillTo(isDefault: true)];
        final mockShipTos = [ShipTo(isDefault: false)];

        final billToResult = GetBillTosResult(billTos: mockBillTos);
        final shipToResult = GetShipTosResult(shipTos: mockShipTos);

        final billToSuccess =
            Success<GetBillTosResult, ErrorResponse>(billToResult);
        final shipToSuccess =
            Success<GetShipTosResult, ErrorResponse>(shipToResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => billToSuccess);
        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => shipToSuccess);

        // Act
        final billToResults =
            await useCase.getBillToAddresses(searchQuery, currentPage);
        final shipToResults = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(billToResults, isA<Success<GetBillTosResult, ErrorResponse>>());
        expect(shipToResults, isA<Success<GetShipTosResult, ErrorResponse>>());

        switch (billToResults) {
          case Success(value: final billTosResult):
            expect(billTosResult, isNotNull);
            expect(billTosResult!.billTos?.length, equals(1));
          case Failure():
            fail('Expected Success but got Failure');
        }

        switch (shipToResults) {
          case Success(value: final shipTosResult):
            expect(shipTosResult, isNotNull);
            expect(shipTosResult!.shipTos?.length, equals(1));
          case Failure():
            fail('Expected Success but got Failure');
        }

        // Verify service calls
        verify(() => mockBillToService.getBillTosAsync(
            parameters: any(named: 'parameters'))).called(1);
        verify(() => mockBillToService.getShipTosAsync(billToId,
            parameters: any(named: 'parameters'))).called(1);
      });

      test('should handle mixed success and failure scenarios', () async {
        // Arrange
        const searchQuery = 'test';
        const currentPage = 1;
        const billToId = 'invalid_billto';

        final billToResult = GetBillTosResult(billTos: [BillTo()]);
        final billToSuccess =
            Success<GetBillTosResult, ErrorResponse>(billToResult);

        final shipToError = ErrorResponse(message: 'Invalid BillTo ID');
        final shipToFailure =
            Failure<GetShipTosResult, ErrorResponse>(shipToError);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => billToSuccess);
        when(() => mockBillToService.getShipTosAsync(any(),
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => shipToFailure);

        // Act
        final billToResults =
            await useCase.getBillToAddresses(searchQuery, currentPage);
        final shipToResults = await useCase.getShipToAddresses(
            billToId, searchQuery, currentPage);

        // Assert
        expect(billToResults, isA<Success<GetBillTosResult, ErrorResponse>>());
        expect(shipToResults, isA<Failure<GetShipTosResult, ErrorResponse>>());

        switch (shipToResults) {
          case Success():
            fail('Expected Failure but got Success');
          case Failure(errorResponse: final error):
            expect(error.message, equals('Invalid BillTo ID'));
        }
      });
    });

    group('edge cases', () {
      test('should handle null or malformed responses gracefully', () async {
        // Arrange
        const searchQuery = 'test';
        const currentPage = 1;

        final mockResult = GetBillTosResult(billTos: null);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        final result =
            await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        expect(result, isA<Success<GetBillTosResult, ErrorResponse>>());

        switch (result) {
          case Success(value: final billTosResult):
            expect(billTosResult, isNotNull);
            expect(billTosResult!.billTos, isNull);
          case Failure():
            fail('Expected Success but got Failure');
        }
      });

      test('should handle very large page numbers', () async {
        // Arrange
        const searchQuery = 'test';
        const currentPage = 999999;

        final mockResult = GetBillTosResult(billTos: []);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getBillToAddresses(searchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.page, equals(999999));
      });

      test('should handle very long search queries', () async {
        // Arrange
        final longSearchQuery = 'a' * 1000; // Very long string
        const currentPage = 1;

        final mockResult = GetBillTosResult(billTos: []);
        final successResult =
            Success<GetBillTosResult, ErrorResponse>(mockResult);

        when(() => mockBillToService.getBillTosAsync(
                parameters: any(named: 'parameters')))
            .thenAnswer((_) async => successResult);

        // Act
        await useCase.getBillToAddresses(longSearchQuery, currentPage);

        // Assert
        final captured = verify(() => mockBillToService.getBillTosAsync(
                parameters: captureAny(named: 'parameters'))).captured.single
            as BillTosQueryParameters;

        expect(captured.filter, equals(longSearchQuery));
      });
    });
  });
}
