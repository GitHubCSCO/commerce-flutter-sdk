import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'carts_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class CartsQueryParameters extends BaseQueryParameters {
  String? billToId;

  String? shipToId;

  String? status;

  String? orderNumber;

  DateTime? fromDate;

  DateTime? toDate;

  String? orderTotalOperator;

  num? orderTotal;

  String? orderSubtotalOperator;

  num? orderSubtotal;

  String? vmiLocationId;

  CartsQueryParameters({
    this.billToId,
    this.shipToId,
    this.status,
    this.orderNumber,
    this.fromDate,
    this.toDate,
    this.orderTotalOperator,
    this.orderTotal,
    this.orderSubtotalOperator,
    this.orderSubtotal,
    this.vmiLocationId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$CartsQueryParametersToJson(this));
}
