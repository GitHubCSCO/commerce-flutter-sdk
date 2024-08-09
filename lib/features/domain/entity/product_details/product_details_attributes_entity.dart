import 'package:commerce_flutter_app/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';

class ProductDetailsAttributesEntity extends ProductDetailsBaseEntity {
  final List<AttributeTypeEntity> productAttributes;

  const ProductDetailsAttributesEntity(
      {required super.detailsSectionType, required this.productAttributes});

  @override
  ProductDetailsAttributesEntity copyWith({
    List<AttributeTypeEntity>? productAttributes,
    ProdcutDeatilsPageWidgets? detailsSectionType,
  }) {
    return ProductDetailsAttributesEntity(
      productAttributes: productAttributes ?? this.productAttributes,
      detailsSectionType: detailsSectionType ?? super.detailsSectionType,
    );
  }
}
