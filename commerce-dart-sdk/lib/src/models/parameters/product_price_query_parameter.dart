import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_price_query_parameter.g.dart';

/// The class for all product price related parameters
///
/// Doesn't create [fromJson].
/// [JsonSerializable] is required to convert an object to a map
/// while requesting with an [Uri], the [queryparameters] need to be a map
/// so by using [Uri("...", queryParameter: ProductPriceQueryParameter.toJson())]
/// the object is automatically converted to be used as query parameter.
@JsonSerializable(createFactory: false)
class ProductPriceQueryParameter {
  String? productId;

  String? unitOfMeasure;

  num? qtyOrdered;

  List<String>? configuration;

  ProductPriceQueryParameter({
    this.productId,
    this.unitOfMeasure,
    this.qtyOrdered,
    this.configuration,
  });

  // Automatic conversion of map values ([int], [bool] etc.) to [String]
  // this is required since [toJson()] method converts an object to [Map]
  // and for sending request, the [queryParameters] needs to be set with a [Map]
  // and [queryParameters] Map cannot have any value that is in types like [int] or [bool]
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductPriceQueryParameterToJson(this));
}
