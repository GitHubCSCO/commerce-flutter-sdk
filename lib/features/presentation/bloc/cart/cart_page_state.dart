part of 'cart_page_bloc.dart';

abstract class CartPageState {}

class CartPageInitialState extends CartPageState {}

class CartPageLoadingState extends CartPageState {}

class CartPageLoadedState extends CartPageState {
  final Cart cart;
  final CartSettings cartSettings;
  final Warehouse warehouse;
  final PromotionCollectionModel promotions;
  final bool isCustomerOrderApproval;
  final String shippingMethod;
  String cartWarningMsg;
  bool? hidePricingEnable;
  bool? hideInventoryEnable;

  CartPageLoadedState(
      {required this.cart,
      required this.warehouse,
      required this.promotions,
      required this.isCustomerOrderApproval,
      required this.cartSettings,
      required this.shippingMethod,
      this.cartWarningMsg = "",
      this.hidePricingEnable,
      this.hideInventoryEnable});
}

class CartPageNoDataState extends CartPageState {
  final String message;

  CartPageNoDataState(this.message);
}

class CartPageFailureState extends CartPageState {
  final String error;

  CartPageFailureState({required this.error});
}
