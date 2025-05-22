import 'models.dart';

part 'availability.g.dart';

@JsonSerializable(explicitToJson: true)
class Availability extends BaseModel {
  Availability({
    this.message,
    this.messageType,
    this.requiresRealTimeInventory,
  });

  int? messageType;
  String? message;
  bool? requiresRealTimeInventory;

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}
