import 'models.dart';

part 'price_facet.g.dart';

@JsonSerializable()
class PriceFacet {
  int? minimumPrice;

  int? maximumPrice;

  int? count;

  bool? selected;

  PriceFacet({
    this.minimumPrice,
    this.maximumPrice,
    this.count,
    this.selected,
  });

  factory PriceFacet.fromJson(Map<String, dynamic> json) =>
      _$PriceFacetFromJson(json);
  Map<String, dynamic> toJson() => _$PriceFacetToJson(this);
}
