import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class TelemetryEventMapper {
  static UserEvent toUserEvent(TelemetryEvent event) {
    return UserEvent(
      eventName: event.eventName,
      properties: event.properties,
    );
  }

  static ScreenView toScreenView(TelemetryEvent event) {
    return ScreenView(
      screenName: event.screenName,
      properties: event.properties,
    );
  }
}
