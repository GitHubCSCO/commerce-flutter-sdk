import 'package:commerce_flutter_sdk/src/features/domain/usecases/in_app_browser/in_app_browser_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/in_app_browser/in_app_browser_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InAppBrowserCubit extends Cubit<InAppBrowserState> {
  final InAppBrowserUsecase _inAppBrowserUsecase;

  InAppBrowserCubit({required InAppBrowserUsecase inAppBrowserUsecase})
      : _inAppBrowserUsecase = inAppBrowserUsecase,
        super(InAppBrowserInitialState());

  String _accessToken = "";

  String get accessToken => _accessToken;

  Future<void> initializeTokens() async {
    try {
      final accessToken = await _inAppBrowserUsecase.getAccessToken();
      _accessToken = accessToken ?? '';
      emit(InAppBrowserTokenUpdatedState(_accessToken));
    } catch (error) {
      emit(InAppBrowserErrorState("Failed to get access token: $error"));
    }
  }

  Future<void> refreshToken() async {
    try {
      final accessToken = await _inAppBrowserUsecase.getAccessToken();
      _accessToken = accessToken ?? '';
      emit(InAppBrowserTokenUpdatedState(_accessToken));
    } catch (error) {
      emit(InAppBrowserErrorState("Failed to refresh token: $error"));
    }
  }
}
