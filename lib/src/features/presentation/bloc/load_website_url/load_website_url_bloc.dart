import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'load_website_url_event.dart';
part 'load_website_url_state.dart';

class LoadWebsiteUrlBloc
    extends Bloc<LoadWebsiteUrlEvent, LoadWebsiteUrlState> {
  final PlatformUseCase _platformUsecase;

  LoadWebsiteUrlBloc({required PlatformUseCase platformUsecase})
      : _platformUsecase = platformUsecase,
        super(LoadWebsiteUrlInitialState()) {
    on<LoadWebsiteUrlLoadEvent>(_onLoadWebsiteUrlLoadEvent);
    on<LoadCustomUrlLoadEvent>(_onLoadCustomUrlLoadEvent);
  }

  Future<void> _onLoadCustomUrlLoadEvent(
      LoadCustomUrlLoadEvent event, Emitter<LoadWebsiteUrlState> emit) async {
    emit(LoadWebsiteUrlInitialState());
    if (event.customUrl?.isNullOrEmpty == true) {
      emit(LoadWebsiteUrlFailureState(
          LocalizationConstants.invalidUrl.localized()));
    } else {
      var result =
          await _platformUsecase.getAuthorizedCustomUrl(event.customUrl!);
      if (result != null) {
        emit(LoadCustomUrlLoadedState(customURL: result));
      } else {
        emit(LoadWebsiteUrlFailureState(
            LocalizationConstants.invalidUrl.localized()));
      }
    }
  }

  Future<void> _onLoadWebsiteUrlLoadEvent(
      LoadWebsiteUrlLoadEvent event, Emitter<LoadWebsiteUrlState> emit) async {
    emit(LoadWebsiteUrlInitialState());
    var result = await _platformUsecase.getAuthorizedURL(event.redirectUrl);
    if (result != null) {
      emit(LoadWebsiteUrlLoadedState(
          authorizedURL: result, isloadInAppBrowser: event.isloadInAppBrowser));
    } else {
      emit(LoadWebsiteUrlFailureState(
          LocalizationConstants.failedToLoadUrl.localized()));
    }
  }
}
