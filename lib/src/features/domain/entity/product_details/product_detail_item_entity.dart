// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailItemEntity extends ProductDetailsBaseEntity {
  final String id;
  final String title;
  final String htmlContent;
  final double position;

  const ProductDetailItemEntity({
    required this.id,
    required this.title,
    required this.htmlContent,
    required this.position,
    required super.detailsSectionType,
  });

  @override
  ProductDetailItemEntity copyWith({
    String? id,
    ProdcutDeatilsPageWidgets? detailsSectionType,
    String? title,
    String? htmlContent,
    double? position,
  }) {
    return ProductDetailItemEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        htmlContent: htmlContent ?? this.htmlContent,
        position: position ?? this.position,
        detailsSectionType: detailsSectionType!);
  }

  @override
  List<Object?> get props => [id, title, htmlContent, position];
}
