// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/entity/document._entity.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_base_entity.dart';

class ProductDetailsDocumentsEntity extends ProductDetailsBaseEntity {
  final String? title;
  final List<DocumentEntity>? documents;
  final List<String> documentPaths;

  const ProductDetailsDocumentsEntity({
    required this.title,
    required this.documents,
    required super.detailsSectionType,
    required this.documentPaths,
  });

  @override
  ProductDetailsDocumentsEntity copyWith({
    String? title,
    List<DocumentEntity>? documents,
    ProdcutDeatilsPageWidgets? detailsSectionType,
    List<String>? documentPaths,
  }) {
    return ProductDetailsDocumentsEntity(
      title: title ?? this.title,
      documents: documents ?? this.documents,
      detailsSectionType: detailsSectionType!,
      documentPaths: documentPaths ?? this.documentPaths,
    );
  }
}
