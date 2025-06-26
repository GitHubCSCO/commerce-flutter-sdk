import 'package:json_annotation/json_annotation.dart';

part 'user_event.g.dart';

@JsonSerializable()
class UserEvent {
  final String? eventName;
  final Map<String, dynamic>? properties;

  UserEvent({
    this.eventName,
    this.properties,
  });

  factory UserEvent.fromJson(Map<String, dynamic> json) =>
      _$UserEventFromJson(json);
  Map<String, dynamic> toJson() => _$UserEventToJson(this);
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
