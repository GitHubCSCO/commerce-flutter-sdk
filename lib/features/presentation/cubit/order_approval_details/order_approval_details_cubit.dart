import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_details_state.dart';

class OrderApprovalDetailsCubit extends Cubit<OrderApprovalDetailsState> {
  final OrderApprovalUseCase _orderApprovalUseCase;
  ProductSettings? productSettings;

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

    var productSettingsResult =
        await _orderApprovalUseCase.loadProductSettings();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    final cart = await _orderApprovalUseCase.loadCart(cartId: cartId);

    if (cart != null) {
      emit(
        state.copyWith(
          cart: cart,
          status: OrderStatus.success,
          hasRestrictedCartLines:
              cart.cartLines?.any((cartLine) => cartLine.isRestricted == true),
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

  List<CartLineEntity> getCartLines() {
    List<CartLineEntity> cartlines = [];
    for (var cartLine in state.cart.cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper.toEntity(cartLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              cartLine.availability.messageType != 0;
      cartLineEntity = cartLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton);
      cartlines.add(cartLineEntity);
    }
    return cartlines;
  }

  // header section
  String get subtotalValue => state.cart.orderSubTotalDisplay ?? '';
  String get shippingValue => state.cart.shippingAndHandlingDisplay ?? '';
  String get taxValue => state.cart.totalTaxDisplay ?? '';
  String get totalValue => state.cart.orderGrandTotalDisplay ?? '';
  String get subtotalTitle =>
      '${LocalizationConstants.subtotal} (${state.cart.totalQtyOrdered})';

  // body section
  bool get isFulfillmentMethodShip => state.cart.fulfillmentMethod == 'Ship';
  bool get isFulfillmentMethodPickUp =>
      state.cart.fulfillmentMethod == 'PickUp';

  String get shippingAddressTitle => isFulfillmentMethodShip
      ? LocalizationConstants.shippingAddress
      : (isFulfillmentMethodPickUp ? LocalizationConstants.pickUpLocation : '');

  String get shipToCityStatePostalCodeDisplay => isFulfillmentMethodShip
      ? '${state.cart.shipTo?.city}, ${state.cart.shipTo?.state?.name} ${state.cart.shipTo?.postalCode}'
      : (isFulfillmentMethodPickUp
          ? '${state.cart.defaultWarehouse?.city}, ${state.cart.defaultWarehouse?.state} ${state.cart.defaultWarehouse?.postalCode}'
          : '');

  String get shippingCompanyTitle => isFulfillmentMethodShip
      ? state.cart.shipTo?.companyName ?? ''
      : (isFulfillmentMethodPickUp
          ? state.cart.defaultWarehouse?.description ?? ''
          : '');

  String get shipToAddressLines => isFulfillmentMethodShip
      ? '${state.cart.shipTo?.address1}, ${state.cart.shipTo?.address2}'
      : (isFulfillmentMethodPickUp
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
