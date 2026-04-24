import 'package:commerce_flutter_sdk/src/features/domain/entity/specification_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SpecificationEntityMapper {
  SpecificationEntity toEntity(Specification model) => SpecificationEntity(
        specificationId: model.id,
        name: model.name,
        nameDisplay: model.nameDisplay,
        value: model.value,
        description: model.description,
        sortOrder: model.sortOrder,
        htmlContent: model.htmlContent,
        isActive: null,
        parentSpecification: null,
        specifications: null,
      );

  Specification toModel(SpecificationEntity entity) => Specification(
        id: entity.specificationId,
        name: entity.name,
        nameDisplay: entity.nameDisplay,
        value: entity.value,
        description: entity.description,
        sortOrder: entity.sortOrder,
        htmlContent: entity.htmlContent,
      );
}
