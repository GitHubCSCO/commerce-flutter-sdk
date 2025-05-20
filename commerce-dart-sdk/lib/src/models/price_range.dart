// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'models.dart';

part 'price_range.g.dart';

@JsonSerializable()
class PriceRange {
  num? minimumPrice;

  num? maximumPrice;

  int? count;

  List<PriceFacet>? priceFacets;

  PriceRange({
    this.minimumPrice,
    this.maximumPrice,
    this.count,
    this.priceFacets,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);
  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);
}
