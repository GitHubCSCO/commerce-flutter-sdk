import '../models.dart';
part 'vmi_bin_model.g.dart';

@JsonSerializable()
class VmiBinModel extends BaseModel {
  String id;
  String vmiLocationId;
  String binNumber;
  String? productId;
  double? minimumQty;
  double? maximumQty;
  DateTime? lastCountDate;
  double? lastCountQty;
  String? lastCountUserName;
  DateTime? previousCountDate;
  double? previousCountQty;
  String? previousCountUserName;
  DateTime? lastOrderDate;
  Product? product;

  VmiBinModel({
    required this.id,
    required this.vmiLocationId,
    this.binNumber = '',
    this.productId,
    this.minimumQty,
    this.maximumQty,
    this.lastCountDate,
    this.lastCountQty,
    this.lastCountUserName,
    this.previousCountDate,
    this.previousCountQty,
    this.previousCountUserName,
    this.lastOrderDate,
    this.product,
  });

  factory VmiBinModel.fromJson(Map<String, dynamic> json) =>
      _$VmiBinModelFromJson(json);

  Map<String, dynamic> toJson() => _$VmiBinModelToJson(this);
}
