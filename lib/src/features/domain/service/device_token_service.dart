import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_token_intefrace.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DeviceTokenService implements IDeviceTokenService {
  DeviceTokenService({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken() ?? '';
  }
}
