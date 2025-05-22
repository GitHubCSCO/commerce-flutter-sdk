import '../models.dart';

part 'get_order_status_mappings_result.g.dart';

@JsonSerializable()
class GetOrderStatusMappingsResult extends BaseModel {
  List<OrderStatusMapping>? orderStatusMappings;

  GetOrderStatusMappingsResult({this.orderStatusMappings});

  factory GetOrderStatusMappingsResult.fromJson(Map<String, dynamic> json) =>
      _$GetOrderStatusMappingsResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderStatusMappingsResultToJson(this);
}
