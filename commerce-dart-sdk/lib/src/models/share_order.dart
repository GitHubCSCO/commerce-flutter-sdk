import 'models.dart';

part 'share_order.g.dart';

@JsonSerializable()
class ShareOrder extends BaseModel {
  String? stEmail;

  String? stPostalCode;

  String? emailTo;

  String? emailFrom;

  String? subject;

  String? message;

  String? entityId;

  String? entityName;

  ShareOrder({
    this.stEmail,
    this.stPostalCode,
    this.emailTo,
    this.emailFrom,
    this.subject,
    this.message,
    this.entityId,
    this.entityName,
  });

  factory ShareOrder.fromJson(Map<String, dynamic> json) =>
      _$ShareOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ShareOrderToJson(this);
}
