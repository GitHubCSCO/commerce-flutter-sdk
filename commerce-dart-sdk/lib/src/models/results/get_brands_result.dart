import '../models.dart';

part 'get_brands_result.g.dart';

@JsonSerializable()
class GetBrandsResult extends BaseModel {
  Pagination? pagination;
  List<Brand>? brands;

  GetBrandsResult({this.pagination, this.brands});

  factory GetBrandsResult.fromJson(Map<String, dynamic> json) =>
      _$GetBrandsResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrandsResultToJson(this);
}
