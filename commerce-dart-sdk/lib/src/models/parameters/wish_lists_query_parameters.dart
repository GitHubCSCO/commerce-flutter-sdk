import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_lists_query_parameters.g.dart';

@JsonSerializable()
class WishListsQueryParameters extends BaseQueryParameters {
  String? query;

  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  String? wishListLinesSort;

  WishListsQueryParameters({
    this.query,
    this.expand,
    this.wishListLinesSort,
    super.page,
    super.pageSize,
    super.sort,
  });

  factory WishListsQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$WishListsQueryParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WishListsQueryParametersToJson(this));
}
