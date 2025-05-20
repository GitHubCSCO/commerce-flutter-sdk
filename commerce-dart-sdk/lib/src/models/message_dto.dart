import 'models.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto extends BaseModel {
  String? customerOrderId;

  String? toUserProfileId;

  String? toUserProfileName;

  String? subject;

  String? message;

  String? process;

  MessageDto({
    this.customerOrderId,
    this.toUserProfileId,
    this.toUserProfileName,
    this.subject,
    this.message,
    this.process,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
