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
  List<Object?> get props => [];

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

class OrderListNavigateToVmiCheckoutState extends OrderListState {

  final Cart cart;

  OrderListNavigateToVmiCheckoutState({required this.cart});

  @override
  List<Object?> get props => [];
}

class OrderListAddToListFailedState extends OrderListState {
  @override
  List<Object?> get props => [];
}

class OrderListAddToListSuccessState extends OrderListState {

  final WishListAddToCartCollection wishListLines;
  final String? message;

  OrderListAddToListSuccessState(this.wishListLines, this.message);

  @override
  List<Object?> get props => [];

}

class OrderListStyleProductAddState extends OrderListState {

  final ProductEntity productEntity;

  OrderListStyleProductAddState(this.productEntity);

  @override
  List<Object?> get props => [];

}

class OrderListVmiStyleProductAddState extends OrderListState {

  final VmiBinModelEntity vmiBinEntity;

  OrderListVmiStyleProductAddState(this.vmiBinEntity);

  @override
  List<Object?> get props => [];

}

class OrderListVmiProductAddState extends OrderListState {

  final VmiBinModelEntity vmiBinEntity;
  final OrderEntity? previousOrderEntity;

  OrderListVmiProductAddState(this.vmiBinEntity, this.previousOrderEntity);

  @override
  List<Object?> get props => [];

}


