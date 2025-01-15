enum DeviceAuthenticationOption {
  none,
  touchID,
  faceID,
  ;

  factory DeviceAuthenticationOption.fromJson(Map<String, dynamic> json) =>
      DeviceAuthenticationOption.values.firstWhere(
        (e) =>
            e.toString().split('.').last == json['deviceAuthenticationOption'],
      );

  Map<String, dynamic> toJson() => {
        'deviceAuthenticationOption': toString().split('.').last,
      };
}
