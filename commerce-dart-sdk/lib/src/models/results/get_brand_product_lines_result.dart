import '../models.dart';

part 'get_brand_product_lines_result.g.dart';

@JsonSerializable()
class GetBrandProductLinesResult extends BaseModel {
  Pagination? pagination;
  List<BrandProductLine>? productLines;

  GetBrandProductLinesResult({this.pagination, this.productLines});

  factory GetBrandProductLinesResult.fromJson(Map<String, dynamic> json) =>
      _$GetBrandProductLinesResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrandProductLinesResultToJson(this);
}
