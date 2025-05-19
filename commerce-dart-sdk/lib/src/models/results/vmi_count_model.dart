import '../models.dart';
part 'vmi_count_model.g.dart';

@JsonSerializable()
class VmiCountModel extends BaseModel {
  String? id;
  String vmiBinId;
  String? productId;
  double? count;
  String? createdBy;
  @JsonKey(ignore: true)
  DateTime? createdOn;

  VmiCountModel({
    this.id,
    required this.vmiBinId,
    this.productId,
    this.count,
    this.createdBy,
    this.createdOn,
  });

  factory VmiCountModel.fromJson(Map<String, dynamic> json) =>
      _$VmiCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$VmiCountModelToJson(this);
}
