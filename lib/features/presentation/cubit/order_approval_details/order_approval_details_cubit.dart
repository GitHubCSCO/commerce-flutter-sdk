import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_details_state.dart';

class OrderApprovalDetailsCubit extends Cubit<OrderApprovalDetailsState> {
  final OrderApprovalUseCase _orderApprovalUseCase;
  OrderApprovalDetailsCubit({
    required OrderApprovalUseCase orderApprovalUseCase,
  })  : _orderApprovalUseCase = orderApprovalUseCase,
        super(
          OrderApprovalDetailsState(
            cart: Cart(),
            status: OrderStatus.initial,
            shouldShowWarehouseInventoryButton: false,
          ),
        );

  Future<void> loadCart({required String cartId}) async {
    emit(state.copyWith(status: OrderStatus.loading));

    final shouldShowWarehouseInventoryButton =
        await _orderApprovalUseCase.shouldShowWarehouseInventoryButton();

    final cart = await _orderApprovalUseCase.loadCart(cartId: cartId);

    if (cart != null) {
      emit(
        state.copyWith(
          cart: cart,
          status: OrderStatus.success,
          shouldShowWarehouseInventoryButton:
              shouldShowWarehouseInventoryButton,
        ),
      );
    } else {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }

  Future<void> approveOrder() async {
    emit(state.copyWith(status: OrderStatus.addToCartLoading));

    final result = await _orderApprovalUseCase.approveOrder(cart: state.cart);

    emit(
      state.copyWith(
        status: result
            ? OrderStatus.addToCartSuccess
            : OrderStatus.addToCartFailure,
      ),
    );
  }

  Future<void> deleteOrder() async {
    emit(state.copyWith(status: OrderStatus.deleteCartLoading));

    final result = await _orderApprovalUseCase.deleteOrder(cartId: state.cart.id ?? '');

    if (result) {
      emit(state.copyWith(status: OrderStatus.deleteCartSuccess));
    } else {
      emit(state.copyWith(status: OrderStatus.deleteCartFailure));
    }
  }
}
