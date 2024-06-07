part of 'checkout_bloc.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutDataLoaded extends CheckoutState {
  final Cart cart;
  final BillTo billToAddress;
  final ShipTo shipToAddress;
  final Warehouse wareHouse;
  final PromotionCollectionModel? promotions;
  final String shippingMethod;
  final CartSettings? cartSettings;
  final CarrierDto? selectedCarrier;
  final ShipViaDto? selectedService;
  final DateTime? requestDeliveryDate;

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
      });
}

class CheckoutDataFetchFailed extends CheckoutState {
  final String error;

  CheckoutDataFetchFailed({required this.error});
}

class CheckoutPlaceOrder extends CheckoutState {
  final String orderNumber;

  CheckoutPlaceOrder({required this.orderNumber});
}
