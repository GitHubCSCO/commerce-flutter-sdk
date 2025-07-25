import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_return_state.dart';

class OrderReturnCubit extends Cubit<OrderReturnState> {
  final OrderUsecase _orderUseCase;
  OrderEntity? order;

  OrderReturnCubit({required OrderUsecase orderUserCase})
      : _orderUseCase = orderUserCase,
        super(OrderReturnInitial());

  void initiateReturn(OrderEntity order) {
    this.order = order;
    emit(OrderReturnLoaded());
  }

  void setReturnReasonTitle(String reason) {
    returnReason = reason;
  }

  Future<void> returnOrder(String returnNotes, int returnQuantity) async {
    emit(OrderReturnInitial());
    var orderNumber = order?.orderNumber ?? '';
    var line = order?.orderLines?.length ?? 0;
    var reason = returnReason ?? '';

    var rmaLines = <RmaLine>[
      RmaLine(
          line: line, rmaQtyRequested: returnQuantity, rmaReasonCode: reason)
    ];

    var rmaOrder =
        Rma(orderNumber: orderNumber, notes: returnNotes, rmaLines: rmaLines);

    final result = await _orderUseCase.postOrderReturns(orderNumber, rmaOrder);

    emit(OrderReturnLoaded());

    if (result != null) {
      emit(OrderReturnSuccess());
    } else {
      emit(OrderReturnFailure());
    }
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
