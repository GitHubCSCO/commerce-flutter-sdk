import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  final AccountUseCase _accountUseCase;

  AccountPageBloc({required AccountUseCase accountUseCase})
      : _accountUseCase = accountUseCase,
        super(AccountPageInitialState()) {
    on<AccountPageLoadEvent>(_onAccountPageLoadEvent);
  }

  Future<void> _onAccountPageLoadEvent(
      AccountPageLoadEvent event, Emitter<AccountPageState> emit) async {
    emit(AccountPageLoadingState());

    loggedOutBannerSiteMessage = await _accountUseCase.getSiteMessage(
      SiteMessageConstants.nameMobileAppAccountUnauthenticatedDescription,
      SiteMessageConstants.defalutMobileAppAccountUnauthenticatedDescription,
    );

    final result = await _accountUseCase.loadData();

    switch (result) {
      case Success(value: final data):
        {
          emit(AccountPageLoadedState(pageWidgets: data ?? []));
          break;
        }
      case Failure(errorResponse: final errorResponse):
        {
          _accountUseCase.trackError(errorResponse);
          emit(AccountPageFailureState(errorResponse.errorDescription ?? ''));
          break;
        }
    }
  }

  String getAppVersionAndBuildNumber() {
    return _accountUseCase.getAppVersionAndBuildNumber!;
  }

  String? getPrivacyPolicyUrl() {
    return _accountUseCase.privacyPolicyUrl;
  }

  String? getTermsOfUseUrl() {
    return _accountUseCase.termsOfUseUrl;
  }

  String loggedOutBannerSiteMessage =
      SiteMessageConstants.defalutMobileAppAccountUnauthenticatedDescription;
}
