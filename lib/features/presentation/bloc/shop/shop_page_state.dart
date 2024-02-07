part of 'shop_page_bloc.dart';

abstract class ShopPageState {
  const ShopPageState();
}

class ShopPageInitialState extends ShopPageState {}

class ShopPageLoadingState extends ShopPageState {}

class ShopPageLoadedState extends ShopPageState {
  final List<WidgetEntity> pageWidgets;
  const ShopPageLoadedState({required this.pageWidgets});
}

class ShopPageFailureState extends ShopPageState {
  final String error;

  const ShopPageFailureState(this.error);
}
