import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderUsecase extends BaseUseCase {
  Future<GetOrderCollectionResultEntity?> getOrderHistory({
    int? page,
    OrderSortOrder sortOrder = OrderSortOrder.orderDateDescending,
  }) async {
    final sortOrders = commerceAPIServiceProvider
        .getOrderService()
        .getOrderListForRequest(sortOrder);

    final sortOrdersValue = sortOrders.map((e) => e.value).toList().join(',');

    final result = await commerceAPIServiceProvider.getOrderService().getOrders(
          OrdersQueryParameters(
            sort: sortOrdersValue,
            page: page,
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
}
