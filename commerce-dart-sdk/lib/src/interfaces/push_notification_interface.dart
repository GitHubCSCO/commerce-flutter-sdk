import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/models/device_token_unregistration.dart';

abstract class IPushNotificationService {
  /// Registers a device token for push notifications
  ///
  /// [deviceTokenRegistrationParameters] Parameters containing the device token and user profile ID
  ///
  /// Returns a [Result] containing either a [DeviceTokenResponse] on success or an [ErrorResponse] on failure
  Future<Result<DeviceTokenResponse, ErrorResponse>> registerDeviceToken(
    DeviceTokenRegistrationParameters deviceTokenRegistrationParameters,
  );


   Future<Result<DeviceTokenResponse, ErrorResponse>> unRegisterDeviceToken(
    DeviceTokenUnregistrationParameters deviceTokenUnregistrationParameters,
  );
}
