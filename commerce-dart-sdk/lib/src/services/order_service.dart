import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderService extends ServiceBase implements IOrderService {
  OrderService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  late List<String> selectedFilterValueIds = <String>[];

  @override
  late int selectedFiltersCount;

  @override
  late bool showMyOrders;

  /// Gets all available sort order options.
  @override
  List<OrderSortOrder> get availableSortOrders => OrderSortOrder.values
      .where(
        (element) => element.sortOrderOptions != SortOrderOptions.doNotDisplay,
      )
      .toList();

  @override
  Future<Result<Order, ErrorResponse>> getOrder(String orderNumber) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.ordersUrl}/$orderNumber?expand=orderlines,shipments');

    return await getAsyncNoCache<Order>(
      url.toString(),
      Order.fromJson,
    );
  }

  @override
  Future<Result<Cart, ErrorResponse>> getOrderApproval(String orderId) async {
    var url = Uri.parse('${CommerceAPIConstants.orderApprovalsUrl}/$orderId');
    return await getAsyncNoCache<Cart>(url.toString(), Cart.fromJson);
  }

  @override
  Future<Result<GetOrderApprovalCollectionResult, ErrorResponse>>
      getOrderApprovalList(
    OrderApprovalParameters parameters,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.orderApprovalsUrl);
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetOrderApprovalCollectionResult>(
      url.toString(),
      GetOrderApprovalCollectionResult.fromJson,
    );
  }

  // Gets order list for api with selected order.
  ///
  /// [sortOrder] - target order.
  /// Returns [List<OrderSortOrder>] - list of orders for request API.
  @override
  List<OrderSortOrder> getOrderListForRequest(OrderSortOrder sortOrder) {
    switch (sortOrder) {
      case OrderSortOrder.orderDateAscending:
        return <OrderSortOrder>[
          sortOrder,
          OrderSortOrder.orderErpNumberAscending,
          OrderSortOrder.orderNumberAscending,
        ];
      case OrderSortOrder.orderDateDescending:
        return <OrderSortOrder>[
          sortOrder,
          OrderSortOrder.orderErpNumberDescending,
          OrderSortOrder.orderNumberDescending
        ];
      default:
        return <OrderSortOrder>[sortOrder];
    }
  }

  @override
  Future<Result<List<OrderStatusMapping>, ErrorResponse>>
      getOrderStatusMappings() async {
    var url = Uri.parse(CommerceAPIConstants.orderStatusMappingsUrl);
    var response = await getAsyncNoCache(
      url.toString(),
      GetOrderStatusMappingsResult.fromJson,
    );

    switch (response) {
      case Success(value: final value):
        {
          return Success(value?.orderStatusMappings);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetOrderCollectionResult, ErrorResponse>> getOrders(
    OrdersQueryParameters parameters,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.ordersUrl);
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetOrderCollectionResult>(
        url.toString(), GetOrderCollectionResult.fromJson);
  }

  @override
  Future<Result<Order, ErrorResponse>> patchOrder(Order order) async {
    final data = order.toJson();
    final orderNumber = (order.webOrderNumber.isNullOrEmpty)
        ? (order.erpOrderNumber ?? '')
        : order.webOrderNumber!;
    var url = Uri.parse('${CommerceAPIConstants.ordersUrl}/$orderNumber');
    return await patchAsyncNoCache<Order>(
      url.toString(),
      data,
      Order.fromJson,
    );
  }

  @override
  Future<Result<Rma, ErrorResponse>> postOrderReturns(
    String? orderId,
    Rma rmaReturn,
  ) async {
    final data = rmaReturn.toJson();
    var url = Uri.parse('${CommerceAPIConstants.ordersUrl}/$orderId/returns');
    return await postAsyncNoCache<Rma>(
      url.toString(),
      data,
      Rma.fromJson,
    );
  }

  @override
  Future<Result<ShareEntity, ErrorResponse>> shareOrder(
      ShareOrder order) async {
    final data = order.toJson();
    var url = Uri.parse(CommerceAPIConstants.ordersShareUrl);
    return await postAsyncNoCache<ShareEntity>(
      url.toString(),
      data,
      ShareEntity.fromJson,
    );
  }
}
