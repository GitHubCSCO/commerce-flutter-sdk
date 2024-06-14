import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_filter_state.dart';

class OrderApprovalFilterCubit extends Cubit<OrderApprovalFilterState> {
  OrderApprovalFilterCubit() : super(OrderApprovalFilterState());

  void initialize({required OrderApprovalParameters orderApprovalParameters}) {
    var newState = state.copyWith();
    newState.orderNumber = orderApprovalParameters.orderNumber;
    newState.orderTotal = orderApprovalParameters.orderTotal;
    newState.orderTotalOperator =
        orderApprovalParameters.orderTotalOperator?.first;
    newState.fromDate = orderApprovalParameters.fromDate;
    newState.toDate = orderApprovalParameters.toDate;
    newState.shipTo = orderApprovalParameters.shipTo;
    emit(newState);
  }

  void reset() {
    emit(OrderApprovalFilterState());
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
}
