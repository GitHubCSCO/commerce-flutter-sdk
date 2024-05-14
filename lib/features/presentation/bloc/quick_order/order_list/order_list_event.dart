part of 'order_list_bloc.dart';

abstract class OrderListEvent {}

class OrderListLoadEvent extends OrderListEvent {}

class OrderListItemAddEvent extends OrderListEvent {

  final AutocompleteProduct autocompleteProduct;

  OrderListItemAddEvent(this.autocompleteProduct);

}

class OrderListItemScanAddEvent extends OrderListEvent {

  final String? name;

  OrderListItemScanAddEvent(this.name);

}

class OrderListItemRemoveEvent extends OrderListEvent {

  final ProductEntity productEntity;

  OrderListItemRemoveEvent(this.productEntity);

}

class OrderListAddToCartEvent extends OrderListEvent {}

class OrderListRemoveEvent extends OrderListEvent {}

class OrderListAddToListEvent extends OrderListEvent {}

class OrderListAddStyleProductEvent extends OrderListEvent {

  final StyledProductEntity styledProductEntity;

  OrderListAddStyleProductEvent(this.styledProductEntity);

}
