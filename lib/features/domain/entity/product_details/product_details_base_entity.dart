// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsBaseEntity extends Equatable {
  final ProdcutDeatilsPageWidgets detailsSectionType;
  const ProductDetailsBaseEntity({
    required this.detailsSectionType,
  });

  @override
  List<Object?> get props => [detailsSectionType];

  ProductDetailsBaseEntity copyWith({
    ProdcutDeatilsPageWidgets? detailsSectionType,
  }) {
    return ProductDetailsBaseEntity(
      detailsSectionType: detailsSectionType ?? this.detailsSectionType,
    );
  }
}
