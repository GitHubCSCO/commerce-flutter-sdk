import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'bill_tos_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class BillTosQueryParameters extends BaseQueryParameters {
  @override
  @JsonKey(defaultValue: 1)
  int? get page => super.page ?? 1;

  @override
  @JsonKey(defaultValue: 16)
  int? get pageSize => super.pageSize ?? 16;

  String? filter;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? exclude;

  /// Options: ShipTos, Validation
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;
  BillTosQueryParameters({
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
          _$BillTosQueryParametersToJson(this));
}
