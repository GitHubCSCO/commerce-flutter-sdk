enum AccountType {
  standard,
  admin,
  ;

  factory AccountType.fromJson(Map<String, dynamic> json) =>
      AccountType.values.firstWhere(
        (e) => e.toString().split('.').last == json['accountType'],
      );

  Map<String, dynamic> toJson() => {'accountType': toString().split('.').last};
}
