import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum ChangePasswordStatus {
  success,
  offline,
  failure,
}

class ChangePasswordResponse {
  final ChangePasswordStatus status;
  final String? errorMessage;

  const ChangePasswordResponse(
    this.status, {
    this.errorMessage,
  });
}

class ChangePasswordUseCase extends BaseUseCase {
  ChangePasswordUseCase() : super();

  Future<ChangePasswordResponse> changePassword({
    required String userName,
    required String oldPassword,
    required String newPassword,
  }) async {
    if (!await isOnline()) {
      final message = await getSiteMessage(
        SiteMessageConstants.nameMobileAppAlertNoInternetDescription,
        SiteMessageConstants.defaultMobileAppAlertNoInternetDescription,
      );
      return ChangePasswordResponse(
        ChangePasswordStatus.offline,
        errorMessage: message,
      );
    }

    final result = await commerceAPIServiceProvider
        .getSessionService()
        .changePassword(userName, oldPassword, newPassword);

    switch (result) {
      case Success():
        return const ChangePasswordResponse(ChangePasswordStatus.success);
      case Failure(errorResponse: final errorResponse):
        return ChangePasswordResponse(
          ChangePasswordStatus.failure,
          errorMessage: errorResponse.extractErrorMessage(),
        );
    }
  }
}
