enum ScanningMode {
  quick,
  count,
  create,
  ;

  factory ScanningMode.fromJson(Map<String, dynamic> json) =>
      ScanningMode.values.firstWhere(
        (e) => e.toString().split('.').last == json['scanningMode'],
      );

  Map<String, dynamic> toJson() => {'scanningMode': toString().split('.').last};
}

enum ScanState {
  success,
  fail,
}
