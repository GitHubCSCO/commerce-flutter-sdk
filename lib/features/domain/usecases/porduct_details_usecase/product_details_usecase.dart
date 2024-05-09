import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_cross_sell_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_standard_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum ProdcutDeatilsPageWidgets {
  productDetailsDescription,
  productDetailsSpecification,
  productDetailsGeneralInfo,
  productDetailsAddtoCart,
  productDetailsPrice,
  productDeatilsStanddardConfigurationSection,
  productDetailsCrossSellSection,
  productDetailsStyleTraits
}

class ProductDetailsUseCase extends BaseUseCase {
  ProductDetailsUseCase() : super();

  Future<bool> hasCheckout() {
    return coreServiceProvider.getAppConfigurationService().hasCheckout();
  }

  Future<RealTimeSupport?> getRealtimeSupportType() async {
    return coreServiceProvider
        .getAppConfigurationService()
        .getRealtimeSupportType();
  }

  Future<bool?> productPricingEnabled() async {
    return coreServiceProvider
        .getAppConfigurationService()
        .productPricingEnabled();
  }

  Future<Result<AccountSettings, ErrorResponse>>
      getCurrentAccountSettings() async {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getAccountSettingsAsync();
  }

  Future<bool?> addToCartEnabled() async {
    return coreServiceProvider.getAppConfigurationService().addToCartEnabled();
  }

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return commerceAPIServiceProvider.getSessionService().getCurrentSession();
  }

  Future<Result<ProductSettings, ErrorResponse>> loadSetting() async {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<Result<ProductEntity, ErrorResponse>> getProductDetails(
      String productId,
      ProductEntity? product,
      AccountSettings accountSettings,
      Session session) async {
    if (productId.isNullOrEmpty) {
      var urlSegment = product?.urlSegment ?? '';
      var response = await commerceAPIServiceProvider
          .getCatalogpagesService()
          .getProductCatalogInformation(urlSegment);
      switch (response) {
        case Success(value: final data):
          productId = data?.productId ?? '';
          break;
        case Failure(errorResponse: final errorResponse):
          return Failure(errorResponse);
      }

      if (productId.isNullOrEmpty) {
        return Failure(ErrorResponse(message: "Product id is null"));
      }
    }

    var includeAlternateInventory = !accountSettings.enableWarehousePickup! ||
        session.fulfillmentMethod != "PickUp";

    var parameters = ProductQueryParameters(
      addToRecentlyViewed: true,
      applyPersonalization: true,
      includeAttributes: "IncludeOnProduct",
      includeAlternateInventory: includeAlternateInventory,
      productId: productId,
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

        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  List<ProductImageEntity> makeProductImages(
      ProductEntity product, StyledProductEntity? styledProduct) {
    List<ProductImageEntity> result;
    var correctProductImages =
        styledProduct?.productImages ?? product.productImages;

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
            ? styledProduct.smallImagePath
            : product.smallImagePath),
        mediumImagePath: (styledProduct != null
            ? styledProduct.mediumImagePath
            : product.mediumImagePath),
        largeImagePath: (styledProduct != null
            ? styledProduct.largeImagePath
            : product.largeImagePath),
      );
      imageNotFoundImage.smallImagePath.makeImageUrl();
      imageNotFoundImage.mediumImagePath.makeImageUrl();
      imageNotFoundImage.largeImagePath.makeImageUrl();
      result = [imageNotFoundImage];
    }

    return result;
  }

  ProductDetailsGeneralInfoEntity makeGeneralInfoEntity(
      ProductEntity product, StyledProductEntity? styledProduct) {
    var genralInfoEntity = ProductDetailsGeneralInfoEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsGeneralInfo,
        productNumber: product.getProductNumber(),
        myPartNumberValue: product.customerName,
        mFGNumberValue: product.manufacturerItem,
        packDescriptionValue: product.packDescription,
        brandName: product.brand?.logoSmallImagePath == null
            ? product.brand?.name
            : product.brand?.logoSmallImagePath.makeImageUrl());

    genralInfoEntity =
        updateGeneralInfoViewModel(product, styledProduct, genralInfoEntity);
    return genralInfoEntity;
  }

  ProductDetailsGeneralInfoEntity updateGeneralInfoViewModel(
      ProductEntity product,
      StyledProductEntity? styledProduct,
      ProductDetailsGeneralInfoEntity genralInfoEntity) {
    genralInfoEntity = genralInfoEntity.copyWith(
        productName: styledProduct == null
            ? product.shortDescription
            : styledProduct.shortDescription);
    genralInfoEntity = genralInfoEntity.copyWith(
        originalPartNumberValue: styledProduct == null
            ? product.getProductNumber()
            : styledProduct.getProductNumber());
    genralInfoEntity = genralInfoEntity.copyWith(
        thumbnails: makeProductImages(product, styledProduct));
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

  List<ProductDetailsBaseEntity> makeAllDetailsItems(
      ProductEntity product,
      StyledProductEntity? styledProduct,
      bool productPricingEnabled,
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    List<ProductDetailsBaseEntity> items = [];

    var quantity = getQuantity(product);
    items.add(makeGeneralInfoEntity(product, styledProduct));
    items.add(makeProductDetailsPriceEntity());

    if (shouldAddConfigSection(product)) {
      items.add(addConfigSection(product));
    }

    if (product.styleTraits != null && product.styleTraits!.isNotEmpty) {
      items.add(makeProductDetailsStyleTraitsEntity(
          product, availableStyleValues, selectedStyleValues));
    }
    items.add(makeProductDetailsAddToCartEntity(quantity));

    if (product.htmlContent != null) {
      items.add(makeProductDetailsDescriptionEntity(product));
    }

    if (product.specifications != null) {
      items.addAll(addSpecifications(product));
    }

    if (product.crossSells != null && product.crossSells!.isNotEmpty) {
      var porductCarouselWidget = ProductCarouselWidgetEntity(
          carouselType: ProductCarouselType.webCrossSells,
          title: LocalizationConstants.recommendedProducts);

      final List<ProductCarouselEntity> productCarouselList = [];
      for (var crosSell in product.crossSells!) {
        productCarouselList.add(ProductCarouselEntity(
            product: crosSell, productPricingEnabled: productPricingEnabled));
      }

      porductCarouselWidget = porductCarouselWidget.copyWith(
          productCarouselList: productCarouselList);
      items.add(ProductDetailsCrossSellEntity(
          detailsSectionType:
              ProdcutDeatilsPageWidgets.productDetailsCrossSellSection,
          productCarouselWidgetEntity: porductCarouselWidget));
    }
    return items;
  }

  int getQuantity(ProductEntity product) {
    return (product.minimumOrderQty! > 0) ? product.minimumOrderQty! : 1;
  }

  ProductDetailsPriceEntity makeProductDetailsPriceEntity() {
    return const ProductDetailsPriceEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsPrice);
  }

  bool shouldAddConfigSection(ProductEntity product) {
    return !(product.styleTraits != null && product.styleTraits!.isNotEmpty) &&
        product.configurationDto != null &&
        product.configurationDto!.sections != null &&
        product.configurationDto!.sections!.isNotEmpty &&
        !product.isFixedConfiguration!;
  }

  ProductDetailsAddtoCartEntity makeProductDetailsAddToCartEntity(
      int quantity) {
    return ProductDetailsAddtoCartEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsAddtoCart,
        quantityText: quantity.toString());
  }

  ProductDetailsDescriptionEntity makeProductDetailsDescriptionEntity(
      ProductEntity product) {
    return ProductDetailsDescriptionEntity(
        htmlContent: product.htmlContent ?? '',
        detailsSectionType:
            ProdcutDeatilsPageWidgets.productDetailsDescription);
  }

  ProductDetailsStandardConfigurationEntity addConfigSection(
      ProductEntity product) {
    for (var index = 0;
        index < product.configurationDto!.sections!.length;
        index++) {
      var configSection = product.configurationDto!.sections![index];
      var option = ConfigSectionOptionEntity(
          sectionName: configSection.sectionName,
          description:
              "${LocalizationConstants.selectSomething} ${configSection.sectionName!}");
      product.configurationDto!.sections![index].options!.insert(0, option);
    }
    return ProductDetailsStandardConfigurationEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets
            .productDeatilsStanddardConfigurationSection,
        configSectionOptions: product.configurationDto!.sections);
  }

  List<ProductDetailItemEntity> addSpecifications(ProductEntity product) {
    List<SpecificationEntity> specifications = product.specifications!;
    specifications
        .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));

    return specifications
        .map((specification) => ProductDetailItemEntity(
              id: specification.specificationId ?? '',
              title: specification.nameDisplay ?? '',
              htmlContent: specification.htmlContent ?? '',
              position: specification.sortOrder ?? 0,
              detailsSectionType:
                  ProdcutDeatilsPageWidgets.productDetailsSpecification,
            ))
        .toList();
  }

  ProductDetailsStyletraitsEntity makeProductDetailsStyleTraitsEntity(
      ProductEntity product,
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    final List<ProductDetailStyleTrait> styleTraitsEntity = [];

    for (var styleTrait in product.styleTraits!) {
      var styleTraitNullValue = ProductDetailStyleValue(
          styleValue: StyleValueEntity(
              styleTraitId: styleTrait.id,
              valueDisplay: LocalizationConstants.selectSomething +
                  styleTrait.nameDisplay!),
          displayName:
              LocalizationConstants.selectSomething + styleTrait.nameDisplay!,
          isAvailable: true);

      List<ProductDetailStyleValue> styleValues = [];
      styleValues.add(styleTraitNullValue);

      for (var styleValue in styleTrait.styleValues!) {
        

        styleValue = styleValue.copyWith(
            isAvailable: availableStyleValues[styleValue.styleTraitId]!.any(
                (x) => x.styleTraitValueId == styleValue.styleTraitValueId));

        var styleValueEntity = ProductDetailStyleValue(
            styleValue: styleValue,
            displayName: availableStyleValues[styleValue.styleTraitId] !=
                        null &&
                    availableStyleValues[styleValue.styleTraitId]!.any((x) =>
                        x.styleTraitValueId == styleValue.styleTraitValueId)
                ? styleValue.valueDisplay
                : "N/A - ${styleValue.valueDisplay!}",
            isAvailable: availableStyleValues[styleValue.styleTraitId]!.any(
                (x) => x.styleTraitValueId == styleValue.styleTraitValueId));
        styleValues.add(styleValueEntity);
      }

      getDefaultStyleTrait() {
        return styleValues.firstWhere(
          (x) => x.styleValue?.isDefault == true,
          orElse: () => styleTraitNullValue,
        );
      }

      var selectedStyle = (selectedStyleValues?[styleTrait.styleTraitId] == null
          ? (getDefaultStyleTrait())
          : styleValues.firstWhere((x) =>
              selectedStyleValues?[styleTrait.styleTraitId]
                  ?.styleTraitValueId ==
              x.styleValue?.styleTraitValueId));

      var styleTraitEntity = ProductDetailStyleTrait(
          styleTraitName: styleTrait.nameDisplay,
          styleValues: styleValues,
          selectedStyleValue: selectedStyle,
          displayTextWithSwatch: styleTrait.displayTextWithSwatch,
          displayType: styleTrait.displayType,
          numberOfSwatchesVisible: styleTrait.numberOfSwatchesVisible);

      styleTraitsEntity.add(styleTraitEntity);
    }

    return ProductDetailsStyletraitsEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsStyleTraits,
        styleTraits: styleTraitsEntity);
  }
}
