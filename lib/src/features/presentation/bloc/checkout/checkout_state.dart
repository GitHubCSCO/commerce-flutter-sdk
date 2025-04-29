part of 'checkout_bloc.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutDataLoaded extends CheckoutState {
  final Cart cart;
  final BillTo billToAddress;
  final ShipTo shipToAddress;
  final Warehouse? wareHouse;
  final PromotionCollectionModel? promotions;
  final String shippingMethod;
  final CartSettings? cartSettings;
  final CarrierDto? selectedCarrier;
  final ShipViaDto? selectedService;
  final DateTime? requestDeliveryDate;
  final bool? allowCreateNewShipToAddress;
  final String? requestDateWarningMessage;
  final String cartWarningMsg;
  final String? orderNotes;

  CheckoutDataLoaded(
      {required this.cart,
      required this.billToAddress,
      required this.shipToAddress,
      required this.wareHouse,
      required this.promotions,
      required this.shippingMethod,
      required this.cartSettings,
      required this.selectedCarrier,
      required this.selectedService,
      required this.requestDeliveryDate,
      required this.allowCreateNewShipToAddress,
      required this.requestDateWarningMessage,
      required this.cartWarningMsg,
      required this.orderNotes});
}

class CheckoutNoDataState extends CheckoutState {
  final String? message;

  CheckoutNoDataState(this.message);
}

class CheckoutDataFetchFailed extends CheckoutState {
  final String error;

  CheckoutDataFetchFailed({required this.error});
}

class CheckoutPlaceOrder extends CheckoutState {
  final String orderNumber;
  final Cart cart;
  final ReviewOrderEntity? reviewOrderEntity;
  final String? message;

  CheckoutPlaceOrder({
    required this.orderNumber,
    required this.cart,
    this.reviewOrderEntity,
    this.message,
  });
}

class CheckoutPlaceOrderFailed extends CheckoutState {
  final String error;

  CheckoutPlaceOrderFailed({required this.error});
}

class CheckoutShipToAddressAddedState extends CheckoutState {}
