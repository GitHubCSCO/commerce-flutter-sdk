import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_query_parameters.g.dart';

@JsonSerializable()
class WishListQueryParameters extends BaseQueryParameters {
  /// Options: sharedusers, staticlist, hiddenproducts, getalllines, schedule
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  /// Options: excludelistlines, listlines
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? exclude;

  WishListQueryParameters({
    this.expand,
    this.exclude,
    super.page,
    super.pageSize,
    super.sort,
  });

  factory WishListQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$WishListQueryParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WishListQueryParametersToJson(this));
}
