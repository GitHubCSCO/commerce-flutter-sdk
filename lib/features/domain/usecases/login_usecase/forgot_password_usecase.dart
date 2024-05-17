import 'package:commerce_flutter_app/features/domain/entity/settings/account_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_app/features/domain/mapper/settings_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  failure,

  settingsLoading,
  settingsSuccess,
  settingsFailure,
}

class ForgotPasswordUseCase extends BaseUseCase {
  ForgotPasswordUseCase() : super();

  Future<AccountSettingsEntity?> loadAccountSettings() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getAccountSettingsAsync();

    switch (result) {
      case Success(value: final value):
        return value != null ? AccountSettingsMapper.toEntity(value) : null;
      case Failure():
        return null;
    }
  }

  Future<ForgotPasswordStatus> forgotPassword({
    required String userName,
    required AccountType accountType,
  }) async {
    var status = ForgotPasswordStatus.failure;

    if (!(await commerceAPIServiceProvider.getNetworkService().isOnline())) {
      return status;
    }

    switch (accountType) {
      case AccountType.admin:
        final response = await commerceAPIServiceProvider
            .getAdminAuthenticationService()
            .forgotPassword(userName);

        if (response is Success) {
          return ForgotPasswordStatus.success;
        }

        break;
      case AccountType.standard:
        await commerceAPIServiceProvider
            .getSessionService()
            .forgotPassword(userName);

        // This API call succeeds only if the user is already registered
        // But the intended behavior of the app is to show a message even if the user is not registered
        return ForgotPasswordStatus.success;
    }

    return status;
  }
}
