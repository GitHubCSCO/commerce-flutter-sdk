import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WarehouseService extends ServiceBase implements IWarehouseService {
  WarehouseService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<GetWarehouseCollectionResult, ErrorResponse>> getWarehouses(
      {WarehousesQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.warehousesUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<GetWarehouseCollectionResult>(
      url.toString(),
      GetWarehouseCollectionResult.fromJson,
    );
  }
}
