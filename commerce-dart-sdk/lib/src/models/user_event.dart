import 'package:json_annotation/json_annotation.dart';

part 'user_event.g.dart';

@JsonSerializable()
class UserEvent {
  final String? eventName;
  final String? emailAddress;
  final String? fullName;
  final EventProperties? properties;

  UserEvent({
    this.eventName,
    this.emailAddress,
    this.fullName,
    this.properties,
  });

  factory UserEvent.fromJson(Map<String, dynamic> json) =>
      _$UserEventFromJson(json);
  Map<String, dynamic> toJson() => _$UserEventToJson(this);
}

@JsonSerializable()
class EventProperties {
  final String? appVersion;
  final int? customTrait2;

  EventProperties({
    this.appVersion,
    this.customTrait2,
  });

  factory EventProperties.fromJson(Map<String, dynamic> json) =>
      _$EventPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$EventPropertiesToJson(this);
}

@JsonSerializable()
class EventResponse {
  final bool? success;
  final String? message;

  EventResponse({this.success, this.message});

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}
