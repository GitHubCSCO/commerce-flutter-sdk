import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

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
