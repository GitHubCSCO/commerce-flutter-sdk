import '../models.dart';

part 'vmi_note_model.g.dart';

@JsonSerializable()
class VmiNoteModel extends BaseModel {
  String id;
  String? vmiBinId;
  String note;
  DateTime? createdOn;
  String? vmiBinProductId;
  bool? includeOnOrder;

  VmiNoteModel({
    required this.id,
    this.vmiBinId,
    required this.note,
    this.createdOn,
    this.vmiBinProductId,
    this.includeOnOrder,
  });

  factory VmiNoteModel.fromJson(Map<String, dynamic> json) =>
      _$VmiNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$VmiNoteModelToJson(this);
}
