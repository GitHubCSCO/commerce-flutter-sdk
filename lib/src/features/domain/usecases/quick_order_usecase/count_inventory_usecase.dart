import 'package:commerce_flutter_sdk/src/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CountInventoryUseCase extends BaseUseCase {
  Future<Result<VmiCountModel, ErrorResponse>> saveBinCount(
      VmiBinModelEntity vmiBinEntity, int qty) async {
    final vmiLocationId =
        coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '';
    final countModel = VmiCountModel(
        vmiBinId: vmiBinEntity.id,
        productId: vmiBinEntity.productId,
        count: qty.toDouble());

    final result = await commerceAPIServiceProvider
        .getVmiLocationsService()
        .saveBinCount(vmiLocationId, vmiBinEntity.id, countModel);
    return result;
  }
}
