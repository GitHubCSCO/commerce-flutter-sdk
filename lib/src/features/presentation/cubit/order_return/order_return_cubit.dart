import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/order_return/order_return_screen.dart';
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

  void setReturnRequestEnable(List<ReturnInfo> returnInfoList) {
    final hasItemsToReturn =
        returnInfoList.any((info) => info.numberOfItems > 0);

    if (!hasItemsToReturn) {
      emit(OrderReturnEnable(false));
      return;
    }

    final isValid = returnInfoList
        .where((info) => info.numberOfItems > 0)
        .every((info) => info.requestCode != 0);

    emit(OrderReturnEnable(isValid));
  }

  Future<void> returnOrder(
      String returnNotes, List<ReturnInfo> returnInfoList) async {
    emit(OrderReturnInitial());
    var orderNumber = order?.orderNumber ?? '';

    var rmaLines = returnInfoList
        .where((info) => info.numberOfItems > 0)
        .map((info) => RmaLine(
              line: info.lineNumber,
              rmaQtyRequested: info.numberOfItems,
              rmaReasonCode: info.requestCode.toString(),
            ))
        .toList();

    var rmaOrder =
        Rma(orderNumber: orderNumber, notes: returnNotes, rmaLines: rmaLines);

    final result = await _orderUseCase.postOrderReturns(orderNumber, rmaOrder);

    emit(OrderReturnLoaded());

    switch (result) {
      case Success():
        emit(OrderReturnSuccess());
      case Failure():
      default:
        emit(OrderReturnFailure());
    }
  }

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
