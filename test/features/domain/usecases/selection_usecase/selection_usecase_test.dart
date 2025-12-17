import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/selection_usecase/selection_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockAccountService extends Mock implements IAccountService {}

class MockQuoteService extends Mock implements IQuoteService {}

class MockAccountResult extends Mock implements AccountResult {}

class MockAccount extends Mock implements Account {}

class MockQuoteResult extends Mock implements QuoteResult {}

// Create fake for fallback values
class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakeAccountResult extends Fake implements AccountResult {}

class FakeQuoteResult extends Fake implements QuoteResult {}

class FakeQuoteQueryParameters extends Fake implements QuoteQueryParameters {}

void main() {
  final sl = GetIt.instance;

  late SelectionUsecase selectionUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockAccountService mockAccountService;
  late MockQuoteService mockQuoteService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakeAccountResult());
    registerFallbackValue(FakeQuoteResult());
    registerFallbackValue(FakeQuoteQueryParameters());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockAccountService = MockAccountService();
    mockQuoteService = MockQuoteService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getAccountService())
        .thenReturn(mockAccountService);
    when(() => mockCommerceAPIServiceProvider.getQuoteService())
        .thenReturn(mockQuoteService);

    // Initialize the use case
    selectionUsecase = SelectionUsecase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('SelectionUsecase Tests', () {
    group('Inheritance and architecture tests', () {
      test('should properly extend BaseUseCase', () {
        expect(selectionUsecase, isA<SelectionUsecase>());
        // Verify that it can access BaseUseCase properties
        expect(selectionUsecase.coreServiceProvider,
            equals(mockCoreServiceProvider));
        expect(selectionUsecase.commerceAPIServiceProvider,
            equals(mockCommerceAPIServiceProvider));
      });

      test('should have correct service provider dependencies', () {
        // Act
        final coreProvider = selectionUsecase.coreServiceProvider;
        final commerceProvider = selectionUsecase.commerceAPIServiceProvider;

        // Assert
        expect(coreProvider, isA<ICoreServiceProvider>());
        expect(commerceProvider, isA<ICommerceAPIServiceProvider>());
        expect(coreProvider, equals(mockCoreServiceProvider));
        expect(commerceProvider, equals(mockCommerceAPIServiceProvider));
      });
    });

    group('getUsersList', () {
      test(
          'should return list of CatalogTypeDto when getAccountsAsync succeeds',
          () async {
        // Arrange
        final mockAccount1 = MockAccount();
        final mockAccount2 = MockAccount();
        final mockAccountResult = MockAccountResult();

        when(() => mockAccount1.id).thenReturn('account1');
        when(() => mockAccount1.userName).thenReturn('User One');
        when(() => mockAccount2.id).thenReturn('account2');
        when(() => mockAccount2.userName).thenReturn('User Two');

        when(() => mockAccountResult.accounts)
            .thenReturn([mockAccount1, mockAccount2]);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNotNull);
        expect(result, hasLength(2));
        expect(result![0].id, equals('account1'));
        expect(result[0].title, equals('User One'));
        expect(result[1].id, equals('account2'));
        expect(result[1].title, equals('User Two'));

        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });

      test('should exclude current account when removeMyself is true',
          () async {
        // Arrange
        final mockAccount1 = MockAccount();
        final mockAccount2 = MockAccount();
        final mockAccount3 = MockAccount();
        final mockAccountResult = MockAccountResult();
        final mockCurrentAccount = MockAccount();

        when(() => mockAccount1.id).thenReturn('account1');
        when(() => mockAccount1.userName).thenReturn('User One');
        when(() => mockAccount2.id).thenReturn('account2');
        when(() => mockAccount2.userName).thenReturn('User Two');
        when(() => mockAccount3.id).thenReturn('current_account');
        when(() => mockAccount3.userName).thenReturn('Current User');
        when(() => mockCurrentAccount.id).thenReturn('current_account');

        when(() => mockAccountResult.accounts)
            .thenReturn([mockAccount1, mockAccount2, mockAccount3]);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount)
            .thenReturn(mockCurrentAccount);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: true);

        // Assert
        expect(result, isNotNull);
        expect(result, hasLength(2));
        expect(result!.every((account) => account.id != 'current_account'),
            isTrue);
        expect(result.any((account) => account.id == 'account1'), isTrue);
        expect(result.any((account) => account.id == 'account2'), isTrue);

        verify(() => mockAccountService.getAccountsAsync()).called(1);
        verify(() => mockAccountService.currentAccount).called(1);
      });

      test('should include current account when removeMyself is false',
          () async {
        // Arrange
        final mockAccount1 = MockAccount();
        final mockAccount2 = MockAccount();
        final mockAccountResult = MockAccountResult();
        final mockCurrentAccount = MockAccount();

        when(() => mockAccount1.id).thenReturn('account1');
        when(() => mockAccount1.userName).thenReturn('User One');
        when(() => mockAccount2.id).thenReturn('current_account');
        when(() => mockAccount2.userName).thenReturn('Current User');
        when(() => mockCurrentAccount.id).thenReturn('current_account');

        when(() => mockAccountResult.accounts)
            .thenReturn([mockAccount1, mockAccount2]);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount)
            .thenReturn(mockCurrentAccount);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNotNull);
        expect(result, hasLength(2));
        expect(
            result!.any((account) => account.id == 'current_account'), isTrue);
        expect(result.any((account) => account.id == 'account1'), isTrue);

        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });

      test('should return null when getAccountsAsync fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(
          message: 'Failed to get accounts',
          errorDescription: 'Network error',
        );

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Failure<AccountResult, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNull);
        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });

      test('should return empty list when accounts is null', () async {
        // Arrange
        final mockAccountResult = MockAccountResult();

        when(() => mockAccountResult.accounts).thenReturn(null);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNotNull);
        expect(result, isEmpty);
        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });

      test('should return empty list when accounts is empty', () async {
        // Arrange
        final mockAccountResult = MockAccountResult();

        when(() => mockAccountResult.accounts).thenReturn(<Account>[]);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNotNull);
        expect(result, isEmpty);
        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });

      test('should handle accounts with null id or userName gracefully',
          () async {
        // Arrange
        final mockAccount1 = MockAccount();
        final mockAccount2 = MockAccount();
        final mockAccountResult = MockAccountResult();

        when(() => mockAccount1.id).thenReturn(null);
        when(() => mockAccount1.userName).thenReturn('User One');
        when(() => mockAccount2.id).thenReturn('account2');
        when(() => mockAccount2.userName).thenReturn(null);

        when(() => mockAccountResult.accounts)
            .thenReturn([mockAccount1, mockAccount2]);

        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );

        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Act
        final result = await selectionUsecase.getUsersList(removeMyself: false);

        // Assert
        expect(result, isNotNull);
        expect(result, hasLength(2));
        expect(result![0].id, isNull);
        expect(result[0].title, equals('User One'));
        expect(result[1].id, equals('account2'));
        expect(result[1].title, isNull);

        verify(() => mockAccountService.getAccountsAsync()).called(1);
      });
    });

    group('getSalesRepList', () {
      test('should return QuoteResult when getQuotes succeeds', () async {
        // Arrange
        const page = 1;
        final mockQuoteResult = MockQuoteResult();

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        final result = await selectionUsecase.getSalesRepList(page: page);

        // Assert
        expect(result, isNotNull);
        expect(result, equals(mockQuoteResult));

        // Verify correct parameters were passed
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.page, equals(page));
        expect(capturedParams.pageSize, equals(CoreConstants.defaultPageSize));
        expect(capturedParams.expand, equals(['saleslist']));
      });

      test('should return null when getQuotes fails', () async {
        // Arrange
        const page = 2;
        final errorResponse = ErrorResponse(
          message: 'Failed to get quotes',
          errorDescription: 'Network error',
        );

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Failure<QuoteResult, ErrorResponse>(errorResponse),
        );

        // Act
        final result = await selectionUsecase.getSalesRepList(page: page);

        // Assert
        expect(result, isNull);

        // Verify correct parameters were passed even on failure
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.page, equals(page));
        expect(capturedParams.pageSize, equals(CoreConstants.defaultPageSize));
        expect(capturedParams.expand, equals(['saleslist']));
      });

      test('should use correct page parameter for different page values',
          () async {
        // Arrange
        const page = 5;
        final mockQuoteResult = MockQuoteResult();

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        final result = await selectionUsecase.getSalesRepList(page: page);

        // Assert
        expect(result, isNotNull);

        // Verify correct page parameter
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.page, equals(page));
      });

      test('should always use default page size and saleslist expand',
          () async {
        // Arrange
        const page = 10;
        final mockQuoteResult = MockQuoteResult();

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        await selectionUsecase.getSalesRepList(page: page);

        // Assert
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.pageSize, equals(CoreConstants.defaultPageSize));
        expect(capturedParams.expand, equals(['saleslist']));
        expect(capturedParams.expand, hasLength(1));
      });
    });

    group('Error handling and edge cases', () {
      test('should handle exceptions during getUsersList gracefully', () async {
        // Arrange
        when(() => mockAccountService.getAccountsAsync())
            .thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () => selectionUsecase.getUsersList(removeMyself: false),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle exceptions during getSalesRepList gracefully',
          () async {
        // Arrange
        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () => selectionUsecase.getSalesRepList(page: 1),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle negative page numbers in getSalesRepList', () async {
        // Arrange
        const page = -1;
        final mockQuoteResult = MockQuoteResult();

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        final result = await selectionUsecase.getSalesRepList(page: page);

        // Assert
        expect(result, isNotNull);

        // Verify the negative page was passed through
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.page, equals(page));
      });

      test('should handle zero page number in getSalesRepList', () async {
        // Arrange
        const page = 0;
        final mockQuoteResult = MockQuoteResult();

        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        final result = await selectionUsecase.getSalesRepList(page: page);

        // Assert
        expect(result, isNotNull);

        // Verify the zero page was passed through
        final captured = verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: captureAny(named: 'quoteQueryParameters'),
            )).captured;

        final capturedParams = captured.first as QuoteQueryParameters;
        expect(capturedParams.page, equals(page));
      });
    });

    group('Integration tests', () {
      test('should be able to call both methods independently', () async {
        // Arrange for getUsersList
        final mockAccount = MockAccount();
        final mockAccountResult = MockAccountResult();

        when(() => mockAccount.id).thenReturn('account1');
        when(() => mockAccount.userName).thenReturn('User One');
        when(() => mockAccountResult.accounts).thenReturn([mockAccount]);
        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );
        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Arrange for getSalesRepList
        final mockQuoteResult = MockQuoteResult();
        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act
        final usersResult =
            await selectionUsecase.getUsersList(removeMyself: false);
        final salesRepResult = await selectionUsecase.getSalesRepList(page: 1);

        // Assert
        expect(usersResult, isNotNull);
        expect(usersResult, hasLength(1));
        expect(salesRepResult, isNotNull);
        expect(salesRepResult, equals(mockQuoteResult));

        verify(() => mockAccountService.getAccountsAsync()).called(1);
        verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).called(1);
      });

      test('should maintain correct service provider throughout multiple calls',
          () async {
        // Arrange
        final mockAccountResult = MockAccountResult();
        final mockQuoteResult = MockQuoteResult();

        when(() => mockAccountResult.accounts).thenReturn(<Account>[]);
        when(() => mockAccountService.getAccountsAsync()).thenAnswer(
          (_) async => Success<AccountResult, ErrorResponse>(mockAccountResult),
        );
        when(() => mockAccountService.currentAccount).thenReturn(null);
        when(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).thenAnswer(
          (_) async => Success<QuoteResult, ErrorResponse>(mockQuoteResult),
        );

        // Act - Multiple calls
        await selectionUsecase.getUsersList(removeMyself: false);
        await selectionUsecase.getSalesRepList(page: 1);
        await selectionUsecase.getUsersList(removeMyself: true);
        await selectionUsecase.getSalesRepList(page: 2);

        // Assert service provider consistency
        expect(selectionUsecase.commerceAPIServiceProvider,
            equals(mockCommerceAPIServiceProvider));
        expect(selectionUsecase.coreServiceProvider,
            equals(mockCoreServiceProvider));

        verify(() => mockAccountService.getAccountsAsync()).called(2);
        verify(() => mockQuoteService.getQuotes(
              quoteQueryParameters: any(named: 'quoteQueryParameters'),
            )).called(2);
      });
    });
  });
}
