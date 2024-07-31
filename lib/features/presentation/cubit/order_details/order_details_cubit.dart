import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderUsecase _orderUsecase;
  final PricingInventoryUseCase _pricingInventoryUseCase;

  OrderDetailsCubit({required OrderUsecase orderUsercase, required PricingInventoryUseCase pricingInventoryUseCase})
      : _orderUsecase = orderUsercase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          const OrderDetailsState(
            order: OrderEntity(),
            isReorderViewVisible: false,
            orderStatus: OrderStatus.initial,
            orderSettings: OrderSettingsEntity(),
          ),
        );

  Future<void> loadOrderDetails(String orderNumber, {bool? isFromVMI}) async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));

    final futureResults = await Future.wait([
      _orderUsecase.loadOrder(orderNumber),
      _orderUsecase.loadOrderSettings(),
    ]);

    final order = futureResults[0] as OrderEntity?;
    final orderSettings = futureResults[1] as OrderSettingsEntity?;

    if (order == null || orderSettings == null) {
      emit(state.copyWith(orderStatus: OrderStatus.failure));
    } else {
      final isReorderVisible = await _orderUsecase.checkReorder(
        isFromVMI ?? false,
        order: order,
        orderSettings: orderSettings,
      );

      final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
      final hideInventoryEnable = _pricingInventoryUseCase.getHideInventoryEnable();

      if (order.orderPromotions != null || order.orderPromotions!.isNotEmpty) {
        final promotionAdjustedOrder = order.copyWith(
          orderPromotions: order.orderPromotions!.map((promotion) {
            return promotion.copyWith(
              amountDisplay: (promotion.amountDisplay != null)
                  ? ('- ${promotion.amountDisplay!}')
                  : null,
              name: promotion.name != null
                  ? '${LocalizationConstants.promotion.localized()} : ${promotion.name}'
                  : null,
            );
          }).toList(),
        );

        emit(
          state.copyWith(
            order: promotionAdjustedOrder,
            orderSettings: orderSettings,
            orderStatus: OrderStatus.success,
            isReorderViewVisible: isReorderVisible,
            hidePricingEnable: hidePricingEnable,
            hideInventoryEnable: hideInventoryEnable
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          order: order,
          orderSettings: orderSettings,
          orderStatus: OrderStatus.success,
          isReorderViewVisible: isReorderVisible,
          hidePricingEnable: hidePricingEnable,
          hideInventoryEnable: hideInventoryEnable,
        ),
      );
    }
  }

  Future<void> reorderAllProducts() async {
    emit(state.copyWith(orderStatus: OrderStatus.reorderLoading));
    final result = await _orderUsecase.reorderAllProducts(
      orderLines: state.order.orderLines ?? [],
    );

    if (result == OrderStatus.success) {
      final message = await _orderUsecase.getSiteMessage(
          SiteMessageConstants.nameAddToCartSuccess,
          SiteMessageConstants.defaultValueAddToCartSuccess);
      emit(state.copyWith(orderStatus: OrderStatus.reorderSuccess, errorMessage: message));
    } else {
      final message = await _orderUsecase.getSiteMessage(
          SiteMessageConstants.nameAddToCartFail,
          SiteMessageConstants.defaultValueAddToCartFail);
      emit(state.copyWith(orderStatus: OrderStatus.reorderFailure, errorMessage: message));
    }
  }

  // Order Information
  String? get orderNumber => state.order.orderNumber;

  String? get webOrderNumber => (!state.order.erpOrderNumber.isNullOrEmpty &&
          state.orderSettings.showWebOrderNumber == true)
      ? state.order.webOrderNumber
      : null;

  String? get orderDate => state.order.orderDate != null
      ? DateFormat(CoreConstants.dateFormatShortString)
          .format(state.order.orderDate!)
      : null;

  String? get orderStatus => state.order.statusDisplay;

  String? get poNumber => (!state.order.customerPO.isNullOrEmpty &&
          state.orderSettings.showPoNumber == true)
      ? state.order.customerPO
      : null;

  String? get shippingMethod =>
      (isShippingAddressVisible && state.order.shipCode != null)
          ? state.order.shipViaDescription ?? state.order.shipCode
          : null;

  String? get terms => (!state.order.terms.isNullOrEmpty &&
          state.orderSettings.showTermsCode == true)
      ? state.order.terms
      : null;

  bool get _requestedDeliveryDateVisible =>
      state.order.requestedDeliveryDateDisplay != null;

  String? get requestedDeliveryDateTitle => _requestedDeliveryDateVisible
      ? (state.order.fulfillmentMethod == 'PickUp'
          ? LocalizationConstants.requestPickUpDate.localized()
          : LocalizationConstants.requestDeliveryDate.localized())
      : null;

  String? get requestedDeliveryDate => _requestedDeliveryDateVisible
      ? DateFormat(CoreConstants.dateFormatString)
          .format(state.order.requestedDeliveryDateDisplay!)
      : null;

  bool get isShippingAddressVisible =>
      state.order.fulfillmentMethod == 'Ship' ||
      state.order.fulfillmentMethod.isNullOrEmpty;

  // Billing Address
  String? get billingCompanyName => state.order.btCompanyName;

  String? get billingFullAddress =>
      (!state.order.btAddress1.isNullOrEmpty ? '${state.order.btAddress1!}\n' : '') +
      (!state.order.btAddress2.isNullOrEmpty
          ? '${state.order.btAddress2!}\n'
          : '') +
      ('${state.order.billToCity}, ${state.order.billToState} ${state.order.billToPostalCode}') +
      (!state.order.btCountry.isNullOrEmpty
          ? '\n${state.order.btCountry}'
          : '');

  String? get billingCountryName => state.order.btCountry;

  // Shipping Address
  String? get shippingCompanyName => state.order.stCompanyName;

  String? get shippingFullAddress =>
      (!state.order.stAddress1.isNullOrEmpty
          ? '${state.order.stAddress1!}\n'
          : '') +
      (!state.order.stAddress2.isNullOrEmpty
          ? '${state.order.stAddress2!}\n'
          : '') +
      ('${state.order.shipToCity}, ${state.order.shipToState} ${state.order.shipToPostalCode}');

  String? get shippingCountryName => state.order.stCountry;

  // Pickup Location
  bool get isPickupLocationVisible => state.order.fulfillmentMethod == 'PickUp';

  String? get pickupLocationCityStatePostalCode =>
      '${state.order.shipToCity}, ${state.order.shipToState} ${state.order.shipToPostalCode}';

  String? get pickupLocationAddress =>
      (!state.order.stCompanyName.isNullOrEmpty
          ? '${state.order.stCompanyName!}\n'
          : '') +
      (!state.order.stAddress1.isNullOrEmpty
          ? '${state.order.stAddress1!}\n'
          : '') +
      (!state.order.stAddress2.isNullOrEmpty
          ? '${state.order.stAddress2!}\n'
          : '') +
      (!pickupLocationCityStatePostalCode.isNullOrEmpty
          ? '$pickupLocationCityStatePostalCode\n'
          : '') +
      (!state.order.stCountry.isNullOrEmpty ? '${state.order.stCountry}' : '');

  // Subtotal
  String? get subTotalTitle => LocalizationConstants.subtotalItems.localized();

  String? get subTotalValue => state.order.orderSubTotalDisplay;

  String? get discountTitle => LocalizationConstants.discounts.localized();

  String? get discountValue => (state.order.orderDiscountAmount == null ||
          state.order.orderDiscountAmount! == 0)
      ? ''
      : '-${state.order.orderDiscountAmountDisplay}';

  String? get shippingHandlingTitle => LocalizationConstants.shippingHandling.localized();

  num get _shippingHandlingValue =>
      (state.order.shippingCharges ?? 0) + (state.order.handlingCharges ?? 0);
  String? get shippingHandlingValue => _shippingHandlingValue == 0
      ? ''
      : '${CoreConstants.currencySymbol}${_shippingHandlingValue.toStringAsFixed(2)}';

  String? get otherChargesTitle => LocalizationConstants.otherCharges.localized();

  String? get otherChargesValue =>
      (state.order.otherCharges == null || state.order.otherCharges! == 0)
          ? ''
          : state.order.otherChargesDisplay;

  String? get taxTitle => LocalizationConstants.tax.localized();

  String? get taxValue => state.order.totalTaxDisplay;

  String? get totalTitle => LocalizationConstants.total.localized();

  String? get totalValue => state.order.orderGrandTotalDisplay;
}
