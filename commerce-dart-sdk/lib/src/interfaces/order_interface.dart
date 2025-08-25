import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IOrderService {
  List<OrderSortOrder> get availableSortOrders;

  List<OrderSortOrder> getOrderListForRequest(OrderSortOrder sortOrder);

  Future<Result<GetOrderCollectionResult, ErrorResponse>> getOrders(
      OrdersQueryParameters parameters);

  Future<Result<GetOrderApprovalCollectionResult, ErrorResponse>>
      getOrderApprovalList(OrderApprovalParameters parameters);

  Future<Result<Cart, ErrorResponse>> getOrderApproval(String orderId);

  Future<Result<Order, ErrorResponse>> getOrder(String orderNumber);

  Future<Result<Order, ErrorResponse>> patchOrder(Order order);

  Future<Result<String, ErrorResponse>> postOrderReturns(
      String orderId, Rma rmaReturn);

  Future<Result<ShareEntity, ErrorResponse>> shareOrder(ShareOrder order);

  Future<Result<List<OrderStatusMapping>, ErrorResponse>>
      getOrderStatusMappings();

  late List<String> selectedFilterValueIds;

  late int selectedFiltersCount;

  late bool showMyOrders;
}
