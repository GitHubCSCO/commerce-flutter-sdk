import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WarehouseInventoryUsecase extends BaseUseCase {
  WarehouseInventoryUsecase() : super();

  Future<RealTimeSupport?> getRealtimeSupportType() async {
    return coreServiceProvider
        .getAppConfigurationService()
        .getRealtimeSupportType();
  }

  Future<Result<GetProductResult, ErrorResponse>> getProduct(
      String? id, ProductQueryParameters? parameters) async {
    return await commerceAPIServiceProvider
        .getProductService()
        .getProduct(id ?? "", parameters: parameters);
  }

  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      getRealTimeInventory(RealTimeInventoryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(parameters: parameters);
  }
}
