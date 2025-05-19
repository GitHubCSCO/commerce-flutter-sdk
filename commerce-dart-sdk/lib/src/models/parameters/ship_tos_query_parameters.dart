// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'ship_tos_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class ShipTosQueryParameters extends BaseQueryParameters {
  @override
  @JsonKey(defaultValue: 1)
  int? get page => super.page ?? 1;

  @override
  @JsonKey(defaultValue: 16)
  int? get pageSize => super.pageSize ?? 16;

  String? billToId;

  String? filter;

  // Similar to[QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? exclude;

  /// Options: Approvals, AssignedOnly, ExcludeBillTo, ExcludeCreateNew, ExcludeShowAll, Validation
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  ShipTosQueryParameters({
    this.billToId,
    this.filter,
    this.exclude,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ShipTosQueryParametersToJson(this));
}
