import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brands_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class BrandsQueryParameters extends BaseQueryParameters {
  String? startsWith;
  String? manufacturer;

  @override
  int get pageSize => super.pageSize ?? 500;

  @override
  set pageSize(int? value) {
    super.pageSize = value;
  }

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  BrandsQueryParameters({
    this.startsWith,
    this.manufacturer,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BrandsQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class BrandQueryParameters extends BaseQueryParameters {
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  BrandQueryParameters({
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BrandQueryParametersToJson(this));
}
