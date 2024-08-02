import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_menu_state.dart';

class BottomMenuCubit extends Cubit<BottomMenuState> {
  final PlatformUseCase _platformUseCase;

  BottomMenuCubit({required PlatformUseCase platformUseCase})
      : _platformUseCase = platformUseCase,
        super(BottomMenuInitial());

  Future<void> loadWebsiteUrl(String path) async {
    final result = await _platformUseCase.getAuthorizedURL(path);
    if (result != null) {
      emit(BottomMenuWebsiteUrlLoaded(result));
    } else {
      final message = await _platformUseCase.getSiteMessage(
          SiteMessageConstants.nameMobileAppAlertNoInternet,
          SiteMessageConstants.defaultMobileAppAlertCommunicationError);
      emit(BottomMenuWebsiteUrlFailed(message));
    }
  }
}
