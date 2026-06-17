import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/login_usecase/change_password_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(const ChangePasswordInitial());

  Future<void> submit({
    required String userName,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const ChangePasswordLoading());

    final response = await changePasswordUseCase.changePassword(
      userName: userName,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final isSuccess = response.status == ChangePasswordStatus.success;
    _trackChangePasswordEvent(successful: isSuccess);

    switch (response.status) {
      case ChangePasswordStatus.success:
        emit(ChangePasswordSuccess(newPassword));
      case ChangePasswordStatus.offline:
      case ChangePasswordStatus.failure:
        emit(
          ChangePasswordFailure(
            response.errorMessage ??
                LocalizationConstants.somethingWentWrong.localized(),
          ),
        );
    }
  }

  void _trackChangePasswordEvent({required bool successful}) {
    changePasswordUseCase.trackEvent(
      AnalyticsEvent(
        AnalyticsConstants.eventChangePassword,
        AnalyticsConstants.screenNameChangePassword,
      ).withProperty(
        name: AnalyticsConstants.eventPropertySuccessful,
        boolValue: successful,
      ),
    );

    changePasswordUseCase.trackTelemetryEvent(
      TelemetryEvent(
        eventName: AnalyticsConstants.eventChangePassword,
      ).withProperty(
        name: AnalyticsConstants.eventPropertySuccessful,
        boolValue: successful,
      ),
    );
  }
}
