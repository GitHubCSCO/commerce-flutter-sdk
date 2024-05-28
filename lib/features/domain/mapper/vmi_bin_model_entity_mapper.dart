import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiBinModelEntityMapper {
  VmiBinModelEntity toEntity(VmiBinModel model) => VmiBinModelEntity(
        id: model.id,
        vmiLocationId: model.vmiLocationId,
        binNumber: model.binNumber,
        productId: model.productId,
        minimumQty: model.minimumQty,
        maximumQty: model.maximumQty,
        lastCountDate: model.lastCountDate,
        lastCountQty: model.lastCountQty,
        lastCountUserName: model.lastCountUserName,
        previousCountDate: model.previousCountDate,
        previousCountQty: model.previousCountQty,
        previousCountUserName: model.previousCountUserName,
        lastOrderDate: model.lastOrderDate,
        productEntity: model.product != null
            ? ProductEntityMapper().toEntity(model.product!)
            : null,
      );

  VmiBinModel fromEntity(VmiBinModelEntity entity) => VmiBinModel(
        id: entity.id,
        vmiLocationId: entity.vmiLocationId,
        binNumber: entity.binNumber,
        productId: entity.productId,
        minimumQty: entity.minimumQty,
        maximumQty: entity.maximumQty,
        lastCountDate: entity.lastCountDate,
        lastCountQty: entity.lastCountQty,
        lastCountUserName: entity.lastCountUserName,
        previousCountDate: entity.previousCountDate,
        previousCountQty: entity.previousCountQty,
        previousCountUserName: entity.previousCountUserName,
        lastOrderDate: entity.lastOrderDate,
        product: entity.productEntity != null
            ? ProductEntityMapper().toModel(entity.productEntity!)
            : null,
      );
}
