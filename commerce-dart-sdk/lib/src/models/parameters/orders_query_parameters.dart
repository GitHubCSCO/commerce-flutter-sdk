import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'orders_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class OrdersQueryParameters extends BaseQueryParameters {
  String? orderNumber;

  String? poNumber;

  String? search;

  List<String>? status;

  String customerSequence;

  DateTime? fromDate;

  DateTime? toDate;

  String? orderTotalOperator;

  num? orderTotal;

  String? productErpNumber;

  bool? showMyOrders;

  bool? vmiOrdersOnly;

  String? vmiLocationId;

  String? vmiBinId;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  OrdersQueryParameters({
    this.orderNumber,
    this.poNumber,
    this.search,
    this.status,
    this.customerSequence = '-1', // show all
    this.fromDate,
    this.toDate,
    this.orderTotalOperator,
    this.orderTotal,
    this.productErpNumber,
    this.showMyOrders,
    this.vmiOrdersOnly,
    this.vmiLocationId,
    this.vmiBinId,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$OrdersQueryParametersToJson(this));
}
