enum LocationSearchType {
  vmi,
  locationFinder,
  pickUpLocation;

  factory LocationSearchType.fromJson(Map<String, dynamic> json) =>
      LocationSearchType.values.firstWhere(
        (e) => e.toString().split('.').last == json['locationSearchType'],
      );

  Map<String, dynamic> toJson() =>
      {'locationSearchType': toString().split('.').last};
}
