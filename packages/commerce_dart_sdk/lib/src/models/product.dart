import 'models.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends BaseModel {
  Product({
    this.accessories,
    this.allowAnyGiftCardAmount,
    this.allowedAddToCart,
    this.altText,
    this.attributeTypes,
    this.availability,
    this.basicListPrice,
    this.basicSaleEndDate,
    this.basicSalePrice,
    this.basicSaleStartDate,
    this.brand,
    this.canAddToCart,
    this.canAddToWishlist,
    this.canBackOrder,
    this.canConfigure,
    this.canEnterQuantity,
    this.canShowPrice,
    this.canShowUnitOfMeasure,
    this.canViewDetails,
    this.canonicalUrl,
    this.cantBuy,
    this.childTraitValues,
    this.configurationDto,
    this.configurationType,
    this.content,
    this.crossSells,
    this.currencySymbol,
    this.customerName,
    this.customerProductNumber,
    this.customerUnitOfMeasure,
    this.detail,
    this.documents,
    this.erpDescription,
    this.erpNumber,
    this.handlingAmountOverride,
    this.hasMsds,
    this.htmlContent,
    this.id,
    this.imageAltText,
    this.images,
    this.isActive,
    this.isBeingCompared,
    this.isConfigured,
    this.isDiscontinued,
    this.isFixedConfiguration,
    this.isGiftCard,
    this.isHazardousGood,
    this.isSpecialOrder,
    this.isSponsored,
    this.isStyleProductParent,
    this.isSubscription,
    this.isVariantParent,
    this.largeImagePath,
    this.manufacturerItem,
    this.mediumImagePath,
    this.metaDescription,
    this.metaKeywords,
    this.minimumOrderQty,
    this.modelNumber,
    this.multipleSaleQty,
    this.name,
    this.numberInCart,
    this.orderLineId,
    this.packDescription,
    this.pageTitle,
    this.priceCode,
    this.priceFacet,
    this.pricing,
    this.productCode,
    this.productDetailUrl,
    this.productImages,
    this.productLine,
    this.productNumber,
    this.productSubscription,
    this.productTitle,
    this.productUnitOfMeasures,
    this.qtyOnHand,
    this.qtyOrdered,
    this.qtyPerShippingPackage,
    this.quoteRequired,
    this.replacementProductId,
    this.requiresRealTimeInventory,
    this.roundingRule,
    this.salePriceLabel,
    this.score,
    this.scoreExplanation,
    this.searchBoost,
    this.selectedUnitOfMeasure,
    this.selectedUnitOfMeasureDisplay,
    this.shippingAmountOverride,
    this.shippingClassification,
    this.shippingHeight,
    this.shippingLength,
    this.shippingWeight,
    this.shippingWidth,
    this.shortDescription,
    this.sku,
    this.smallImagePath,
    this.sortOrder,
    this.specifications,
    this.styleParentId,
    this.styleTraits,
    this.styledProducts,
    this.taxCategory,
    this.taxCode1,
    this.taxCode2,
    this.trackInventory,
    this.unitListPrice,
    this.unitListPriceDisplay,
    this.unitOfMeasure,
    this.unitOfMeasureDescription,
    this.unitOfMeasureDisplay,
    this.unitOfMeasures,
    this.unspsc,
    this.upcCode,
    this.urlSegment,
    this.variantTraits,
    this.variantTypeId,
    this.vendorNumber,
    this.warehouses,
  });

  /// Gets or sets the product id.
  String? id;

  /// Gets or sets the order line identifier.
  String? orderLineId;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the customer product name.
  String? customerName;

  /// Gets or sets the short description.
  String? shortDescription;

  /// Gets or sets the erp number.
  // ReSharper disable once InconsistentNaming
  String? erpNumber;

  /// Gets or sets the erp description.
  // ReSharper disable once InconsistentNaming
  String? erpDescription;

  /// Gets or sets the URL segment used for pathing.
  String? urlSegment;

  /// Gets or sets the basic list price.
  num? basicListPrice;

  /// Gets or sets the basic sale price.
  num? basicSalePrice;

  /// Gets or sets the basic sale start date.
  DateTime? basicSaleStartDate;

  /// Gets or sets the basic sale end date.
  DateTime? basicSaleEndDate;

  /// Gets or sets the small image url.
  String? smallImagePath;

  /// Gets or sets the medium image url .
  String? mediumImagePath;

  /// Gets or sets the large image url.
  String? largeImagePath;

  /// Gets or sets the product pricing data.
  ProductPrice? pricing;

  /// Gets or sets the currency symbol.
  String? currencySymbol;

  /// Gets or sets the inventory quantity.
  num? qtyOnHand;

  /// Gets or sets whether the product is configurable.
  bool? isConfigured;

  /// Gets or sets whether the product is has a fixed configuration.
  bool? isFixedConfiguration;

  /// Gets or sets whether the product is active.
  bool? isActive;

  /// Gets or sets whether the product is hazardous.
  bool? isHazardousGood;

  /// Gets or sets whether the product is discontinued.
  bool? isDiscontinued;

  /// Gets or sets whether the product is special ordered.
  bool? isSpecialOrder;

  /// Gets or sets whether the product is a gift card.
  bool? isGiftCard;

  /// Gets or sets whether the product is being compared (client side flag).
  bool? isBeingCompared;

  /// Gets or sets whether the product is sponsored.
  bool? isSponsored;

  /// Gets or sets whether the product is subscription.
  bool? isSubscription;

  /// Gets or sets whether the product requires a quote.
  bool? quoteRequired;

  /// Gets or sets the manufacturer item number.
  String? manufacturerItem;

  /// Gets or sets the packing description.
  String? packDescription;

  /// Gets or sets the image alt text.
  String? altText;

  /// Gets or sets the customer specific unit of measure.
  String? customerUnitOfMeasure;

  /// Gets or sets the ability to order with no inventory.
  bool? canBackOrder;

  /// Gets or sets whether the inventory is tracked.
  bool? trackInventory;

  /// Gets or sets the multiple sale quantity.
  int? multipleSaleQty;

  /// Gets or sets the minimum order quantity.
  int? minimumOrderQty;

  /// Gets or sets the html content for the product.
  String? htmlContent;

  /// Gets or sets the product code.
  String? productCode;

  /// Gets or sets the price code.
  String? priceCode;

  /// Gets or sets the sku.
  String? sku;

  /// Gets or sets the upc code.
  String? upcCode;

  /// Gets or sets the model number.
  String? modelNumber;

  /// Gets or sets the tax code 1.
  String? taxCode1;

  /// Gets or sets the tax code 2.
  String? taxCode2;

  /// Gets or sets the tax category.
  String? taxCategory;

  /// Gets or sets the shipping classification.
  String? shippingClassification;

  /// Gets or sets the shipping length.
  String? shippingLength;

  /// Gets or sets the shipping width.
  String? shippingWidth;

  /// Gets or sets the shipping height.
  String? shippingHeight;

  /// Gets or sets the shipping wieght.
  String? shippingWeight;

  /// Gets or sets the shipping quantity per package.
  num? qtyPerShippingPackage;

  /// Gets or sets the shipping amount override.
  num? shippingAmountOverride;

  /// Gets or sets the handling amount override.
  num? handlingAmountOverride;

  /// Gets or sets the meta description for the product detail page.
  String? metaDescription;

  /// Gets or sets the meta keywords for the product detail page.
  String? metaKeywords;

  /// Gets or sets the page title for the product detail page.
  String? pageTitle;

  /// Gets or sets whether to allow any gift card amount.
  bool? allowAnyGiftCardAmount;

  /// Gets or sets the sort order of the product.
  int? sortOrder;

  /// Gets or sets whether the product has msds.
  bool? hasMsds;

  /// Gets or sets the unspsc.
  String? unspsc;

  /// Gets or sets the rounding rule.
  String? roundingRule;

  /// Gets or sets the vendor number.
  String? vendorNumber;

  /// Gets or sets the configuration.
  LegacyConfiguration? configurationDto;

  /// Gets or sets the unit of measure.
  String? unitOfMeasure;

  /// Gets or sets the unit of measure display text.
  String? unitOfMeasureDisplay;

  /// Gets or sets the unit of measure description.
  String? unitOfMeasureDescription;

  /// Gets or sets the selected unit of measure.
  String? selectedUnitOfMeasure;

  /// Gets or sets the selected unit of measure.
  String? selectedUnitOfMeasureDisplay;

  /// Gets or sets the full url to the detail page.
  String? productDetailUrl;

  /// Gets or sets whether the product can be added to cart.
  bool? canAddToCart;

  /// Gets or sets whether the website allows adding to cart.
  bool? allowedAddToCart;

  /// Gets or sets whether the product can be added to a wishlist.
  bool? canAddToWishlist;

  /// Gets or sets whether the product view details button should be displayed.
  bool? canViewDetails;

  /// Gets or sets whether the product price can be shown.
  bool? canShowPrice;

  /// Gets or sets whether the product unit of measure can be shown.
  bool? canShowUnitOfMeasure;

  /// Gets or sets whether the product quantity can be entered.
  bool? canEnterQuantity;

  /// Gets or sets whether the product can be configured with the configurator.
  bool? canConfigure;

  /// Gets or sets whether the product has styled child products.
  bool? isStyleProductParent;

  /// Gets or sets the ID of the parent of this product, if any.
  String? styleParentId;

  bool? requiresRealTimeInventory;

  /// Gets or sets the quantity of the product already in the cart.
  @JsonKey(includeFromJson: false, includeToJson: false)
  num? numberInCart;

  /// Gets or sets the quantity ordered (for adding to cart).
  @JsonKey(includeFromJson: false, includeToJson: false)
  num? qtyOrdered;

  /// Gets or sets the inventory availability information.
  Availability? availability;

  /// Gets or sets the style traits.
  List<StyleTrait>? styleTraits;

  /// Gets or sets the style product children.
  List<StyledProduct>? styledProducts;

  /// Gets or sets the attributes assigned to the product.
  List<AttributeType>? attributeTypes;

  /// Gets or sets the documents.
  List<Document>? documents;

  /// Gets or sets the specifications.
  List<Specification>? specifications;

  /// Gets or sets the product cross sells.
  List<Product>? crossSells;

  /// Gets or sets the accessories.
  List<Product>? accessories;

  /// Gets or sets the list of all available units of measure.
  List<ProductUnitOfMeasure>? productUnitOfMeasures;

  /// Gets or sets the list of all product images.
  List<ProductImage>? productImages;

  /// The search provider score for this product
  double? score;

  /// Gets or sets the index time search boost
  int? searchBoost;

  /// Gets or sets the sale price label.
  String? salePriceLabel;

  /// Gets or sets the product subscription.
  ProductSubscriptionDto? productSubscription;

  /// Gets or sets the replacement product id.
  String? replacementProductId;

  /// Gets or sets the warehouses.
  List<InventoryWarehouse>? warehouses;

  Brand? brand;

  // for V2
  String? productNumber;

  String? customerProductNumber;

  String? productTitle;

  String? canonicalUrl;

  num? unitListPrice;

  String? unitListPriceDisplay;

  int? priceFacet;

  String? imageAltText;

  String? configurationType;

  bool? isVariantParent;

  String? variantTypeId;

  bool? cantBuy;

  ProductLine? productLine;

  List<ProductUnitOfMeasure>? unitOfMeasures;

  ScoreExplanation? scoreExplanation;

  ProductDetail? detail;

  ProductContent? content;

  List<ProductImage>? images;

  List<StyleTrait>? variantTraits;

  List<ChildTraitValue>? childTraitValues;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
