import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_token_interface.dart';
import 'package:flutter/foundation.dart';

class DeviceTokenService implements IDeviceTokenService {

  // We cache both successful tokens AND the failure case (empty string) so
  // that a hung or failing FirebaseMessaging call doesn't get retried on
  // every login/logout attempt. Without this, a single failed permission
  // request would continue to block the spinner on every subsequent action.
  String? _cachedToken;

  // How long we are willing to wait on each Firebase Messaging call before
  // giving up. On iOS TestFlight builds with a development APNs entitlement
  // (or any APNs misconfiguration), these calls can hang indefinitely. The
  // login/logout UI awaits getDeviceToken() so any hang here freezes the UI.
  static const Duration _firebaseTimeout = Duration(seconds: 5);

  /// Requests notification permission (especially required on iOS) and
  /// returns the FCM token, using cache to avoid rate limits.
  ///
  /// Always completes within ~10s. If FirebaseMessaging hangs or throws,
  /// returns an empty string so the caller can proceed.
  @override
  Future<String> getDeviceToken() async {
    // Return cached value (success OR failure) on subsequent calls.
    final cached = _cachedToken;
    if (cached != null) {
      return cached;
    }

    String token = '';

    // Cache both the success and the empty-string failure so we don't keep
    // retrying a hanging Firebase call on every login/logout.
    _cachedToken = token;
    return token;
  }
}
