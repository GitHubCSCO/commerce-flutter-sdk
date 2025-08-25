import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_status_mapping_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_confirmation_state.dart';

class CheckoutConfirmationCubit extends Cubit<CheckoutConfirmationState> {
  final OrderUsecase _orderUseCase;
  var isCancelOrderEnabled = false;

  CheckoutConfirmationCubit({required OrderUsecase orderUseCase})
      : _orderUseCase = orderUseCase,
        super(CheckoutConfirmationInitial());

  Future<void> loadOrderStatusMappings(String? status) async {
    emit(CheckoutConfirmationLoading());
    var orderStatusMappings = await _orderUseCase.getOrderStatusMappings();

    isCancelOrderEnabled = cancelOrderEnabled(status, orderStatusMappings);

    emit(CheckoutConfirmationLoaded(isCancelEnabled: isCancelOrderEnabled));
  }

  Future<void> cancelOrder(String orderNumber) async {
    emit(CheckoutConfirmationLoading());
    var order = await _orderUseCase.loadOrder(orderNumber);

    if (order != null) {
      order = order.copyWith(status: CoreConstants.cancellationRequested);
      final result = await _orderUseCase.patchOrder(order);
      if (result != null) {
        emit(CheckoutConfirmationSuccess());
      } else {
        emit(
            CheckoutConfirmationFailure(isCancelEnabled: isCancelOrderEnabled));
      }
    } else {
      emit(CheckoutConfirmationFailure(isCancelEnabled: isCancelOrderEnabled));
    }
  }

  bool cancelOrderEnabled(
      String? status, List<OrderStatusMappingEntity>? orderStatusMappings) {
    if (status == null || orderStatusMappings == null) {
      return false;
    }

    final statusMapping = orderStatusMappings.firstWhere(
      (mapping) => mapping.erpOrderStatus == status,
      orElse: () => const OrderStatusMappingEntity(),
    );

    return statusMapping.allowCancellation ?? false;
  }
}
