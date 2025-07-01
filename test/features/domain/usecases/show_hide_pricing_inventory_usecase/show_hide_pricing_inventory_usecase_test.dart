import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/show_hide_pricing_inventory_usecase/show_hide_pricing_inventory_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockAppConfigurationService extends Mock
    implements IAppConfigurationService {}

void main() {
  final sl = GetIt.instance;

  late ShowHidePricingInventoryUseCase showHidePricingInventoryUseCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockAppConfigurationService mockAppConfigurationService;

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockAppConfigurationService = MockAppConfigurationService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);

    // Mock dependencies
    when(() => mockCoreServiceProvider.getAppConfigurationService())
        .thenReturn(mockAppConfigurationService);

    // Initialize the use case
    showHidePricingInventoryUseCase = ShowHidePricingInventoryUseCase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('ShowHidePricingInventoryUseCase Tests', () {
    group('setHidePricingEnable', () {
      test('should call setHidePricingEnable with true', () {
        // Arrange
        const enableValue = true;

        // Act
        showHidePricingInventoryUseCase.setHidePricingEnable(enableValue);

        // Assert
        verify(() =>
                mockAppConfigurationService.setHidePricingEnable(enableValue))
            .called(1);
      });

      test('should call setHidePricingEnable with false', () {
        // Arrange
        const enableValue = false;

        // Act
        showHidePricingInventoryUseCase.setHidePricingEnable(enableValue);

        // Assert
        verify(() =>
                mockAppConfigurationService.setHidePricingEnable(enableValue))
            .called(1);
      });
    });

    group('getHidePricingEnable', () {
      test('should return true when hidePricingEnable is true', () {
        // Arrange
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenReturn(true);

        // Act
        final result = showHidePricingInventoryUseCase.getHidePricingEnable();

        // Assert
        expect(result, isTrue);
        verify(() => mockAppConfigurationService.hidePricingEnable).called(1);
      });

      test('should return false when hidePricingEnable is false', () {
        // Arrange
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenReturn(false);

        // Act
        final result = showHidePricingInventoryUseCase.getHidePricingEnable();

        // Assert
        expect(result, isFalse);
        verify(() => mockAppConfigurationService.hidePricingEnable).called(1);
      });

      test('should return false when hidePricingEnable is null', () {
        // Arrange
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenReturn(null);

        // Act
        final result = showHidePricingInventoryUseCase.getHidePricingEnable();

        // Assert
        expect(result, isFalse);
        verify(() => mockAppConfigurationService.hidePricingEnable).called(1);
      });
    });

    group('setHideInventoryEnable', () {
      test('should call setHideInventoryEnable with true', () {
        // Arrange
        const enableValue = true;

        // Act
        showHidePricingInventoryUseCase.setHideInventoryEnable(enableValue);

        // Assert
        verify(() =>
                mockAppConfigurationService.setHideInventoryEnable(enableValue))
            .called(1);
      });

      test('should call setHideInventoryEnable with false', () {
        // Arrange
        const enableValue = false;

        // Act
        showHidePricingInventoryUseCase.setHideInventoryEnable(enableValue);

        // Assert
        verify(() =>
                mockAppConfigurationService.setHideInventoryEnable(enableValue))
            .called(1);
      });
    });

    group('getHideInventoryEnable', () {
      test('should return true when hideInventoryEnable is true', () {
        // Arrange
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenReturn(true);

        // Act
        final result = showHidePricingInventoryUseCase.getHideInventoryEnable();

        // Assert
        expect(result, isTrue);
        verify(() => mockAppConfigurationService.hideInventoryEnable).called(1);
      });

      test('should return false when hideInventoryEnable is false', () {
        // Arrange
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenReturn(false);

        // Act
        final result = showHidePricingInventoryUseCase.getHideInventoryEnable();

        // Assert
        expect(result, isFalse);
        verify(() => mockAppConfigurationService.hideInventoryEnable).called(1);
      });

      test('should return false when hideInventoryEnable is null', () {
        // Arrange
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenReturn(null);

        // Act
        final result = showHidePricingInventoryUseCase.getHideInventoryEnable();

        // Assert
        expect(result, isFalse);
        verify(() => mockAppConfigurationService.hideInventoryEnable).called(1);
      });
    });

    group('Integration tests', () {
      test('should be able to set and get hidePricingEnable consistently', () {
        // Arrange - Set up the mock to behave like a real service
        bool? storedHidePricingValue;
        when(() => mockAppConfigurationService.setHidePricingEnable(any()))
            .thenAnswer((invocation) {
          storedHidePricingValue = invocation.positionalArguments[0] as bool;
        });
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenAnswer((_) => storedHidePricingValue);

        // Act & Assert - Test setting to true
        showHidePricingInventoryUseCase.setHidePricingEnable(true);
        expect(showHidePricingInventoryUseCase.getHidePricingEnable(), isTrue);

        // Act & Assert - Test setting to false
        showHidePricingInventoryUseCase.setHidePricingEnable(false);
        expect(showHidePricingInventoryUseCase.getHidePricingEnable(), isFalse);
      });

      test('should be able to set and get hideInventoryEnable consistently',
          () {
        // Arrange - Set up the mock to behave like a real service
        bool? storedHideInventoryValue;
        when(() => mockAppConfigurationService.setHideInventoryEnable(any()))
            .thenAnswer((invocation) {
          storedHideInventoryValue = invocation.positionalArguments[0] as bool;
        });
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenAnswer((_) => storedHideInventoryValue);

        // Act & Assert - Test setting to true
        showHidePricingInventoryUseCase.setHideInventoryEnable(true);
        expect(
            showHidePricingInventoryUseCase.getHideInventoryEnable(), isTrue);

        // Act & Assert - Test setting to false
        showHidePricingInventoryUseCase.setHideInventoryEnable(false);
        expect(
            showHidePricingInventoryUseCase.getHideInventoryEnable(), isFalse);
      });

      test('should handle multiple calls correctly', () {
        // Arrange
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenReturn(true);
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenReturn(false);

        // Act
        final pricing1 = showHidePricingInventoryUseCase.getHidePricingEnable();
        final pricing2 = showHidePricingInventoryUseCase.getHidePricingEnable();
        final inventory1 =
            showHidePricingInventoryUseCase.getHideInventoryEnable();
        final inventory2 =
            showHidePricingInventoryUseCase.getHideInventoryEnable();

        // Assert
        expect(pricing1, isTrue);
        expect(pricing2, isTrue);
        expect(inventory1, isFalse);
        expect(inventory2, isFalse);

        verify(() => mockAppConfigurationService.hidePricingEnable).called(2);
        verify(() => mockAppConfigurationService.hideInventoryEnable).called(2);
      });
    });

    group('UseCase inheritance', () {
      test('should properly extend BaseUseCase', () {
        expect(showHidePricingInventoryUseCase,
            isA<ShowHidePricingInventoryUseCase>());
        // Verify that it can access BaseUseCase properties
        expect(showHidePricingInventoryUseCase.coreServiceProvider,
            equals(mockCoreServiceProvider));
        expect(showHidePricingInventoryUseCase.commerceAPIServiceProvider,
            equals(mockCommerceAPIServiceProvider));
      });

      test('should have correct service provider dependencies', () {
        // Act
        final coreProvider =
            showHidePricingInventoryUseCase.coreServiceProvider;
        final commerceProvider =
            showHidePricingInventoryUseCase.commerceAPIServiceProvider;

        // Assert
        expect(coreProvider, isA<ICoreServiceProvider>());
        expect(commerceProvider, isA<ICommerceAPIServiceProvider>());
        expect(coreProvider, equals(mockCoreServiceProvider));
        expect(commerceProvider, equals(mockCommerceAPIServiceProvider));
      });
    });

    group('Error handling', () {
      test('should handle exceptions in getHidePricingEnable gracefully', () {
        // Arrange
        when(() => mockAppConfigurationService.hidePricingEnable)
            .thenThrow(Exception('Service unavailable'));

        // Act & Assert
        expect(() => showHidePricingInventoryUseCase.getHidePricingEnable(),
            throwsA(isA<Exception>()));
      });

      test('should handle exceptions in getHideInventoryEnable gracefully', () {
        // Arrange
        when(() => mockAppConfigurationService.hideInventoryEnable)
            .thenThrow(Exception('Service unavailable'));

        // Act & Assert
        expect(() => showHidePricingInventoryUseCase.getHideInventoryEnable(),
            throwsA(isA<Exception>()));
      });

      test('should handle exceptions in setHidePricingEnable gracefully', () {
        // Arrange
        when(() => mockAppConfigurationService.setHidePricingEnable(any()))
            .thenThrow(Exception('Service unavailable'));

        // Act & Assert
        expect(() => showHidePricingInventoryUseCase.setHidePricingEnable(true),
            throwsA(isA<Exception>()));
      });

      test('should handle exceptions in setHideInventoryEnable gracefully', () {
        // Arrange
        when(() => mockAppConfigurationService.setHideInventoryEnable(any()))
            .thenThrow(Exception('Service unavailable'));

        // Act & Assert
        expect(
            () => showHidePricingInventoryUseCase.setHideInventoryEnable(true),
            throwsA(isA<Exception>()));
      });
    });
  });
}
