import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitialState());

  Future<void> onLoginSubmit(String username, String password) async {
    emit(LoginLoadingState());

    final loginStatus = await loginUsecase.attemptSignIn(username, password);
    switch (loginStatus) {
      case LoginStatus.loginSuccess:
        emit(const LoginSuccessState(loginStatus: LoginStatus.loginSuccess));
        break;
      case LoginStatus.loginSuccessBiometric:
        emit(const LoginSuccessState(
            loginStatus: LoginStatus.loginSuccessBiometric));
        break;
      case LoginStatus.loginSuccessBillToShipTo:
        final fullSession =
            (await loginUsecase.getCurrentSession()).getResultSuccessValue();
        if (fullSession == null) {
          emit(
            LoginFailureState(
              title: LocalizationConstants.errorCommunicatingWithTheServer
                  .localized(),
              buttonText: LocalizationConstants.dismiss.localized(),
            ),
          );
          return;
        }
        final currentBillTo = fullSession.billTo;
        final currentShipTo = fullSession.shipTo;

        if (currentBillTo?.id == null || currentShipTo?.id == null) {
          emit(const LoginSuccessState(
              loginStatus: LoginStatus.loginSuccessBillToShipTo));
          return;
        }

        if (!(fullSession.redirectToChangeCustomerPageOnSignIn ?? false)) {
          emit(const LoginSuccessState(loginStatus: LoginStatus.loginSuccess));
          return;
        }

        final parameters = BillTosQueryParameters(
          exclude: ['excludeshowall'],
        );

        final billToResultResponse =
            (await loginUsecase.getBillTo(parameters)).getResultSuccessValue();
        if (billToResultResponse == null) {
          emit(
            LoginFailureState(
              title: LocalizationConstants.errorCommunicatingWithTheServer
                  .localized(),
              buttonText: LocalizationConstants.dismiss.localized(),
            ),
          );
          return;
        }
        final hasOneBillTo = billToResultResponse.billTos?.length == 1 &&
            billToResultResponse.billTos?[0].id != null;
        final isBillToTheSameAsCurrent = hasOneBillTo &&
            billToResultResponse.billTos?[0].id == currentBillTo?.id;

        if (isBillToTheSameAsCurrent) {
          final shipToParameters = ShipTosQueryParameters(
            exclude: ['excludeshowall'],
          );
          final shipToResultResponse = (await loginUsecase.getShipTo(
                  currentBillTo?.id ?? '', shipToParameters))
              .getResultSuccessValue();
          var hasOneShipTo = shipToResultResponse?.shipTos?.length == 1 &&
              shipToResultResponse?.shipTos?[0].id != null;
          var isShipToTheSameAsCurrent = hasOneShipTo &&
              shipToResultResponse?.shipTos?[0].id == currentShipTo?.id;
          if (isShipToTheSameAsCurrent) {
            emit(
                const LoginSuccessState(loginStatus: LoginStatus.loginSuccess));
            return;
          }
        }
        emit(const LoginSuccessState(
            loginStatus: LoginStatus.loginSuccessBillToShipTo));
        break;
      case LoginStatus.loginErrorOffline:
        emit(
          LoginFailureState(
            title: SiteMessageConstants.defaultMobileAppAlertNoInternet,
            message:
                SiteMessageConstants.defaultMobileAppAlertNoInternetDescription,
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginErrorUnsuccessful:
        emit(
          LoginFailureState(
            title: LocalizationConstants.incorrectLoginOrPassword.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginErrorUnknown:
        emit(
          LoginFailureState(
            title: LocalizationConstants.unableToGetCurrentSession.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginFailed:
        emit(
          LoginFailureState(
            title: LocalizationConstants.authenticationFailed.localized(),
            buttonText: LocalizationConstants.oK.localized(),
          ),
        );
        break;
    }
  }

  Future<void> onBiometricLoginSubmit(DeviceAuthenticationOption option) async {
    emit(LoginLoadingState());

    final loginStatus = await loginUsecase.authenticateBiometrically(option);
    switch (loginStatus) {
      case LoginStatus.loginSuccessBillToShipTo:
        emit(const LoginSuccessState(
            loginStatus: LoginStatus.loginSuccessBillToShipTo));
        break;
      case LoginStatus.loginErrorOffline:
        emit(
          LoginFailureState(
            title: SiteMessageConstants.defaultMobileAppAlertNoInternet,
            message:
                SiteMessageConstants.defaultMobileAppAlertNoInternetDescription,
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginErrorUnsuccessful:
        emit(
          LoginFailureState(
            title: LocalizationConstants.incorrectLoginOrPassword.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginErrorUnknown:
        emit(
          LoginFailureState(
            title: LocalizationConstants.unableToGetCurrentSession.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
        break;
      case LoginStatus.loginFailed:
        emit(
          LoginFailureState(
            title: LocalizationConstants.authenticationFailed.localized(),
            buttonText: LocalizationConstants.oK.localized(),
          ),
        );
        break;
      default:
        emit(
          LoginFailureState(
            title: LocalizationConstants.authenticationFailed.localized(),
            buttonText: LocalizationConstants.oK.localized(),
          ),
        );
    }
  }

  Future<void> onCancelLogin() async {
    await loginUsecase.loginCancel();
  }
}
