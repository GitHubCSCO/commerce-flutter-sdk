import 'models.dart';

part 'site_message.g.dart';

@JsonSerializable()
class SiteMessage {
  String? name;

  String? message;

  String? languageCode;

  SiteMessage({this.name, this.message, this.languageCode});

  factory SiteMessage.fromJson(Map<String, dynamic> json) =>
      _$SiteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SiteMessageToJson(this);
}
