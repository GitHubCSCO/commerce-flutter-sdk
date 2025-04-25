import 'package:commerce_flutter_sdk/features/domain/entity/specification_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SpecificationEntityMapper {
  SpecificationEntity toEntity(Specification model) => SpecificationEntity(
        specificationId: model.specificationId,
        name: model.name,
        nameDisplay: model.nameDisplay,
        value: model.value,
        description: model.description,
        sortOrder: model.sortOrder,
        isActive: model.isActive,
        parentSpecification: model.parentSpecification != null
            ? toEntity(model.parentSpecification ?? Specification())
            : null,
        htmlContent: model.htmlContent,
        specifications: model.specifications != null
            ? toEntity(model.specifications ?? Specification())
            : null,
      );

  Specification toModel(SpecificationEntity entity) => Specification(
        specificationId: entity.specificationId,
        name: entity.name,
        nameDisplay: entity.nameDisplay,
        value: entity.value,
        description: entity.description,
        sortOrder: entity.sortOrder,
        isActive: entity.isActive,
        parentSpecification: entity.parentSpecification != null
            ? SpecificationEntityMapper()
                .toModel(entity.parentSpecification ?? SpecificationEntity())
            : null,
        htmlContent: entity.htmlContent,
        specifications: entity.specifications != null
            ? SpecificationEntityMapper()
                .toModel(entity.specifications ?? SpecificationEntity())
            : null,
      );
}
