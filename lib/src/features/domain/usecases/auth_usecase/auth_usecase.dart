import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AuthUsecase extends BaseUseCase {
  AuthUsecase() : super();

  Future<bool> isAuthenticated() async {
    final authResult = await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();
    switch (authResult) {
      case Success(value: final value):
        await commerceAPIServiceProvider
            .getAccountService()
            .getCurrentAccountAsync();
        return value!;
      case Failure():
        return false;
    }
  }

  Future<void> sendDeviceToken() async {
    final results = Future.wait(
      [
        coreServiceProvider.getDeviceTokenService().getDeviceToken(),
        commerceAPIServiceProvider.getSessionService().getCurrentSession(),
      ],
    );

    final resultsList = await results;
    final deviceToken = resultsList[0] as String;
    final sessionResult = resultsList[1];

    switch (sessionResult) {
      case Failure():
        return;
      case Success(value: final fullSession):
        if (fullSession == null) {
          return;
        }

        await commerceAPIServiceProvider
            .getPushNotificationService()
            .registerDeviceToken(
              DeviceTokenRegistrationParameters(
                deviceToken: deviceToken,
              ),
            );
    }
  }
}
