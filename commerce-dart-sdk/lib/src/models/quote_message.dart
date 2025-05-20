import 'models.dart';

part 'quote_message.g.dart';

@JsonSerializable()
class QuoteMessage extends BaseModel {
  DateTime? createdDate;

  String? quoteId;

  String? message;

  String? displayName;

  String? body;

  QuoteMessage({
    this.createdDate,
    this.quoteId,
    this.message,
    this.displayName,
    this.body,
  });

  factory QuoteMessage.fromJson(Map<String, dynamic> json) =>
      _$QuoteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteMessageToJson(this);
}
