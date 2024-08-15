part of 'order_list_bloc.dart';

abstract class OrderListEvent {}

class OrderListLoadEvent extends OrderListEvent {}

class OrderListItemAddEvent extends OrderListEvent {
  final AutocompleteProduct autocompleteProduct;

  OrderListItemAddEvent(this.autocompleteProduct);
}

class OrderListItemScanAddEvent extends OrderListEvent {
  final String? resultText;
  final BarcodeFormat? barcodeFormat;

  OrderListItemScanAddEvent({this.resultText, this.barcodeFormat});
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

class OrderListAddVmiStyleProductEvent extends OrderListEvent {
  final VmiBinModelEntity vmiBinEntity;
  final StyledProductEntity styledProductEntity;

  OrderListAddVmiStyleProductEvent(this.vmiBinEntity, this.styledProductEntity);
}

class OrderListAddVmiBinEvent extends OrderListEvent {
  final VmiBinModelEntity vmiBinEntity;
  final int quantity;

  OrderListAddVmiBinEvent(this.vmiBinEntity, this.quantity);
}
