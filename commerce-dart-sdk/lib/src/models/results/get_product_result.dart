import '../models.dart';

part 'get_product_result.g.dart';

@JsonSerializable()
class GetProductResult extends BaseModel {
  Product? product;

  GetProductResult({
    this.product,
  });

  factory GetProductResult.fromJson(Map<String, dynamic> json) =>
      _$GetProductResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetProductResultToJson(this);
}
