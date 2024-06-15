import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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
            hasRestrictedCartLines: false,
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
          hasRestrictedCartLines: cart.cartLines
              ?.any((cartLine) => cartLine.isRestricted == true),
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

    final result =
        await _orderApprovalUseCase.deleteOrder(cartId: state.cart.id ?? '');

    if (result) {
      emit(state.copyWith(status: OrderStatus.deleteCartSuccess));
    } else {
      emit(state.copyWith(status: OrderStatus.deleteCartFailure));
    }
  }

  // header section
  String get subtotalValue => state.cart.orderSubTotalDisplay ?? '';
  String get shippingValue => state.cart.shippingAndHandlingDisplay ?? '';
  String get taxValue => state.cart.totalTaxDisplay ?? '';
  String get totalValue => state.cart.orderGrandTotalDisplay ?? '';
  String get subtotalTitle =>
      '${LocalizationConstants.subtotal} (${state.cart.totalQtyOrdered})';

  // body section
  bool get _checkIfShip => state.cart.fulfillmentMethod == 'Ship';
  bool get _checkIfPickup => state.cart.fulfillmentMethod == 'Pickup';

  String get shippingAddressTitle => _checkIfShip
      ? LocalizationConstants.shippingAddress
      : (_checkIfPickup ? LocalizationConstants.pickUpLocation : '');

  String get shipToCityStatePostalCodeDisplay => _checkIfShip
      ? '${state.cart.shipTo?.city}, ${state.cart.shipTo?.state?.name} ${state.cart.shipTo?.postalCode}'
      : (_checkIfPickup
          ? '${state.cart.defaultWarehouse?.city}, ${state.cart.defaultWarehouse?.state} ${state.cart.defaultWarehouse?.postalCode}'
          : '');

  String get shippingCompanyTitle => _checkIfShip
      ? state.cart.shipTo?.companyName ?? ''
      : (_checkIfPickup ? state.cart.defaultWarehouse?.description ?? '' : '');

  String get shipToAddressLines => _checkIfShip
      ? '${state.cart.shipTo?.address1}, ${state.cart.shipTo?.address2}'
      : (_checkIfPickup
          ? '${state.cart.defaultWarehouse?.address1}, ${state.cart.defaultWarehouse?.address2}'
          : '');

  String get billToCityStatePostalCodeDisplay =>
      '${state.cart.billTo?.city}, ${state.cart.billTo?.state?.name} ${state.cart.billTo?.postalCode}';

  String get billToAddressLines =>
      '${state.cart.billTo?.address1}, ${state.cart.billTo?.address2}';

  String get billingCompanyTitle => state.cart.billTo?.companyName ?? '';

  String get orderDateValue => state.cart.orderDate != null
      ? DateFormat(CoreConstants.dateFormatString).format(state.cart.orderDate!)
      : '';

  String get poValue => state.cart.poNumber ?? '';

  String get statusValue => state.cart.approverReason ?? '';

  // footer section
  bool get hasApprover => state.cart.hasApprover == true;

  bool get isApprovedButtonEnabled => state.hasRestrictedCartLines == false;
}
