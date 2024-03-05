part of 'shop_page_bloc.dart';

abstract class ShopPageState {
  const ShopPageState();
}

class ShopPageInitialState extends ShopPageState {}

class ShopPageLoadingState extends ShopPageState {}

class ShopPageLoadedState extends ShopPageState {
  final List<WidgetEntity> pageWidgets;

  ShopPageLoadedState({required this.pageWidgets});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ShopPageLoadedState &&
        listEquals(other.pageWidgets, pageWidgets);
  }

  @override
  int get hashCode => pageWidgets.hashCode;
}

class ShopPageFailureState extends ShopPageState {
  final String error;

  ShopPageFailureState(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ShopPageFailureState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
