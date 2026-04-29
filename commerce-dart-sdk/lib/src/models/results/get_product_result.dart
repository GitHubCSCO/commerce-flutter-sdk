import '../models.dart';

part 'get_product_result.g.dart';

@JsonSerializable()
class GetProductResult extends BaseModel {
  Product? product;

  GetProductResult({
    this.product,
  });

  factory GetProductResult.fromJson(Map<String, dynamic> json) {
    // V2 API returns product fields at root level, not nested under 'product'
    return GetProductResult(
      product: Product.fromJson(json),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );
  }
  Map<String, dynamic> toJson() => _$GetProductResultToJson(this);
}
