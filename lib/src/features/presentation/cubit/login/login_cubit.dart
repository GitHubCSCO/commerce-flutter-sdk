import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  bool showSpinner = false;

  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitialState());

  String informationText = '';

  String? get privacyPolicyUrl => loginUsecase.privacyPolicyUrl;

  String? get termsOfUseUrl => loginUsecase.termsOfUseUrl;

  bool get isInfoMessageAvailable =>
      !(privacyPolicyUrl.isNullOrEmpty || termsOfUseUrl.isNullOrEmpty);

  Future<void> _loadSiteMessages() async {
    informationText = await loginUsecase.getSiteMessage(
      SiteMessageConstants.nameMobileAppSignInAgreement,
      SiteMessageConstants.defaultMobileAppSignInAgreement,
    );
  }

  void trackSignInEvent(String loginType) {
    loginUsecase.trackEvent(AnalyticsEvent(
            AnalyticsConstants.eventSignIn, AnalyticsConstants.screenNameSignIn)
        .withProperty(
            name: AnalyticsConstants.eventPropertySuccessful, boolValue: true)
        .withProperty(
            name: AnalyticsConstants.eventPropertyLoginType,
            strValue: loginType));
  }

  Future<void> initialize() async {
    emit(LoginInfoLoadingState());
    await _loadSiteMessages();
    emit(LoginInitialState());
  }

  Future<void> onLoginSubmit(String username, String password) async {
    emit(LoginLoadingState());

    final loginResponse = await loginUsecase.attemptSignIn(username, password);
    final loginStatus = loginResponse.loginStatus;
    switch (loginStatus) {
      case LoginStatus.loginSuccess:
        trackSignInEvent('password');
        emit(const LoginSuccessState(loginStatus: LoginStatus.loginSuccess));
      case LoginStatus.loginSuccessBiometric:
        emit(const LoginSuccessState(
            loginStatus: LoginStatus.loginSuccessBiometric));
      case LoginStatus.loginSuccessBillToShipTo:
        await handleBillToShipTo();
      case LoginStatus.loginErrorOffline:
        final title = await loginUsecase.getSiteMessage(
            SiteMessageConstants.nameMobileAppAlertNoInternet,
            SiteMessageConstants.defaultMobileAppAlertNoInternet);
        final message = await loginUsecase.getSiteMessage(
            SiteMessageConstants.nameMobileAppAlertNoInternetDescription,
            SiteMessageConstants.defaultMobileAppAlertNoInternetDescription);
        emit(
          LoginFailureState(
            title: title,
            message: message,
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
      case LoginStatus.loginErrorUnsuccessful:
        emit(
          LoginFailureState(
            title: loginResponse.message ??
                LocalizationConstants.incorrectLoginOrPassword.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
      case LoginStatus.loginErrorUnknown:
        emit(
          LoginFailureState(
            title: LocalizationConstants.unableToGetCurrentSession.localized(),
            buttonText: LocalizationConstants.dismiss.localized(),
          ),
        );
      case LoginStatus.loginFailed:
        emit(
          LoginFailureState(
            title: LocalizationConstants.authenticationFailed.localized(),
            buttonText: LocalizationConstants.oK.localized(),
          ),
        );
    }
  }

  Future<void> onBiometricLoginSubmit(
      DeviceAuthenticationOption option, String biometricDisplayOption) async {
    emit(LoginLoadingState());

    final loginStatus = await loginUsecase.authenticateBiometrically(option);
    switch (loginStatus) {
      case LoginStatus.loginSuccessBillToShipTo:
        trackSignInEvent(biometricDisplayOption);
        await handleBillToShipTo();
        break;
      case LoginStatus.loginErrorOffline:
        final title = await loginUsecase.getSiteMessage(
            SiteMessageConstants.nameMobileAppAlertNoInternet,
            SiteMessageConstants.defaultMobileAppAlertNoInternet);
        final message = await loginUsecase.getSiteMessage(
            SiteMessageConstants.nameMobileAppAlertNoInternetDescription,
            SiteMessageConstants.defaultMobileAppAlertNoInternetDescription);
        emit(
          LoginFailureState(
            title: title,
            message: message,
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

  Future<void> handleBillToShipTo() async {
    emit(LoginInitialState());

    final fullSession =
        (await loginUsecase.getCurrentSession()).getResultSuccessValue();
    if (fullSession == null) {
      emit(
        LoginFailureState(
          title:
              LocalizationConstants.errorCommunicatingWithTheServer.localized(),
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
          title:
              LocalizationConstants.errorCommunicatingWithTheServer.localized(),
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
        emit(const LoginSuccessState(loginStatus: LoginStatus.loginSuccess));
        return;
      }
    }
    emit(const LoginSuccessState(
        loginStatus: LoginStatus.loginSuccessBillToShipTo));
  }

  Future<void> onCancelLogin() async {
    await loginUsecase.loginCancel();
  }
}
