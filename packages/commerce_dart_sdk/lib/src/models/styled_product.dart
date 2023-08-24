import 'models.dart';

part 'styled_product.g.dart';

@JsonSerializable(explicitToJson: true)
class StyledProduct extends BaseModel {
  StyledProduct({
    this.availability,
    this.erpNumber,
    this.largeImagePath,
    this.mediumImagePath,
    this.name,
    this.numberInCart,
    this.pricing,
    this.productId,
    this.productImages,
    this.productUnitOfMeasures,
    this.qtyOnHand,
    this.quoteRequired,
    this.shortDescription,
    this.smallImagePath,
    this.styleValues,
    this.trackInventory,
    this.warehouses,
  });

  /// Gets or sets the product identifier.
  String? productId;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the short description.
  String? shortDescription;

  /// Gets or sets the erp number.
  String? erpNumber;

  /// Gets or sets the medium image path.
  String? mediumImagePath;

  /// Gets or sets the small image path.
  String? smallImagePath;

  /// Gets or sets the large image path.
  String? largeImagePath;

  /// Gets or sets the qty on hand.
  num? qtyOnHand;

  /// Gets or sets the number in cart.
  @Deprecated('This property is deprecated in the C# SDK')
  num? numberInCart;

  /// Gets or sets the pricing.
  ProductPrice? pricing;

  /// Gets or sets a value indicating whether [quote required].
  bool? quoteRequired;

  /// Gets or sets the style values.
  List<StyleValue>? styleValues;

  /// Gets or sets the availability.
  Availability? availability;

  /// Gets or sets the list of all available units of measure.
  List<ProductUnitOfMeasure>? productUnitOfMeasures;

  /// Gets or sets the list of all product images.
  List<ProductImage>? productImages;

  /// Gets or sets the warehouses.
  List<Warehouse>? warehouses = <Warehouse>[];

  bool? trackInventory;

  factory StyledProduct.fromJson(Map<String, dynamic> json) =>
      _$StyledProductFromJson(json);
  Map<String, dynamic> toJson() => _$StyledProductToJson(this);
}
