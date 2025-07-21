import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/models/screen_view.dart';
import 'package:optimizely_commerce_api/src/models/user_event.dart';

abstract class ITelemetryTrackingService {
  Future<Result<EventResponse, ErrorResponse>> trackEvent(UserEvent userEvent);

  Future<Result<EventResponse, ErrorResponse>> screenView(
      ScreenView screenView);
}
