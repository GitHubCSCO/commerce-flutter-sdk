import 'package:commerce_flutter_app/features/domain/entity/specification_entity.dart';
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
}
