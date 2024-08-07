import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'saved_order_details_state.dart';

class SavedOrderDetailsCubit extends Cubit<SavedOrderDetailsState> {
  final SavedOrderUsecase _savedOrderUsecase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  ProductSettings? productSettings;

  SavedOrderDetailsCubit({
    required SavedOrderUsecase savedOrderUsecase,
    required PricingInventoryUseCase pricingInventoryUseCase,
  })  : _savedOrderUsecase = savedOrderUsecase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          SavedOrderDetailsState(
            cart: Cart(),
            status: OrderStatus.initial,
            shouldShowWarehouseInventoryButton: false,
          ),
        );

  Future<void> loadCart({required String cartId}) async {
    emit(state.copyWith(status: OrderStatus.loading));

    var productSettingsResult = await _savedOrderUsecase.loadProductSettings();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    final cart = await _savedOrderUsecase.loadCart(cartId: cartId);

    if (cart != null) {
      final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
      final hideInventoryEnable =
          _pricingInventoryUseCase.getHideInventoryEnable();

      emit(
        state.copyWith(
            cart: cart,
            status: OrderStatus.success,
            hidePricingEnable: hidePricingEnable,
            hideInventoryEnable: hideInventoryEnable),
      );
    } else {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }

  Future<void> placeOrder() async {
    emit(state.copyWith(status: OrderStatus.addToCartLoading));

    final result = await _savedOrderUsecase.placeOrder(cart: state.cart);

    emit(state.copyWith(status: result));
  }

  Future<void> deleteSavedOrders() async {
    emit(state.copyWith(status: OrderStatus.deleteCartLoading));

    final result =
        await _savedOrderUsecase.deleteSavedOrders(cartId: state.cart.id ?? '');

    if (result) {
      emit(state.copyWith(status: OrderStatus.deleteCartSuccess));
    } else {
      emit(state.copyWith(status: OrderStatus.deleteCartFailure));
    }
  }

  List<CartLineEntity> getCartLines() {
    List<CartLineEntity> cartlines = [];
    for (var cartLine in state.cart.cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper().toEntity(cartLine);
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

  Future<void> addToCart({required AddCartLine addCartLine}) async {
    emit(
      state.copyWith(
        status: OrderStatus.lineItemAddToCartLoading,
      ),
    );

    final newCartLine = await _savedOrderUsecase.addLineItemToCart(
      addCartLine: addCartLine,
    );

    addCartLineToCartMessageName = newCartLine == null
        ? SiteMessageConstants.nameAddToCartFail
        : SiteMessageConstants.nameAddToCartSuccess;
    addCartLineToCartDefaultMessage = newCartLine == null
        ? SiteMessageConstants.defaultValueAddToCartFail
        : SiteMessageConstants.defaultValueAddToCartSuccess;
    addCartLineToCartMessage = await _savedOrderUsecase.getSiteMessage(
          messageName: addCartLineToCartMessageName,
          defaultMessage: addCartLineToCartDefaultMessage,
        ) ??
        '';

    if (newCartLine != null && newCartLine.isQtyAdjusted == true) {
      quantityAdjustedMessage = await _savedOrderUsecase.getSiteMessage(
            messageName: SiteMessageConstants.nameAddToCartQuantityAdjusted,
            defaultMessage:
                SiteMessageConstants.defaultValueAddToCartQuantityAdjusted,
          ) ??
          '';

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

  String addCartLineToCartMessageName = '';
  String addCartLineToCartDefaultMessage = '';
  String addCartLineToCartMessage = '';
  String quantityAdjustedMessage = '';

  String get shipToLabel => state.cart.shipToLabel ?? '';

  String get orderDate => state.cart.orderDate != null
      ? DateFormat(CoreConstants.dateFormatString).format(state.cart.orderDate!)
      : '';

  String get orderSubTotalDisplay => state.cart.orderSubTotalDisplay ?? '';

  // Billing Address
  String? get billingCompanyName => state.cart.billTo?.companyName;

  String? get billingFullAddress =>
      (!(state.cart.billTo?.address1).isNullOrEmpty
          ? '${state.cart.billTo?.address1!}, '
          : '') +
      (!(state.cart.billTo?.address2).isNullOrEmpty
          ? '${state.cart.billTo?.address2!}'
          : '');

  String? get billingCityStatePostalCode =>
      '${state.cart.billTo?.city}, ${state.cart.billTo?.state?.name} ${state.cart.billTo?.postalCode}';

  // Shipping Address
  String? get shippingCompanyName => state.cart.shipTo?.companyName;

  String? get shippingFullAddress =>
      (!(state.cart.shipTo?.address1).isNullOrEmpty
          ? '${state.cart.shipTo?.address1!}, '
          : '') +
      (!(state.cart.shipTo?.address2).isNullOrEmpty
          ? '${state.cart.shipTo?.address2!}'
          : '');
  String? get shippingCityStatePostalCode =>
      '${state.cart.shipTo?.city}, ${state.cart.shipTo?.state?.name} ${state.cart.shipTo?.postalCode}';
}
