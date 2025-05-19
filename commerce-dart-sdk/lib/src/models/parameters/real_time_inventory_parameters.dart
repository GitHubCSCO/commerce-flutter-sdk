import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'real_time_inventory_parameters.g.dart';

@JsonSerializable()
class RealTimeInventoryParameters extends BaseQueryParameters {
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? productIds;

  bool? includeAlternateInventory;

  String? expand;

  RealTimeInventoryParameters({
    this.productIds,
    this.includeAlternateInventory,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  factory RealTimeInventoryParameters.fromJson(Map<String, dynamic> json) =>
      _$RealTimeInventoryParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$RealTimeInventoryParametersToJson(this));
}
