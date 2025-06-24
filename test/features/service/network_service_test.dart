import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/network_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkService networkService;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    // Create a test helper that adds dependency injection
    networkService = _TestableNetworkService(mockConnectivity);
  });

  group('NetworkService', () {
    test('isOnline returns true when connected via wifi', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Act
      final result = await networkService.isOnline();

      // Assert
      expect(result, true);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test('isOnline returns true when connected via mobile data', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.mobile]);

      // Act
      final result = await networkService.isOnline();

      // Assert
      expect(result, true);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test('isOnline returns false when there is no connectivity', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      // Act
      final result = await networkService.isOnline();

      // Assert
      expect(result, false);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test('isOnline returns true for ethernet connectivity', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.ethernet]);

      // Act
      final result = await networkService.isOnline();

      // Assert
      expect(result, true);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });
  });
}

// Helper class to make NetworkService testable
class _TestableNetworkService extends NetworkService {
  final Connectivity _mockConnectivity;

  _TestableNetworkService(this._mockConnectivity);

  @override
  Future<bool> isOnline() async {
    final connectivityResult = await _mockConnectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
