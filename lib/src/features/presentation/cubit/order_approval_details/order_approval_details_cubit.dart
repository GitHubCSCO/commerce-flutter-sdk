import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/utils/date_provider_utils.dart';
import 'package:commerce_flutter_sdk/src/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_details_state.dart';

class OrderApprovalDetailsCubit extends Cubit<OrderApprovalDetailsState> {
  final OrderApprovalUseCase _orderApprovalUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  ProductSettings? productSettings;

  OrderApprovalDetailsCubit(
      {required OrderApprovalUseCase orderApprovalUseCase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _orderApprovalUseCase = orderApprovalUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
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

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
    final hideInventoryEnable =
        _pricingInventoryUseCase.getHideInventoryEnable();

    if (cart != null) {
      emit(
        state.copyWith(
          cart: cart,
          status: OrderStatus.success,
          hasRestrictedCartLines:
              cart.cartLines?.any((cartLine) => cartLine.isRestricted == true),
          hidePricingEnable: hidePricingEnable,
          hideInventoryEnable: hideInventoryEnable,
        ),
      );
    } else {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }

  Future<void> approveOrder() async {
    emit(state.copyWith(status: OrderStatus.addToCartLoading));

    final result = await _orderApprovalUseCase.approveOrder(cart: state.cart);

    if (result) {
      emit(
        state.copyWith(status: OrderStatus.addToCartSuccess),
      );
    } else {
      final message = await _orderApprovalUseCase.getSiteMessage(
          SiteMessageConstants.nameOrderApprovalBadRequest,
          SiteMessageConstants.defaultVaLueOrderApprovalBadRequest);
      emit(
        state.copyWith(
            status: OrderStatus.addToCartFailure, errorMessage: message),
      );
    }
  }

  Future<void> deleteOrder() async {
    emit(state.copyWith(status: OrderStatus.deleteCartLoading));

    final result =
        await _orderApprovalUseCase.deleteOrder(cartId: state.cart.id ?? '');

    if (result) {
      emit(state.copyWith(status: OrderStatus.deleteCartSuccess));
    } else {
      final message = await _orderApprovalUseCase.getSiteMessage(
          SiteMessageConstants.nameDeleteCart,
          SiteMessageConstants.defaultValueDeleteCartFail);
      emit(state.copyWith(
          status: OrderStatus.deleteCartFailure, errorMessage: message));
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

  Future<void> addToCart(
      {required AddCartLine addCartLine, required String productNumber}) async {
    orderApprovaltrackAddToCartEvent(productNumber, "1");
    emit(
      state.copyWith(
        status: OrderStatus.lineItemAddToCartLoading,
      ),
    );

    final newCartLine = await _orderApprovalUseCase.addLineItemToCart(
      addCartLine: addCartLine,
    );

    addCartLineToCartMessageName = newCartLine == null
        ? SiteMessageConstants.nameAddToCartFail
        : SiteMessageConstants.nameAddToCartSuccess;
    addCartLineToCartDefaultMessage = newCartLine == null
        ? SiteMessageConstants.defaultValueAddToCartFail
        : SiteMessageConstants.defaultValueAddToCartSuccess;
    addCartLineToCartMessage = await _orderApprovalUseCase.getSiteMessage(
      addCartLineToCartMessageName,
      addCartLineToCartDefaultMessage,
    );

    if (newCartLine != null && newCartLine.isQtyAdjusted == true) {
      quantityAdjustedMessage = await _orderApprovalUseCase.getSiteMessage(
        SiteMessageConstants.nameAddToCartQuantityAdjusted,
        SiteMessageConstants.defaultValueAddToCartQuantityAdjusted,
      );

      emit(
        state.copyWith(
          status: OrderStatus.lineItemAddToCartQtyAdjusted,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: OrderStatus.lineItemAddToCartComplete,
        ),
      );
    }
  }

  void orderApprovaltrackAddToCartEvent(String productNumber, String qty) {
    var analyticsEvent = AnalyticsEvent(AnalyticsConstants.eventAddToCart,
            AnalyticsConstants.screenNameOrderApprovalDetails)
        .withProperty(
            name: AnalyticsConstants.eventPropertyProductNumber,
            strValue: productNumber)
        .withProperty(name: AnalyticsConstants.eventPropertyQty, strValue: qty);

    _orderApprovalUseCase.trackEvent(analyticsEvent);
  }

  String addCartLineToCartMessageName = '';
  String addCartLineToCartDefaultMessage = '';
  String addCartLineToCartMessage = '';
  String quantityAdjustedMessage = '';

  // header section
  String get subtotalValue => state.cart.orderSubTotalDisplay ?? '';
  String get shippingValue => state.cart.shippingAndHandlingDisplay ?? '';
  String get taxValue => state.cart.totalTaxDisplay ?? '';
  String get totalValue => state.cart.orderGrandTotalDisplay ?? '';
  String get subtotalTitle =>
      '${LocalizationConstants.subtotal.localized()} (${state.cart.totalQtyOrdered})';

  // body section
  bool get isFulfillmentMethodShip => state.cart.fulfillmentMethod == 'Ship';
  bool get isFulfillmentMethodPickUp =>
      state.cart.fulfillmentMethod == 'PickUp';

  String get shippingAddressTitle => isFulfillmentMethodShip
      ? LocalizationConstants.shippingAddress.localized()
      : (isFulfillmentMethodPickUp
          ? LocalizationConstants.pickUpLocation.localized()
          : '');

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
      ? formatDateByLocale(state.cart.orderDate!)
      : '';

  String? get orderNotesValue => state.cart.notes ?? '';

  String get poValue => state.cart.poNumber ?? '';

  String get statusValue => state.cart.status ?? '';

  String get approverReason => state.cart.approverReason ?? '';

  // footer section
  bool get hasApprover => state.cart.hasApprover == true;

  bool get isApprovedButtonEnabled => state.hasRestrictedCartLines == false;
}
