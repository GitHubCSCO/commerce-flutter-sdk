import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_parameters.g.dart';

@JsonSerializable(createFactory: false)
class OrderApprovalParameters extends BaseQueryParameters {
  String? shipToId;

  String? orderNumber;

  String? orderTotal;

  DateTime? fromDate;

  DateTime? toDate;

  List<String>? orderTotalOperator;

  // Similar to: [QueryParameter(QueryOptions.DoNotQuery)]
  @JsonKey(includeFromJson: false, includeToJson: false)
  ShipTo? shipTo;

  OrderApprovalParameters({
    this.shipToId,
    this.orderNumber,
    this.orderTotal,
    this.fromDate,
    this.toDate,
    this.orderTotalOperator,
    this.shipTo,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$OrderApprovalParametersToJson(this));
}
