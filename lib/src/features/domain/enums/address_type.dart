enum AddressType {
  billTo,
  shipTo,
  ;

  factory AddressType.fromJson(Map<String, dynamic> json) =>
      AddressType.values.firstWhere(
        (e) => e.toString().split('.').last == json['addressType'],
      );

  Map<String, dynamic> toJson() => {'addressType': toString().split('.').last};
}
