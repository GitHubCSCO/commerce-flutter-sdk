import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ITelemetryTrackingService {
  Future<Result<EventResponse, ErrorResponse>> trackEvent(UserEvent userEvent);

  Future<Result<EventResponse, ErrorResponse>> screenView(
      ScreenView screenView);
}
