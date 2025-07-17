import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IPushNotificationService {
  /// Registers a device token for push notifications
  ///
  /// [deviceToken] Firebase Cloud Messaging (FCM) token (1–100 chars)
  /// [userProfileId] ID of the logged-in user
  ///
  /// Returns a [DeviceTokenResponse] indicating success or failure
  Future<Result<DeviceTokenResponse, ErrorResponse>> registerDeviceToken(
    DeviceTokenRegistrationParameters deviceTokenRegistrationParameters,
  );
}
