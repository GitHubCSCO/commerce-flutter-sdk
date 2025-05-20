import '../models.dart';

part 'vmi_location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VmiLocationModel extends BaseModel {
  String id;
  String? customerId;
  String? billToId;
  String? shipToId;
  String name;
  bool useBins;
  bool isPrimaryLocation;
  String note;
  Address? customer;

  VmiLocationModel({
    required this.id,
    this.customerId,
    this.billToId,
    this.shipToId,
    required this.name,
    required this.useBins,
    required this.isPrimaryLocation,
    required this.note,
    required this.customer,
  });

  factory VmiLocationModel.fromJson(Map<String, dynamic> json) =>
      _$VmiLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VmiLocationModelToJson(this);
}
