import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_approval_handler_state.dart';

class OrderApprovalHandlerCubit extends Cubit<OrderApprovalHandlerState> {
  OrderApprovalHandlerCubit()
      : super(
          const OrderApprovalHandlerState(
              status: OrderApprovalHandlerStatus.initial),
        );

  void shouldRefreshOrderApproval() {
    emit(
      state.copyWith(
        status: OrderApprovalHandlerStatus.shouldRefreshOrderApproval,
      ),
    );
  }

  void resetState() {
    emit(
      const OrderApprovalHandlerState(
        status: OrderApprovalHandlerStatus.initial,
      ),
    );
  }
}
