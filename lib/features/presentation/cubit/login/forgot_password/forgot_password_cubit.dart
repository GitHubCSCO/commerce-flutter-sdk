import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/settings/account_settings_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/login_usecase/forgot_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordCubit({required ForgotPasswordUseCase forgotPasswordUseCase})
      : _forgotPasswordUseCase = forgotPasswordUseCase,
        super(
          const ForgotPasswordState(
            status: ForgotPasswordStatus.initial,
            settings: AccountSettingsEntity(),
          ),
        );

  Future<void> resetPassword(String userName, AccountType accountType) async {
    _forgotPasswordUseCase.trackEvent(AnalyticsEvent(
      AnalyticsConstants.eventForgotPassword,
      AnalyticsConstants.screenNameSignIn,
    ));

    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    final status = await _forgotPasswordUseCase.forgotPassword(
      userName: userName,
      accountType: accountType,
    );
    emit(state.copyWith(status: status));
  }

  Future<void> loadAccountSettings() async {
    emit(state.copyWith(status: ForgotPasswordStatus.settingsLoading));
    final settings = await _forgotPasswordUseCase.loadAccountSettings();
    if (settings != null) {
      emit(
        state.copyWith(
          settings: settings,
          status: ForgotPasswordStatus.settingsSuccess,
        ),
      );
    } else {
      emit(state.copyWith(status: ForgotPasswordStatus.settingsFailure));
    }
  }

  bool get useEmailAsUserName => state.settings.useEmailAsUserName ?? false;
}
