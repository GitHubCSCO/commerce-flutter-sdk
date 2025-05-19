import '../models.dart';

part 'get_ship_tos_result.g.dart';

@JsonSerializable()
class GetShipTosResult extends BaseModel {
  Pagination? pagination;

  List<ShipTo>? shipTos;
  GetShipTosResult({
    this.pagination,
    this.shipTos,
  });

  factory GetShipTosResult.fromJson(Map<String, dynamic> json) =>
      _$GetShipTosResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetShipTosResultToJson(this);
}
