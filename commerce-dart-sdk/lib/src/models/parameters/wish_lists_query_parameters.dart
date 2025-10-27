import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/utils/date_formatter.dart';

part 'wish_lists_query_parameters.g.dart';

@JsonSerializable()
class WishListsQueryParameters extends BaseQueryParameters {
  String? query;

  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  String? wishListLinesSort;

  @JsonKey(toJson: DateFormatter.toYyyyMmDd)
  DateTime? fromCreatedDate;

  @JsonKey(toJson: DateFormatter.toYyyyMmDd)
  DateTime? toCreatedDate;

  @JsonKey(toJson: DateFormatter.toYyyyMmDd)
  DateTime? fromUpdatedOn;

  @JsonKey(toJson: DateFormatter.toYyyyMmDd)
  DateTime? toUpdatedOn;

  String? erpNumber;

  String? brandId;

  // For autocomplete search of sharedBy users
  String? sharedByQuery;

  String? sharedBy;

  WishListsQueryParameters({
    this.query,
    this.expand,
    this.wishListLinesSort,
    super.page,
    super.pageSize,
    super.sort,
    this.fromCreatedDate,
    this.toCreatedDate,
    this.fromUpdatedOn,
    this.toUpdatedOn,
    this.erpNumber,
    this.brandId,
    this.sharedByQuery,
    this.sharedBy,
  });

  factory WishListsQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$WishListsQueryParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WishListsQueryParametersToJson(this));
}
