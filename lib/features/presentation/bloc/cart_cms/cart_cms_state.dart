import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:flutter/foundation.dart';

abstract class CartCmsPageState {
  const CartCmsPageState();
}

class CartCmsPageInitialState extends CartCmsPageState {}

class CartCmsPageLoadingState extends CartCmsPageState {}

class CartCmsPageLoadedState extends CartCmsPageState {
  final List<WidgetEntity> pageWidgets;

  CartCmsPageLoadedState({required this.pageWidgets});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CartCmsPageLoadedState &&
        listEquals(other.pageWidgets, pageWidgets);
  }

  @override
  int get hashCode => pageWidgets.hashCode;
}

class CartCmsPageFailureState extends CartCmsPageState {
  final String error;

  CartCmsPageFailureState(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CartCmsPageFailureState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
