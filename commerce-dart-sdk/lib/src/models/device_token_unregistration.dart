import 'models.dart';
part 'device_token_unregistration.g.dart';

/// Request model for registering a device token
@JsonSerializable()
class DeviceTokenUnregistrationParameters {
  String? deviceToken;

  DeviceTokenUnregistrationParameters({
    this.deviceToken,
  });

  factory DeviceTokenUnregistrationParameters.fromJson(
          Map<String, dynamic> json) =>
      _$DeviceTokenUnregistrationParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DeviceTokenUnregistrationParametersToJson(this);
}
