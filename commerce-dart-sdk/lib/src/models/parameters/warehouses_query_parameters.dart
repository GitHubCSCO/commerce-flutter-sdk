import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'warehouses_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class WarehousesQueryParameters extends BaseQueryParameters {
  double? latitude;

  double? longitude;

  bool? onlyPickupWarehouses;

  bool? useDefaultLocation;

  int? radius;

  bool? excludeCurrentPickupWarehouse;

  /// Options: properties
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  WarehousesQueryParameters({
    this.latitude = 0,
    this.longitude = 0,
    this.onlyPickupWarehouses = true,
    this.useDefaultLocation,
    this.radius,
    this.excludeCurrentPickupWarehouse,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WarehousesQueryParametersToJson(this));
}
