// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsDescriptionEntity extends ProductDetailsBaseEntity {
  final String htmlContent;

  const ProductDetailsDescriptionEntity(
      {required this.htmlContent, required super.detailsSectionType});

  @override
  List<Object?> get props => [htmlContent];

  @override
  ProductDetailsDescriptionEntity copyWith({
    ProdcutDeatilsPageWidgets? detailsSectionType,
    String? description,
  }) {
    return ProductDetailsDescriptionEntity(
        htmlContent: htmlContent ?? this.htmlContent,
        detailsSectionType: detailsSectionType!);
  }
}
