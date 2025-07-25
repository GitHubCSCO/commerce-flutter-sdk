import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/settings_entity_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/filter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:collection/collection.dart';

class OrderUsecase extends BaseUseCase {
  List<OrderSortOrder> get availableSortOrders =>
      commerceAPIServiceProvider.getOrderService().availableSortOrders;

  Future<GetOrderCollectionResultEntity?> getOrderHistory({
    int? page,
    OrderSortOrder sortOrder = OrderSortOrder.orderDateDescending,
    bool showMyOrders = false,
    List<String> filterAttributes = const [],
    bool isFromVMI = false,
    required String searchText,
  }) async {
    final sortOrders = commerceAPIServiceProvider
        .getOrderService()
        .getOrderListForRequest(sortOrder);

    final sortOrdersValue = sortOrders.map((e) => e.value).toList().join(',');

    final result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrders(OrdersQueryParameters(
          sort: sortOrdersValue,
          page: page,
          pageSize: CoreConstants.defaultPageSize,
          showMyOrders: showMyOrders,
          status: filterAttributes.isEmpty ? null : filterAttributes,
          search: searchText != '' ? searchText : null,
          vmiOrdersOnly: isFromVMI,
          vmiLocationId: isFromVMI ? getCurrentLocation()?.id : null,
        ));

    switch (result) {
      case Success(value: final value):
        return GetOrderCollectionResultEntity(
          pagination: value?.pagination != null
              ? PaginationEntityMapper.toEntity(value!.pagination!)
              : null,
          orders: value?.orders
              ?.map((order) => OrderEntityMapper.toEntity(order))
              .toList(),
          showErpOrderNumber: value?.showErpOrderNumber,
        );
      case Failure():
        return null;
    }
  }

  Future<List<FilterValueViewModel>?> getFilterValues() async {
    final result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrderStatusMappings();
    switch (result) {
      case Success(value: final value):
        final filterValues =
            groupBy(value ?? <OrderStatusMapping>[], (e) => e.displayName)
                .values
                .map((e) => e.first)
                .map((e) => FilterValueViewModel(
                      id: e.erpOrderStatus ?? '',
                      title: e.displayName ?? '',
                    ))
                .toList()
              ..sort((a, b) => a.title.compareTo(b.title));
        return filterValues;
      case Failure():
        return null;
    }
  }

  Future<OrderSettingsEntity?> loadOrderSettings() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getSettingsAsync();
    switch (result) {
      case Success(value: final value):
        final orderSettings = value?.settingsCollection?.orderSettings;
        return orderSettings != null
            ? OrderSettingsEntityMapper.toEntity(orderSettings)
            : null;
      case Failure():
        return null;
    }
  }

  Future<OrderEntity?> loadOrder(String orderNumber) async {
    final result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrder(orderNumber);
    switch (result) {
      case Success(value: final value):
        return value != null ? OrderEntityMapper.toEntity(value) : null;
      case Failure():
        return null;
    }
  }

  Future<bool> checkReorder(
    bool isFromVMI, {
    OrderSettingsEntity? orderSettings,
    OrderEntity? order,
  }) async {
    var hasReorder =
        await coreServiceProvider.getAppConfigurationService().hasCheckout();

    if (orderSettings != null) {
      hasReorder &= (orderSettings.canReorderItems == true) &&
          (order?.canAddToCart == true);
    } else {
      hasReorder &= (order?.canAddToCart == true);
    }

    if (isFromVMI) {
      hasReorder = false;
    }

    return hasReorder;
  }

  Future<OrderEntity?> patchOrder(OrderEntity? order) async {
    if (order == null) {
      return null;
    }
    final result = await commerceAPIServiceProvider
        .getOrderService()
        .patchOrder(OrderEntityMapper.toModel(order));
    switch (result) {
      case Success(value: final value):
        return value != null ? OrderEntityMapper.toEntity(value) : null;
      case Failure():
        return null;
    }
  }

  Future<Rma?> postOrderReturns(String orderId, Rma? rma) async {
    if (rma == null) {
      return null;
    }
    final result = await commerceAPIServiceProvider
        .getOrderService()
        .postOrderReturns(orderId, rma);
    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  /// Refresh the Cart after calling this method
  Future<OrderStatus> reorderAllProducts({
    required List<OrderLineEntity> orderLines,
  }) async {
    if (orderLines.isEmpty) {
      return OrderStatus.failure;
    }
    final addCartLines = orderLines
        .map(
          (orderLine) => AddCartLine(
            productId: orderLine.productId,
            qtyOrdered: orderLine.qtyOrdered,
            unitOfMeasure: orderLine.unitOfMeasure,
          ),
        )
        .toList();

    final result = await commerceAPIServiceProvider
        .getCartService()
        .addCartLineCollection(addCartLines);

    switch (result) {
      case Success(value: final value):
        if (value == null || value.isEmpty) {
          return OrderStatus.failure;
        } else {
          return OrderStatus.success;
        }
      case Failure():
        return OrderStatus.failure;
    }
  }

  VmiLocationModel? getCurrentLocation() {
    return coreServiceProvider.getVmiService().currentVmiLocation;
  }
}
