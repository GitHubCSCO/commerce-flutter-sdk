part of 'order_list_bloc.dart';

abstract class OrderListState extends Equatable {}

class OrderListInitialState extends OrderListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderListLoadingState extends OrderListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderListLoadedState extends OrderListState {

  final List<QuickOrderItemEntity> quickOrderItemList;
  final ProductSettings? productSettings;

  OrderListLoadedState(this.quickOrderItemList, this.productSettings);

  @override
  List<Object?> get props => [quickOrderItemList, productSettings];

}

class OrderListFailedState extends OrderListState {
  @override
  List<Object?> get props => [];
}

class OrderListAddFailedState extends OrderListState {

  final String message;

  OrderListAddFailedState(this.message);

  @override
  List<Object?> get props => [];

}

class OrderListNavigateToCartState extends OrderListState {
  @override
  List<Object?> get props => [];
}

class OrderListAddToListFailedState extends OrderListState {
  @override
  List<Object?> get props => [];
}

class OrderListAddToListSuccessState extends OrderListState {

  final WishListAddToCartCollection wishListLines;

  OrderListAddToListSuccessState(this.wishListLines);

  @override
  List<Object?> get props => [];

}

class OrderListStyleProductAddState extends OrderListState {

  final ProductEntity productEntity;

  OrderListStyleProductAddState(this.productEntity);

  @override
  List<Object?> get props => [];


}


