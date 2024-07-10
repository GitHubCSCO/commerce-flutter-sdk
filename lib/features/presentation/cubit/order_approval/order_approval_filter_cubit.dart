import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_filter_state.dart';

class OrderApprovalFilterCubit extends Cubit<OrderApprovalFilterState> {
  final OrderApprovalUseCase _orderApprovalUseCase;
  OrderApprovalFilterCubit({
    required OrderApprovalUseCase orderApprovalUseCase,
  })  : _orderApprovalUseCase = orderApprovalUseCase,
        super(OrderApprovalFilterState());

  Future<void> initialize(
      {required OrderApprovalParameters orderApprovalParameters}) async {
    var newState = state.copyWith();
    newState.orderNumber = orderApprovalParameters.orderNumber;
    newState.orderTotal = orderApprovalParameters.orderTotal;
    newState.orderTotalOperator =
        orderApprovalParameters.orderTotalOperator?.first;
    newState.fromDate = orderApprovalParameters.fromDate;
    newState.toDate = orderApprovalParameters.toDate;
    newState.shipTo = orderApprovalParameters.shipTo;
    newState.billTo = await _orderApprovalUseCase.getBillToAddress();

    emit(newState);
  }

  void reset() {
    emit(
      OrderApprovalFilterState(
        billTo: state.billTo,
      ),
    );
  }

  void setOrderNumber(String? orderNumber) {
    var newState = state.copyWith();
    newState.orderNumber = orderNumber;
    emit(newState);
  }

  void setOrderTotal(String? orderTotal) {
    var newState = state.copyWith();
    newState.orderTotal = orderTotal;
    emit(newState);
  }

  void setOrderTotalOperator(String? orderTotalOperator) {
    var newState = state.copyWith();
    newState.orderTotalOperator = orderTotalOperator;
    emit(newState);
  }

  void setFromDate(DateTime? fromDate) {
    var newState = state.copyWith();
    newState.fromDate = fromDate;
    emit(newState);
  }

  void setToDate(DateTime? toDate) {
    var newState = state.copyWith();
    newState.toDate = toDate;
    emit(newState);
  }

  void setShipTo(ShipTo? shipTo) {
    var newState = state.copyWith();
    newState.shipTo = shipTo;
    emit(newState);
  }

  List<String> get orderTotalOperators => const [
        LocalizationConstants.selectTotalType,
        LocalizationConstants.greaterThan,
        LocalizationConstants.lessThan,
        LocalizationConstants.equalTo,
      ];
}
