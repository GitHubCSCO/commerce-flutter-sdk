import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsGeneralInfoEntity extends ProductDetailsBaseEntity {
  final String? productNumber;
  final List<ProductImageEntity>? thumbnails;
  final String? productName;
  final String? originalPartNumberValue;
  final String? myPartNumberValue;
  final String? mFGNumberValue;
  final String? packDescriptionValue;
  final bool? hasMultipleImages;
  final bool? productInformationWasUpdated;
  final String? brandName;
  final String? brandImage;
  final String? packDescriptionTitle;
  final String? mFGNumberTitle;
  final String? myPartNumberTitle;

  const ProductDetailsGeneralInfoEntity({
    this.productNumber,
    this.thumbnails,
    this.productName,
    this.originalPartNumberValue,
    this.myPartNumberValue,
    this.mFGNumberValue,
    this.packDescriptionValue,
    this.hasMultipleImages,
    this.productInformationWasUpdated,
    this.brandName,
    this.brandImage,
    this.packDescriptionTitle,
    this.mFGNumberTitle,
    this.myPartNumberTitle,
    required super.detailsSectionType,
  });

  @override
  ProductDetailsGeneralInfoEntity copyWith({
    ProdcutDeatilsPageWidgets? detailsSectionType,
    String? productNumber,
    List<ProductImageEntity>? thumbnails,
    String? productName,
    String? originalPartNumberValue,
    String? myPartNumberValue,
    String? mFGNumberValue,
    String? packDescriptionValue,
    bool? hasMultipleImages,
    bool? productInformationWasUpdated,
    String? brandName,
    String? brandImage,
    String? packDescriptionTitle,
    String? mFGNumberTitle,
    String? myPartNumberTitle,
  }) {
    return ProductDetailsGeneralInfoEntity(
        productNumber: productNumber ?? this.productNumber,
        thumbnails: thumbnails ?? this.thumbnails,
        productName: productName ?? this.productName,
        originalPartNumberValue:
            originalPartNumberValue ?? this.originalPartNumberValue,
        myPartNumberValue: myPartNumberValue ?? this.myPartNumberValue,
        mFGNumberValue: mFGNumberValue ?? this.mFGNumberValue,
        packDescriptionValue: packDescriptionValue ?? this.packDescriptionValue,
        hasMultipleImages: hasMultipleImages ?? this.hasMultipleImages,
        productInformationWasUpdated:
            productInformationWasUpdated ?? this.productInformationWasUpdated,
        brandName: brandName ?? this.brandName,
        brandImage: brandImage ?? this.brandImage,
        packDescriptionTitle: packDescriptionTitle ?? this.packDescriptionTitle,
        mFGNumberTitle: mFGNumberTitle ?? this.mFGNumberTitle,
        myPartNumberTitle: myPartNumberTitle ?? this.myPartNumberTitle,
        detailsSectionType: detailsSectionType ?? this.detailsSectionType);
  }
}
