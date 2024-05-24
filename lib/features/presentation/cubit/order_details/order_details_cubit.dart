import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderUsecase _orderUsecase;
  OrderDetailsCubit({required OrderUsecase orderUsercase})
      : _orderUsecase = orderUsercase,
        super(
          const OrderDetailsState(
            order: OrderEntity(),
            isReorderViewVisible: false,
            orderStatus: OrderStatus.initial,
            orderSettings: OrderSettingsEntity(),
          ),
        );

  Future<void> loadOrderDetails(String orderNumber) async {
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
      emit(
        state.copyWith(
          order: order,
          orderSettings: orderSettings,
          orderStatus: OrderStatus.success,
        ),
      );
    }
  }

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
          ? LocalizationConstants.requestPickUpDate
          : LocalizationConstants.requestDeliveryDate)
      : null;

  String? get requestedDeliveryDate => _requestedDeliveryDateVisible
      ? DateFormat(CoreConstants.dateFormatString)
          .format(state.order.requestedDeliveryDateDisplay!)
      : null;

  bool get isShippingAddressVisible =>
      state.order.fulfillmentMethod == 'Ship' ||
      state.order.fulfillmentMethod.isNullOrEmpty;

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
}
