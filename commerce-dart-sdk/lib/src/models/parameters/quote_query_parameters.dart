import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class QuoteQueryParameters extends BaseQueryParameters {
  String? userId;

  String? salesRepNumber;

  String? customerId;

  List<String>? statuses;

  String? quoteNumber;

  DateTime? fromDate;

  DateTime? toDate;

  DateTime? expireFromDate;

  DateTime? expireToDate;

  List<String>? types;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  // Similar to: [QueryParameter(QueryOptions.DoNotQuery)]
  @JsonKey(includeFromJson: false, includeToJson: false)
  BillTo? billTo;

  // Similar to: [QueryParameter(QueryOptions.DoNotQuery)]
  @JsonKey(includeFromJson: false, includeToJson: false)
  CatalogTypeDto? selectedUser;

  // Similar to: [QueryParameter(QueryOptions.DoNotQuery)]
  @JsonKey(includeFromJson: false, includeToJson: false)
  CatalogTypeDto? selectedSalesRep;

  QuoteQueryParameters({
    this.userId,
    this.salesRepNumber,
    this.customerId,
    this.statuses,
    this.quoteNumber,
    this.fromDate,
    this.toDate,
    this.expireFromDate,
    this.expireToDate,
    this.types,
    this.expand,
    this.billTo,
    this.selectedUser,
    this.selectedSalesRep,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$QuoteQueryParametersToJson(this));
}
