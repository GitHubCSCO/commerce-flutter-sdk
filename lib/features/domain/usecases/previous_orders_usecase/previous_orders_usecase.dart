import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PreviousOrdersUseCse extends BaseUseCase {
  PreviousOrdersUseCse() : super();

  VmiLocationModel? getCurrentLocation() {
    return coreServiceProvider.getVmiService().currentVmiLocation;
  }

  Future<LatLong?> getPlaceFromAddresss(Address? address) async {
    return await coreServiceProvider
        .getVmiService()
        .getPlaceFromAddress(address);
  }

  Future<Result<List<Order>, ErrorResponse>> getPreviousOrders() async {
    List<OrderSortOrder> sortList = [
      OrderSortOrder.orderDateDescending,
      OrderSortOrder.orderErpNumberDescending,
      OrderSortOrder.orderNumberDescending
    ];

    final sortOrdersValue = sortList.map((e) => e.value).toList().join(',');
    OrdersQueryParameters parameters = OrdersQueryParameters(
      page: 1,
      pageSize: 5,
      sort: sortOrdersValue,
      vmiOrdersOnly: true,
    );

    parameters.vmiOrdersOnly = true;
    VmiLocationModel? currentLocation =
        coreServiceProvider.getVmiService().currentVmiLocation;
    if (currentLocation != null) {
      parameters.vmiLocationId = currentLocation.id;
    }

    var returnResponse = await commerceAPIServiceProvider
        .getOrderService()
        .getOrders(parameters);

    switch (returnResponse) {
      case Success(value: final data):
        return Success(data?.orders ?? []);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }


}
