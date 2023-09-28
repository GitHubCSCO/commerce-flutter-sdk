import 'package:json_annotation/json_annotation.dart';

part 'product_price_query_parameter.g.dart';

// Doesn't create fromJson
@JsonSerializable(createFactory: false)
class ProductPriceQueryParameter {
  String? productId;

  String? unitOfMeasure;

  num? qtyOrdered;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: _commaSeparatedJson)
  List<String>? configuration;
  static String? _commaSeparatedJson(List<String>? stringList) =>
      stringList?.join(',');

  ProductPriceQueryParameter({
    this.productId,
    this.unitOfMeasure,
    this.qtyOrdered,
    this.configuration,
  });

  Map<String, dynamic> toJson() => _$ProductPriceQueryParameterToJson(this);
}
