import 'dart:async';

import 'package:optimizely_commerce_api/src/interfaces/auth_stream_service_interface.dart';

class AuthStreamService implements IAuthStreamService {
  final _authStatusController = StreamController<AuthSDKStatus>.broadcast();
  AuthSDKStatus _status = AuthSDKStatus.unknown;
  @override
  Stream<AuthSDKStatus> get authStatusStream => _authStatusController.stream;

  AuthStreamService();

  @override
  void dispose() {
    _authStatusController.close();
  }

  @override
  void logout() {
    _status = AuthSDKStatus.loggedOut;
    _authStatusController.add(_status);
    print("User logged out");
  }

  @override
  AuthSDKStatus get status => _status;
}
