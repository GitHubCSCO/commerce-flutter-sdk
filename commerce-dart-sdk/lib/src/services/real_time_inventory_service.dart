import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RealTimeInventoryService extends ServiceBase
    implements IRealTimeInventoryService {
  RealTimeInventoryService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      getProductRealTimeInventory({
    RealTimeInventoryParameters? parameters,
  }) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var url = Uri.parse(CommerceAPIConstants.realTimeInventoryUrl);
      if (parameters != null) {
        url = url.replace(queryParameters: parameters.toJson());
      }

      var data = {'productIds': parameters?.productIds};
      return postAsyncNoCache<GetRealTimeInventoryResult>(
        url.toString(),
        data,
        GetRealTimeInventoryResult.fromJson,
      );
    } else {
      return Failure(ErrorResponse(message: "No internet connection"));
    }
  }
}
