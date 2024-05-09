part of 'order_list_bloc.dart';

abstract class OrderListState extends Equatable {}

class OrderListInitialState extends OrderListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OrderListLoadingState extends OrderListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OrderListLoadedState extends OrderListState {

  final List<QuickOrderItemEntity> quickOrderItemList;
  final ProductSettings? productSettings;
  final String subTotal;

  OrderListLoadedState(this.quickOrderItemList, this.productSettings, this.subTotal);

  @override
  List<Object?> get props => [quickOrderItemList, productSettings, subTotal];

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

