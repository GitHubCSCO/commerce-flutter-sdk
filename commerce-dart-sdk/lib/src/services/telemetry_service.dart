import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/models/screen_view.dart';
import 'package:optimizely_commerce_api/src/models/user_event.dart';

class TelemetryTrackingService extends ServiceBase
    implements ITelemetryTrackingService {
  TelemetryTrackingService(
      {required super.clientService,
      required super.cacheService,
      required super.networkService});

  @override
  Future<Result<EventResponse, ErrorResponse>> sceenView(ScreenView screenView,
      {Map<String, dynamic>? properties}) async {
    var urlStringTelemetry = CommerceAPIConstants.telemetryScreenViewUrl;

    return await postAsyncNoCache<EventResponse>(
        urlStringTelemetry, screenView.toJson(), EventResponse.fromJson);
  }

  @override
  Future<Result<EventResponse, ErrorResponse>> trackEvent(
      UserEvent userEvent) async {
    var urlStringTelemetry = CommerceAPIConstants.telemetryUrl;

    return await postAsyncNoCache<EventResponse>(
        urlStringTelemetry, userEvent.toJson(), EventResponse.fromJson);
  }
}
