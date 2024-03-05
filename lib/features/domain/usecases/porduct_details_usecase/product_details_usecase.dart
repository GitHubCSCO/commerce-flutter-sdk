import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
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
  productDetailsGeneralInfo,
  productDetailsAddtoCart,
  productDetailsPrice,
}

class ProductDetailsUseCase extends BaseUseCase {
  late Session? session;
  late AccountSettings? accountSettings;
  late ProductSettings? productSettings;
  late ProductUnitOfMeasure? chosenUnitOfMeasure;
  late StyledProductEntity? styledProduct;
  late int? quantity;

  late ProductPriceEntity? productPricing;

  ProductDetailsUseCase(
      {this.session,
      this.accountSettings,
      this.productSettings,
      this.chosenUnitOfMeasure,
      this.quantity,
      this.productPricing,
      this.styledProduct})
      : super();

  Future<Result<ProductEntity, ErrorResponse>> getProductDetails(
      String productId) async {
    // (await this.commerceAPIServiceProvider.getCatalogpagesService()
    //     .getProductCatalogInformation(this.productParameter.urlSegment));

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
          if (productEntity.styleParentId != null) {
            styledProduct = productEntity.styledProducts
                ?.firstWhere((o) => o.productId == productEntity.id);
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

    var quantity = (product.minimumOrderQty! > 0) ? product.minimumOrderQty : 1;

    items.add(makeGeneralInfoEntity(product));
    items.add(ProductDetailsPriceEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsPrice,
        product: product,
        styledProduct: styledProduct,
        productPricingEnabled: true,
        quantity: quantity));

    items.add(ProductDetailsAddtoCartEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsAddtoCart,
        quantityText: quantity.toString()));

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
