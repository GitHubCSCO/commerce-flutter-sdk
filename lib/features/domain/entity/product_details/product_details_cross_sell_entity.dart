import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsCrossSellEntity extends ProductDetailsBaseEntity {
  final ProductCarouselWidgetEntity? productCarouselWidgetEntity;

  const ProductDetailsCrossSellEntity({
    this.productCarouselWidgetEntity,
    required super.detailsSectionType,
  });

  @override
  ProductDetailsCrossSellEntity copyWith({
    ProductCarouselWidgetEntity? productCarouselWidgetEntity,
    ProdcutDeatilsPageWidgets? detailsSectionType,
  }) {
    return ProductDetailsCrossSellEntity(
        productCarouselWidgetEntity: productCarouselWidgetEntity,
        detailsSectionType: detailsSectionType!);
  }
}
