import 'models.dart';

part 'share_entity.g.dart';

@JsonSerializable()
class ShareEntity extends BaseModel {
  String? emailTo;

  String? emailFrom;

  String? subject;

  String? message;

  String? entityId;

  String? entityName;

  ShareEntity({
    this.emailTo,
    this.emailFrom,
    this.subject,
    this.message,
    this.entityId,
    this.entityName,
  });

  factory ShareEntity.fromJson(Map<String, dynamic> json) =>
      _$ShareEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShareEntityToJson(this);
}
