import 'models.dart';

part 'device_token_registration.g.dart';

/// Request model for registering a device token
@JsonSerializable()
class DeviceTokenRegistrationParameters {
  String? deviceToken;

  DeviceTokenRegistrationParameters({
    this.deviceToken,
  });

  factory DeviceTokenRegistrationParameters.fromJson(
          Map<String, dynamic> json) =>
      _$DeviceTokenRegistrationParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DeviceTokenRegistrationParametersToJson(this);
}

/// Response model for device token operations
@JsonSerializable()
class DeviceTokenResponse {
  bool? success;
  String? message;

  DeviceTokenResponse({
    this.success,
    this.message,
  });

  factory DeviceTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenResponseToJson(this);
}
