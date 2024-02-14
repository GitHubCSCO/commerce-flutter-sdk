import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum ProdcutDeatilsPageWidgets {
  productDetailsDescription,
  productDetailsSpecification,
  productDetailsGeneralInfo
}

class ProductDetailsUseCase extends BaseUseCase {
  late ProductEntity? productParameter;
  late Session? session;
  late AccountSettings? accountSettings;
  late ProductSettings? productSettings;
  late ProductUnitOfMeasure? chosenUnitOfMeasure;
  late StyledProductEntity? styledProduct;

  ProductDetailsUseCase(
      {this.productParameter,
      this.session,
      this.accountSettings,
      this.productSettings,
      this.chosenUnitOfMeasure,
      this.styledProduct})
      : super();

  Future<Result<ProductEntity, ErrorResponse>> getProductDetails(
      ProductEntity productParameter) async {
    // (await this.commerceAPIServiceProvider.getCatalogpagesService()
    //     .getProductCatalogInformation(this.productParameter.urlSegment));

    this.productParameter = productParameter;
    String? productId =
        this.productParameter?.styleParentId ?? this.productParameter?.id;

    if (productId == null) {
      return Failure(ErrorResponse(message: "Product id is null"));
    }

    // var includeAlternateInventory =
    //     !this.accountSettings.EnableWarehousePickup ||
    //         this.session.FulfillmentMethod != "PickUp";

    var includeAlternateInventory = true;

    var parameters = ProductQueryParameters(
      addToRecentlyViewed: true,
      applyPersonalization: true,
      includeAttributes: "IncludeOnProduct",
      includeAlternateInventory: includeAlternateInventory,
      expand:
          "documents,specifications,styledproducts,htmlcontent,attributes,crosssells,pricing,brand",
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProduct(productId, parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        final productEntity =
            ProductEntityMapper().toEntity(data?.product ?? Product());
        if (productEntity.styledProducts != null) {
          if (productParameter.styleParentId != null) {
            styledProduct = productEntity.styledProducts
                ?.firstWhere((o) => o.productId == this.productParameter?.id);
          }
        }
        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  List<ProductImageEntity> makeProductImages(ProductEntity product) {
    List<ProductImageEntity> result;
    var correctProductImages = styledProduct?.productImages != null
        ? styledProduct?.productImages
        : product.productImages;

    if (correctProductImages != null && correctProductImages.isNotEmpty) {
      correctProductImages
          .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
      result = correctProductImages.toList().map((s) {
        s.smallImagePath.makeImageUrl();
        s.mediumImagePath.makeImageUrl();
        s.largeImagePath.makeImageUrl();
        return s;
      }).toList();
    } else {
      var imageNotFoundImage = ProductImageEntity(
        smallImagePath: (styledProduct != null
            ? styledProduct?.smallImagePath
            : product.smallImagePath),
        mediumImagePath: (styledProduct != null
            ? styledProduct?.mediumImagePath
            : product.mediumImagePath),
        largeImagePath: (styledProduct != null
            ? styledProduct?.largeImagePath
            : product.largeImagePath),
      );
      imageNotFoundImage.smallImagePath.makeImageUrl();
      imageNotFoundImage.mediumImagePath.makeImageUrl();
      imageNotFoundImage.largeImagePath.makeImageUrl();
      result = [imageNotFoundImage];
    }

    return result;
  }

  ProductDetailsGeneralInfoEntity makeGeneralInfoEntity(ProductEntity product) {
    var genralInfoEntity = ProductDetailsGeneralInfoEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsGeneralInfo,
        productNumber: product.getProductNumber(),
        myPartNumberValue: product.customerName,
        mFGNumberValue: product.manufacturerItem,
        packDescriptionValue: product.packDescription,
        brandName: product.brand?.logoSmallImagePath == null
            ? product.brand?.name
            : product.brand?.logoSmallImagePath.makeImageUrl());

    genralInfoEntity = updateGeneralInfoViewModel(product, genralInfoEntity);
    return genralInfoEntity;
  }

  ProductDetailsGeneralInfoEntity updateGeneralInfoViewModel(
      ProductEntity product, ProductDetailsGeneralInfoEntity genralInfoEntity) {
    genralInfoEntity = genralInfoEntity.copyWith(
        productName: styledProduct == null
            ? product.shortDescription
            : styledProduct?.shortDescription);
    genralInfoEntity = genralInfoEntity.copyWith(
        originalPartNumberValue: styledProduct == null
            ? product.getProductNumber()
            : styledProduct.getProductNumber());
    genralInfoEntity =
        genralInfoEntity.copyWith(thumbnails: makeProductImages(product));
    genralInfoEntity = genralInfoEntity.copyWith(
        hasMultipleImages: (product.productImages?.length ?? 0) > 1);
    genralInfoEntity =
        genralInfoEntity.copyWith(productInformationWasUpdated: true);

    genralInfoEntity = genralInfoEntity.copyWith(
        myPartNumberTitle: LocalizationConstants.myPartNumberSign);
    genralInfoEntity = genralInfoEntity.copyWith(
        mFGNumberTitle: LocalizationConstants.myPartNumberSign);
    genralInfoEntity = genralInfoEntity.copyWith(
        packDescriptionTitle: LocalizationConstants.packDescription);

    return genralInfoEntity;
  }

  List<ProductDetailsBaseEntity> makeAllDetailsItems(ProductEntity product) {
    List<ProductDetailsBaseEntity> items = [];

    items.add(makeGeneralInfoEntity(product));

    if (product.htmlContent != null) {
      items.add(ProductDetailsDescriptionEntity(
          htmlContent: product.htmlContent ?? '',
          detailsSectionType:
              ProdcutDeatilsPageWidgets.productDetailsDescription));
    }

    if (product.specifications != null) {
      List<SpecificationEntity> specifications = product.specifications!;
      specifications
          .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));

      List<ProductDetailItemEntity> specificationItems = specifications
          .map((specification) => ProductDetailItemEntity(
                id: specification.specificationId ?? '',
                title: specification.nameDisplay ?? '',
                htmlContent: specification.htmlContent ?? '',
                position: specification.sortOrder ??
                    0, // You need to provide a list here
                detailsSectionType: ProdcutDeatilsPageWidgets
                    .productDetailsSpecification, // You need to provide a type here
              ))
          .toList();

      items.addAll(specificationItems);
    }
    return items;
  }
}
