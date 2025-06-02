import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/availability_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductUnitOfMeasureEntityMapper {
  static ProductUnitOfMeasureEntity toEntity(ProductUnitOfMeasure model) =>
      ProductUnitOfMeasureEntity(
        productUnitOfMeasureId: model.productUnitOfMeasureId,
        unitOfMeasure: model.unitOfMeasure,
        unitOfMeasureDisplay: model.unitOfMeasureDisplay,
        description: model.description,
        qtyPerBaseUnitOfMeasure: model.qtyPerBaseUnitOfMeasure,
        roundingRule: model.roundingRule,
        isDefault: model.isDefault,
        availability: AvailabilityEntityMapper.toEntity(model.availability ??
            Availability()), // Assuming AvailabilityEntityMapper is available
      );

  static ProductUnitOfMeasure toModel(ProductUnitOfMeasureEntity entity) =>
      ProductUnitOfMeasure(
        productUnitOfMeasureId: entity.productUnitOfMeasureId,
        unitOfMeasure: entity.unitOfMeasure,
        unitOfMeasureDisplay: entity.unitOfMeasureDisplay,
        description: entity.description,
        qtyPerBaseUnitOfMeasure: entity.qtyPerBaseUnitOfMeasure,
        roundingRule: entity.roundingRule,
        isDefault: entity.isDefault,
        availability: AvailabilityEntityMapper.toModel(
            entity.availability ?? AvailabilityEntity()),
      );
}
