import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/platform_usecase/platform_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_menu_state.dart';

class BottomMenuCubit extends Cubit<BottomMenuState> {
  final PlatformUseCase _platformUseCase;

  BottomMenuCubit({required PlatformUseCase platformUseCase})
      : _platformUseCase = platformUseCase,
        super(BottomMenuInitial());

  Future<void> loadWebsiteUrl(String path, {String? screenName}) async {
    final url = await _platformUseCase.getAuthorizedURL(path);
    if (url != null) {
      if (screenName != null && screenName.isNotEmpty) {
        final viewOnWebsiteEvent =
            AnalyticsEvent(AnalyticsConstants.eventViewOnWebsite, screenName)
                .withProperty(
                    name: AnalyticsConstants.eventPropertyUrl, strValue: url);
        _platformUseCase.trackEvent(viewOnWebsiteEvent);
      }
      emit(BottomMenuWebsiteUrlLoaded(url));
    } else {
      final message = await _platformUseCase.getSiteMessage(
          SiteMessageConstants.nameMobileAppAlertNoInternet,
          SiteMessageConstants.defaultMobileAppAlertCommunicationError);
      emit(BottomMenuWebsiteUrlFailed(message));
    }
  }
}
