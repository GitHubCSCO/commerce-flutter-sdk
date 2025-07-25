import 'package:bloc/bloc.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:meta/meta.dart';

part 'order_return_state.dart';

class OrderReturnCubit extends Cubit<OrderReturnState> {
  OrderEntity? order;

  OrderReturnCubit() : super(OrderReturnInitial());

  void initiateReturn(OrderEntity order) {
    this.order = order;
    emit(OrderReturnLoaded());
  }

  void setReturnReasonTitle(String reason) {
    returnReason = reason;
  }

  String? returnReason;

  String? get discountValue =>
      (order!.orderDiscountAmount == null || order!.orderDiscountAmount! == 0)
          ? ''
          : '-${order!.orderDiscountAmountDisplay}';

  String? get discountTitle => LocalizationConstants.discounts.localized();

  String? get otherChargesValue =>
      (order!.otherCharges == null || order!.otherCharges! == 0)
          ? ''
          : order!.otherChargesDisplay;

  String? get otherChargesTitle =>
      LocalizationConstants.otherCharges.localized();

  String? get shippingHandlingTitle =>
      LocalizationConstants.shippingHandling.localized();

  num get _shippingHandlingValue =>
      (order!.shippingCharges ?? 0) + (order!.handlingCharges ?? 0);
  String? get shippingHandlingValue => _shippingHandlingValue == 0
      ? ''
      : '${CoreConstants.currencySymbol}${_shippingHandlingValue.toStringAsFixed(2)}';

  String? get subTotalTitle => LocalizationConstants.subtotalItems.localized();

  String? get subTotalValue => order!.orderSubTotalDisplay;

  String? get taxTitle => LocalizationConstants.tax.localized();

  String? get taxValue => order!.totalTaxDisplay;

  String? get totalTitle => LocalizationConstants.total.localized();

  String? get totalValue => order!.orderGrandTotalDisplay;
}
