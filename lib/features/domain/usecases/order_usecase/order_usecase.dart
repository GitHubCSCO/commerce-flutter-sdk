import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/order_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/settings_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
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
  }) async {
    final sortOrders = commerceAPIServiceProvider
        .getOrderService()
        .getOrderListForRequest(sortOrder);

    final sortOrdersValue = sortOrders.map((e) => e.value).toList().join(',');

    final result = await commerceAPIServiceProvider.getOrderService().getOrders(
          OrdersQueryParameters(
            sort: sortOrdersValue,
            page: page,
            showMyOrders: showMyOrders,
            status: filterAttributes.isEmpty ? null : filterAttributes,
          ),
        );

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

  Future<bool> checkReorder({
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

    /// TODO - check VMI location as well
    // if (vmiLocation != null) {
    //   hasReorder = false;
    // }

    return hasReorder;
  }
}
