import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/document._entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_attributes_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_cross_sell_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_documents_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_standard_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum ProdcutDeatilsPageWidgets {
  productDetailsDescription,
  productDetailsSpecification,
  productDetailsGeneralInfo,
  productDetailsAddtoCart,
  productDetailsPrice,
  productDeatilsStanddardConfigurationSection,
  productDetailsCrossSellSection,
  productDetailsStyleTraits,
  productDetailsDocuments,
  productDetailsAttributes
}

class ProductDetailsUseCase extends BaseUseCase {
  final ProductDetailsStyleTraitsUseCase _productDetailsStyleTraitsUseCase =
      ProductDetailsStyleTraitsUseCase();
  final ProductDetailsAddToCartUseCase _addToCartUseCase =
      ProductDetailsAddToCartUseCase();
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
      AccountSettings? accountSettings,
      Session? session) async {
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

    var parameters = ProductQueryParameters(
      addToRecentlyViewed: true,
      applyPersonalization: true,
      includeAttributes: "includeOnProduct,notFromCategory",
      expand:
          "detail,content,images,specifications,documents,attributes,variantTraits,badges",
    );

    const maxReplacementDepth = 10;
    var currentProductId = productId;
    var depth = 0;

    while (true) {
      var resultResponse = await commerceAPIServiceProvider
          .getProductService()
          .getProduct(currentProductId, parameters: parameters);

      switch (resultResponse) {
        case Success(value: final data):
          final productEntity =
              ProductEntityMapper.toEntity(data?.product ?? Product());

          final replacementProductId = productEntity.replacementProductId;
          final shouldRedirectToReplacement =
              (productEntity.isDiscontinued ?? false) &&
                  !replacementProductId.isNullOrEmpty &&
                  replacementProductId != currentProductId &&
                  depth < maxReplacementDepth;

          if (shouldRedirectToReplacement) {
            currentProductId = replacementProductId!;
            depth++;
            continue;
          }

          return Success(productEntity);
        case Failure(errorResponse: final errorResponse):
          return Failure(errorResponse);
      }
    }
  }

  Future<List<ProductEntity>> getVariantChildren(String productId) async {
    var parameters = VariantChildrenQueryParameters(
      expand:
          "detail,content,images,specifications,documents,attributes,badges",
    );

    var result = await commerceAPIServiceProvider
        .getProductService()
        .getVariantChildren(productId, parameters: parameters);

    switch (result) {
      case Success(value: final data):
        if (data?.products != null) {
          return data!.products!
              .map((product) => ProductEntityMapper.toEntity(product))
              .toList();
        }
        return [];
      case Failure():
        return [];
    }
  }

  Future<List<ProductEntity>> getRelatedProducts(String productId) async {
    var parameters = RelatedProductsQueryParameters(
      relationship: 'CrossSell',
    );

    var result = await commerceAPIServiceProvider
        .getProductService()
        .getRelatedProducts(productId, parameters: parameters);

    switch (result) {
      case Success(value: final data):
        if (data?.products != null) {
          return data!.products!
              .map((product) => ProductEntityMapper.toEntity(product))
              .toList();
        }
        return [];
      case Failure():
        return [];
    }
  }

  List<ProductImageEntity> makeProductImages(
      ProductEntity product, ProductEntity? selectedVariantChild) {
    List<ProductImageEntity> result;
    var correctProductImages =
        selectedVariantChild?.productImages ?? product.productImages;

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
        smallImagePath: (selectedVariantChild != null
            ? selectedVariantChild.smallImagePath
            : product.smallImagePath),
        mediumImagePath: (selectedVariantChild != null
            ? selectedVariantChild.mediumImagePath
            : product.mediumImagePath),
        largeImagePath: (selectedVariantChild != null
            ? selectedVariantChild.largeImagePath
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
      ProductEntity product, ProductEntity? selectedVariantChild) {
    var genralInfoEntity = ProductDetailsGeneralInfoEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsGeneralInfo,
        productNumber: product.getProductNumber(),
        myPartNumberValue: product.customerName,
        mFGNumberValue: product.manufacturerItem,
        packDescriptionValue: product.packDescription,
        brandName: product.brand?.logoSmallImagePath == null
            ? product.brand?.name
            : product.brand?.logoSmallImagePath.makeImageUrl());

    genralInfoEntity = updateGeneralInfoViewModel(
        product, selectedVariantChild, genralInfoEntity);
    return genralInfoEntity;
  }

  ProductDetailsGeneralInfoEntity updateGeneralInfoViewModel(
      ProductEntity product,
      ProductEntity? selectedVariantChild,
      ProductDetailsGeneralInfoEntity genralInfoEntity) {
    genralInfoEntity = genralInfoEntity.copyWith(
        productName: selectedVariantChild == null
            ? product.shortDescription
            : selectedVariantChild.shortDescription);
    genralInfoEntity = genralInfoEntity.copyWith(
        originalPartNumberValue: selectedVariantChild == null
            ? product.getProductNumber()
            : selectedVariantChild.getProductNumber());
    genralInfoEntity = genralInfoEntity.copyWith(
        mFGNumberValue:
            selectedVariantChild?.manufacturerItem ?? product.manufacturerItem);
    genralInfoEntity = genralInfoEntity.copyWith(
        myPartNumberValue:
            selectedVariantChild?.customerName ?? product.customerName);
    genralInfoEntity = genralInfoEntity.copyWith(
        packDescriptionValue:
            selectedVariantChild?.packDescription ?? product.packDescription);
    if (selectedVariantChild?.brand != null) {
      genralInfoEntity = genralInfoEntity.copyWith(
          brandName: selectedVariantChild!.brand?.logoSmallImagePath == null
              ? selectedVariantChild.brand?.name
              : selectedVariantChild.brand?.logoSmallImagePath.makeImageUrl());
    }
    genralInfoEntity = genralInfoEntity.copyWith(
        thumbnails: makeProductImages(product, selectedVariantChild));
    genralInfoEntity = genralInfoEntity.copyWith(
        hasMultipleImages: (product.productImages?.length ?? 0) > 1);
    genralInfoEntity =
        genralInfoEntity.copyWith(productInformationWasUpdated: true);

    genralInfoEntity = genralInfoEntity.copyWith(
        myPartNumberTitle: LocalizationConstants.myPartNumberSign.localized());
    genralInfoEntity = genralInfoEntity.copyWith(
        mFGNumberTitle: LocalizationConstants.mFGNumberSign.localized());
    genralInfoEntity = genralInfoEntity.copyWith(
        packDescriptionTitle:
            LocalizationConstants.packDescription.localized());

    return genralInfoEntity;
  }

  Future<List<ProductDetailsBaseEntity>> makeAllDetailsItems(
    ProductEntity product,
    ProductEntity? selectedVariantChild,
    bool productPricingEnabled,
    Map<String, List<StyleValueEntity>?> availableStyleValues,
    Map<String, StyleValueEntity?>? selectedStyleValues,
    bool isProductConfigurable,
    bool isProductConfigurationCompleted,
    bool hasCheckout,
    bool addToCartEnabled, {
    List<ProductEntity>? relatedProducts,
  }) async {
    List<ProductDetailsBaseEntity> items = [];

    var quantity = getQuantity(product);
    items.add(makeGeneralInfoEntity(product, selectedVariantChild));

    if (productPricingEnabled) {
      items.add(makeProductDetailsPriceEntity());
    }

    if (shouldAddConfigSection(product)) {
      items.add(addConfigSection(product));
    }

    if (product.variantTraits != null && product.variantTraits!.isNotEmpty) {
      items.add(makeProductDetailsStyleTraitsEntity(
          product, availableStyleValues, selectedStyleValues));
    }

    var addToCartEntity = await makeProductDetailsAddToCartEntity(
        quantity,
        hasCheckout,
        addToCartEnabled,
        product,
        selectedVariantChild,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);
    items.add(addToCartEntity);

    final effectiveHtmlContent = (selectedVariantChild?.htmlContent != null &&
            selectedVariantChild!.htmlContent!.isNotEmpty)
        ? selectedVariantChild.htmlContent
        : product.htmlContent;

    if (effectiveHtmlContent != null && effectiveHtmlContent.isNotEmpty) {
      items.add(
          makeProductDetailsDescriptionEntityFromHtml(effectiveHtmlContent));
    }

    final effectiveAttributeTypes =
        (selectedVariantChild?.attributeTypes?.isNotEmpty == true)
            ? selectedVariantChild!.attributeTypes
            : product.attributeTypes;

    var attributesEntity =
        makeProductDetailsAttributesEntity(product, effectiveAttributeTypes);

    if (attributesEntity.productAttributes.isNotEmpty) {
      items.add(attributesEntity);
    }

    final effectiveSpecifications =
        (selectedVariantChild?.specifications?.isNotEmpty == true)
            ? selectedVariantChild!.specifications
            : product.specifications;
    final effectiveDocuments =
        (selectedVariantChild?.documents?.isNotEmpty == true)
            ? selectedVariantChild!.documents
            : product.documents;

    if (effectiveSpecifications != null) {
      items.addAll(addSpecificationsFromList(effectiveSpecifications));
    }

    if (effectiveDocuments != null && effectiveDocuments.isNotEmpty) {
      items.add(makeProductDetailsDocumentsEntityFromList(effectiveDocuments));
    }

    if (relatedProducts != null && relatedProducts.isNotEmpty) {
      var porductCarouselWidget = ProductCarouselWidgetEntity(
          carouselType: ProductCarouselType.webCrossSells,
          title: LocalizationConstants.recommendedProducts.localized());

      final List<ProductCarouselEntity> productCarouselList = [];
      for (var relatedProduct in relatedProducts) {
        productCarouselList.add(ProductCarouselEntity(
            product: relatedProduct,
            productPricingEnabled: productPricingEnabled));
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
    return ((product.minimumOrderQty ?? 0) > 0) ? product.minimumOrderQty! : 1;
  }

  ProductDetailsPriceEntity makeProductDetailsPriceEntity() {
    final hidePricingEnable =
        coreServiceProvider.getAppConfigurationService().hidePricingEnable;
    final hideInventoryEnable =
        coreServiceProvider.getAppConfigurationService().hideInventoryEnable;
    return ProductDetailsPriceEntity(
      detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsPrice,
      hidePricing: hidePricingEnable,
      hideInventory: hideInventoryEnable,
    );
  }

  bool shouldAddConfigSection(ProductEntity product) {
    return !(product.variantTraits != null &&
            product.variantTraits!.isNotEmpty) &&
        product.configurationDto != null &&
        product.configurationDto!.sections != null &&
        product.configurationDto!.sections!.isNotEmpty &&
        !(product.isFixedConfiguration ?? false);
  }

  Future<ProductDetailsAddtoCartEntity> makeProductDetailsAddToCartEntity(
      int quantity,
      bool hasCheckout,
      bool addToCartEnabled,
      ProductEntity productEntity,
      ProductEntity? selectedVariantChild,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      bool isProductConfigurable,
      bool isProductConfigurationCompleted) async {
    var isAddToCartVisible = await _addToCartUseCase.getAddToCartVisibility(
        quantity,
        hasCheckout,
        addToCartEnabled,
        productEntity,
        selectedVariantChild,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);

    var isAddToCartEnable = await _addToCartUseCase.getAddToCartEnableState(
        quantity,
        hasCheckout,
        addToCartEnabled,
        productEntity,
        selectedVariantChild,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);
    return ProductDetailsAddtoCartEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsAddtoCart,
        quantityText: quantity.toString(),
        isAddToCartAllowed: isAddToCartVisible,
        addToCartButtonEnabled: isAddToCartEnable);
  }

  ProductDetailsDescriptionEntity makeProductDetailsDescriptionEntity(
      ProductEntity product) {
    return ProductDetailsDescriptionEntity(
        htmlContent: product.htmlContent ?? '',
        detailsSectionType:
            ProdcutDeatilsPageWidgets.productDetailsDescription);
  }

  ProductDetailsDocumentsEntity makeProductDetailsDocumentsEntity(
      ProductEntity product) {
    return ProductDetailsDocumentsEntity(
        title: LocalizationConstants.documents.localized(),
        documents: product.documents,
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsDocuments,
        documentPaths:
            createDocumentPathsFromDocuments(product.documents ?? []));
  }

  List<String> createDocumentPathsFromDocuments(
      List<DocumentEntity> documents) {
    List<String> documentPaths = [];

    for (var document in documents) {
      if (document.filePath == null || document.filePath!.isEmpty) {
        continue;
      }

      String documentPath = document.filePath ?? " ";

      if (document.filePath != null && document.filePath!.startsWith('/')) {
        String clientUrl =
            commerceAPIServiceProvider.getClientService().url.toString();
        if (clientUrl.endsWith('/')) {
          clientUrl = clientUrl.substring(0, clientUrl.length - 1);
        }
        documentPath = '$clientUrl${document.filePath}';
      }

      documentPaths.add(documentPath);
    }

    return documentPaths;
  }

  ProductDetailsStandardConfigurationEntity addConfigSection(
      ProductEntity product) {
    for (var index = 0;
        index < product.configurationDto!.sections!.length;
        index++) {
      var configSection = product.configurationDto!.sections![index];
      var hasPlaceholder = configSection.options != null &&
          configSection.options!.isNotEmpty &&
          configSection.options!.first.sectionOptionId == null &&
          configSection.options!.first.productId == null;
      if (!hasPlaceholder) {
        var option = ConfigSectionOptionEntity(
            sectionName: configSection.sectionName,
            description:
                "${LocalizationConstants.selectSomething.localized()} ${configSection.sectionName!}");
        product.configurationDto!.sections![index].options!.insert(0, option);
      }
    }
    return ProductDetailsStandardConfigurationEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets
            .productDeatilsStanddardConfigurationSection,
        configSectionOptions: product.configurationDto!.sections);
  }

  List<ProductDetailItemEntity> addSpecifications(ProductEntity product) {
    List<SpecificationEntity> specifications = product.specifications ?? [];
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

  List<ProductDetailItemEntity> addSpecificationsFromList(
      List<SpecificationEntity> specifications) {
    final sorted = List<SpecificationEntity>.from(specifications)
      ..sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));

    return sorted
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

  ProductDetailsDocumentsEntity makeProductDetailsDocumentsEntityFromList(
      List<DocumentEntity> documents) {
    return ProductDetailsDocumentsEntity(
        title: LocalizationConstants.documents.localized(),
        documents: documents,
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsDocuments,
        documentPaths: createDocumentPathsFromDocuments(documents));
  }

  ProductDetailsStyletraitsEntity makeProductDetailsStyleTraitsEntity(
      ProductEntity product,
      Map<String, List<StyleValueEntity>?> availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues) {
    final List<ProductDetailStyleTrait> styleTraitsEntity = [];

    for (var styleTrait in product.variantTraits!) {
      var styleTraitNullValue = _productDetailsStyleTraitsUseCase
          .createStyleTraitNullValue(styleTrait);
      List<ProductDetailStyleValue> styleValues = [styleTraitNullValue];

      for (var styleValue in styleTrait.traitValues!) {
        styleValue = _productDetailsStyleTraitsUseCase
            .updateStyleValueAvailability(styleValue, availableStyleValues);
        var styleValueEntity = _productDetailsStyleTraitsUseCase
            .createStyleValueEntity(styleValue, availableStyleValues);
        styleValues.add(styleValueEntity);
      }

      var selectedStyle = _productDetailsStyleTraitsUseCase.getSelectedStyle(
          styleValues, styleTrait, selectedStyleValues, styleTraitNullValue);
      var styleTraitEntity = _productDetailsStyleTraitsUseCase
          .createStyleTraitEntity(styleTrait, styleValues, selectedStyle);

      styleTraitsEntity.add(styleTraitEntity);
    }

    return ProductDetailsStyletraitsEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsStyleTraits,
        styleTraits: styleTraitsEntity);
  }

  ProductDetailsAttributesEntity makeProductDetailsAttributesEntity(
      ProductEntity product,
      List<AttributeTypeEntity>? effectiveAttributeTypes) {
    List<AttributeTypeEntity> attributes = [];

    if (product.brand != null && product.brand!.name != null) {
      var brandAttribute = AttributeTypeEntity(
          label: LocalizationConstants.brand.localized(),
          name: LocalizationConstants.brand.localized(),
          attributeValues: [
            AttributeValueEntity(
                value: product.brand!.name, valueDisplay: product.brand!.name)
          ]);
      attributes.add(brandAttribute);
    }

    if (effectiveAttributeTypes != null && effectiveAttributeTypes.isNotEmpty) {
      attributes.addAll(effectiveAttributeTypes);
    }

    return ProductDetailsAttributesEntity(
        detailsSectionType: ProdcutDeatilsPageWidgets.productDetailsAttributes,
        productAttributes: attributes);
  }

  ProductDetailsDescriptionEntity makeProductDetailsDescriptionEntityFromHtml(
      String htmlContent) {
    return ProductDetailsDescriptionEntity(
        htmlContent: htmlContent,
        detailsSectionType:
            ProdcutDeatilsPageWidgets.productDetailsDescription);
  }
}
