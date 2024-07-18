import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/account_usecase/account_usecase.dart';
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
    var result = await _accountUseCase.loadData();
    await _accountUseCase.coreServiceProvider.getAppConfigurationService().loadRemoteSettings();
    switch (result) {
      case Success(value: final data):
        emit(AccountPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(AccountPageFailureState(errorResponse.errorDescription ?? ''));
    }
  }

  String getAppVersionAndBuildNumber() {
    return _accountUseCase.getAppVersionAndBuildNumber!;
  }

  String? getPrivacyPolicyUrl() {
    return _accountUseCase.coreServiceProvider
                .getAppConfigurationService()
                .privacyPolicyUrl;
  }
  
  String? getTermsOfUseUrll() {
    return _accountUseCase.coreServiceProvider
                .getAppConfigurationService()
                .termsOfUseUrl;
  }
}
