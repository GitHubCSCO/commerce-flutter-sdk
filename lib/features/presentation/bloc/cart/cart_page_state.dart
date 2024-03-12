import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

abstract class CartPageState {
  const CartPageState();
}

class CartPageInitialState extends CartPageState {}

class CartPageLoadingState extends CartPageState {}

class CartPageLoadedState extends CartPageState {
  final List<WidgetEntity> pageWidgets;

  CartPageLoadedState({required this.pageWidgets});


  @override
  int get hashCode => pageWidgets.hashCode;
}

class CartPageFailureState extends CartPageState {
  final String error;

  CartPageFailureState(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CartPageFailureState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
