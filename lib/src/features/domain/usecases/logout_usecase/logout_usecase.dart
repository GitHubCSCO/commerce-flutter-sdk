import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LogoutUsecase extends DomainUsecase {
  LogoutUsecase() : super();

  Future<void> logout() async {
    await commerceAPIServiceProvider
        .getCacheService()
        .invalidateAllObjectsExcept([CoreConstants.domainKey]);

    final deviceToken =
        await coreServiceProvider.getDeviceTokenService().getDeviceToken();

    await commerceAPIServiceProvider
        .getPushNotificationService()
        .unRegisterDeviceToken(
            DeviceTokenUnregistrationParameters(deviceToken: deviceToken));

    await commerceAPIServiceProvider.getAuthenticationService().logoutAsync();
  }
}
