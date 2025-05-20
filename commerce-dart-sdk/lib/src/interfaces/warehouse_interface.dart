import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IWarehouseService {
  Future<Result<GetWarehouseCollectionResult, ErrorResponse>> getWarehouses(
      {WarehousesQueryParameters? parameters});
}
