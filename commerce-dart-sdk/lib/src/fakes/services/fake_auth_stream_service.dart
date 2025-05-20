import 'dart:async';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FakeAuthStreamService implements IAuthStreamService {
  // StreamController to handle fake authentication state changes
  final _authStatusController = StreamController<AuthSDKStatus>.broadcast();

  // Simulated login state
  AuthSDKStatus _status = AuthSDKStatus.loggedOut;

  // Expose the stream so the app can listen to fake authentication state changes
  @override
  Stream<AuthSDKStatus> get authStatusStream => _authStatusController.stream;

  // Getter to check the current simulated authentication status
  @override
  AuthSDKStatus get status => _status;

  // Method to simulate logging out the user
  @override
  void logout() {
    _status = AuthSDKStatus.loggedOut;
    _authStatusController.add(_status); // Notify listeners of the logout status
    print("FakeAuthStreamService: User logged out (for testing purposes)");
  }

  // Dispose method to close the StreamController when done with testing
  @override
  void dispose() {
    _authStatusController.close();
  }
}
