import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/firebase_tracking_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

// Mock dependencies
class MockSessionService extends Mock implements ISessionService {}

class MockAccountService extends Mock implements IAccountService {}

class MockAnalyticsConfig extends Mock implements AnalyticsConfig {}

class MockSession extends Mock implements Session {}

class MockAccount extends Mock implements Account {}

class MockBillTo extends Mock implements BillTo {}

class MockShipTo extends Mock implements ShipTo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSessionService mockSessionService;
  late MockAccountService mockAccountService;
  late MockAnalyticsConfig mockAnalyticsConfig;

  setUp(() {
    mockSessionService = MockSessionService();
    mockAccountService = MockAccountService();
    mockAnalyticsConfig = MockAnalyticsConfig();

  });
}
