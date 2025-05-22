import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IRealTimeInventoryService {
  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      getProductRealTimeInventory({RealTimeInventoryParameters? parameters});
}
