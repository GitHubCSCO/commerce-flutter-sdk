import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_token_intefrace.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DeviceTokenService implements IDeviceTokenService {
  DeviceTokenService({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;
  String? _cachedFcmToken;

  /// Requests notification permission (especially required on iOS)
  /// and returns the FCM token, using cache to avoid rate limits.
  @override
  Future<String> getDeviceToken() async {
    // Return cached token if available
    if (_cachedFcmToken != null) {
      return _cachedFcmToken!;
    }

    // Request user permission for notifications
    await _firebaseMessaging.requestPermission();

    // Fetch FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    
    // Cache token for future use
    if (fcmToken != null) {
      _cachedFcmToken = fcmToken;
    }

    return fcmToken ?? '';
  }
}
