import 'package:commerce_flutter_sdk/src/features/domain/service/opti_logger_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OptiLogger', () {
    test('constructor initializes properties correctly with default values',
        () {
      // Act
      final logger = OptiLogger();

      // Assert
      expect(logger.isApiLogEnabled, false);
      expect(logger.isDebugLogEnabled, false);
      expect(logger.isErrorLogEnabled, false);
    });

    test('constructor initializes properties correctly with custom values', () {
      // Act
      final logger = OptiLogger(
        enableApiLog: true,
        enableDebugLog: true,
        enableErrorLog: true,
      );

      // Assert
      expect(logger.isApiLogEnabled, true);
      expect(logger.isDebugLogEnabled, true);
      expect(logger.isErrorLogEnabled, true);
    });

    test('constructor initializes properties with mixed values', () {
      // Act
      final logger = OptiLogger(
        enableApiLog: true,
        enableDebugLog: false,
        enableErrorLog: true,
      );

      // Assert
      expect(logger.isApiLogEnabled, true);
      expect(logger.isDebugLogEnabled, false);
      expect(logger.isErrorLogEnabled, true);
    });
  });
}
