part of 'order_list_bloc.dart';

abstract class OrderListEvent {}

class OrderListInitialEvent extends OrderListEvent {}

class OrderListLoadEvent extends OrderListEvent {}

class OrderListReLoadEvent extends OrderListEvent {}

class OrderListItemAddEvent extends OrderListEvent {
  final AutocompleteProduct autocompleteProduct;

  OrderListItemAddEvent(this.autocompleteProduct);
}

class OrderListItemScanAddEvent extends OrderListEvent {
  final String? resultText;
  final BarcodeFormat? barcodeFormat;

  OrderListItemScanAddEvent({this.resultText, this.barcodeFormat});
}

class OrderListItemQuantityChangeEvent extends OrderListEvent {
  final String? productId;
  final int? quantityOrdered;

  OrderListItemQuantityChangeEvent(this.productId, this.quantityOrdered);
}

class OrderListItemUomChangeEvent extends OrderListEvent {
  final QuickOrderItemEntity item;

  OrderListItemUomChangeEvent(this.item);
}

class OrderListItemRemoveEvent extends OrderListEvent {
  final ProductEntity productEntity;

  OrderListItemRemoveEvent(this.productEntity);
}

class OrderListAddToCartEvent extends OrderListEvent {}

class OrderListRemoveEvent extends OrderListEvent {}

class OrderListAddToListEvent extends OrderListEvent {}

class OrderListAddStyleProductEvent extends OrderListEvent {
  final ProductEntity selectedVariantChild;

  OrderListAddStyleProductEvent(this.selectedVariantChild);
}

class OrderListAddVmiStyleProductEvent extends OrderListEvent {
  final VmiBinModelEntity vmiBinEntity;
  final ProductEntity selectedVariantChild;

  OrderListAddVmiStyleProductEvent(this.vmiBinEntity, this.selectedVariantChild);
}

class OrderListAddVmiBinEvent extends OrderListEvent {
  final VmiBinModelEntity vmiBinEntity;
  final int quantity;

  OrderListAddVmiBinEvent(this.vmiBinEntity, this.quantity);
}
