import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'catalog_type_dto.g.dart';

@JsonSerializable()
class CatalogTypeDto {
  String? id;
  String? title;

  CatalogTypeDto({
    this.id,
    this.title,
  });

  factory CatalogTypeDto.fromJson(Map<String, dynamic> json) =>
      _$CatalogTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogTypeDtoToJson(this);
}

@JsonSerializable()
class GetCatalogTypeResult extends BaseModel {
  Pagination? pagination;
  List<CatalogTypeDto>? items;

  GetCatalogTypeResult({
    this.pagination,
    this.items,
  });

  factory GetCatalogTypeResult.fromJson(Map<String, dynamic> json) =>
      _$GetCatalogTypeResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetCatalogTypeResultToJson(this);
}

@JsonSerializable(createFactory: false)
class CatalogTypeQueryParameters extends BaseQueryParameters {
  String? keyword;

  CatalogTypeQueryParameters({
    this.keyword,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() => _$CatalogTypeQueryParametersToJson(this);
}
