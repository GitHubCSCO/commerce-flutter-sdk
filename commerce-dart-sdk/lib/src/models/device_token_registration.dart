import 'models.dart';

part 'device_token_registration.g.dart';

/// Request model for registering a device token
@JsonSerializable()
class DeviceTokenRegistrationParameters {
  String? deviceToken;
  String? userProfileId;

  DeviceTokenRegistrationParameters({
    this.deviceToken,
    this.userProfileId,
  });

  factory DeviceTokenRegistrationParameters.fromJson(
          Map<String, dynamic> json) =>
      _$DeviceTokenRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenRegistrationRequestToJson(this);
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
