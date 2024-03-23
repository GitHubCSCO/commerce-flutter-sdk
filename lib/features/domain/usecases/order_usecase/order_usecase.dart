import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderUsecase extends BaseUseCase {
  Future<GetOrderCollectionResultEntity?> getOrderHistory({int? page}) async {
    // TODO - put proper implementation
    // return Future.delayed(
    //   const Duration(seconds: 1),
    //   () => [
    //     OrderEntity(
    //       webOrderNumber: 'WEB001022',
    //       orderNumberLabel: '828288282',
    //       customerPO: 'X76332',
    //       stCompanyName: 'St. George',
    //       orderDate: DateTime.tryParse('2021-07-01'),
    //       orderGrandTotalDisplay: '\$14,000.00',
    //       statusDisplay: 'Pending',
    //       webOrderNumberLabel: 'Web Order #',
    //       poNumberLabel: 'PO #',
    //     ),
    //     OrderEntity(
    //       webOrderNumber: 'WEB001023',
    //       orderNumberLabel: '828288283',
    //       customerPO: 'X76333',
    //       stCompanyName: 'St. George',
    //       orderDate: DateTime.tryParse('2021-07-02'),
    //       orderGrandTotalDisplay: '\$15,000.00',
    //       statusDisplay: 'Pending',
    //       webOrderNumberLabel: 'Web Order #',
    //       poNumberLabel: 'PO #',
    //     ),
    //   ],
    // );

    final sortOrders = commerceAPIServiceProvider
        .getOrderService()
        .getOrderListForRequest(OrderSortOrder.orderDateDescending);

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
