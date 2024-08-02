part of 'bottom_menu_cubit.dart';

abstract class BottomMenuState {}

class BottomMenuInitial extends BottomMenuState {}

class BottomMenuWebsiteUrlLoaded extends BottomMenuState {
  final String url;

  BottomMenuWebsiteUrlLoaded(this.url);
}

class BottomMenuWebsiteUrlFailed extends BottomMenuState {
  final String message;

  BottomMenuWebsiteUrlFailed(this.message);
}
