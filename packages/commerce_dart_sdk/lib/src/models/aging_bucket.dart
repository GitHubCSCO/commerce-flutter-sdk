import 'models.dart';

part 'aging_bucket.g.dart';

@JsonSerializable(explicitToJson: true)
class AgingBucket {
  AgingBucket({
    this.amount,
    this.amountDisplay,
    this.label,
  });

  num? amount;

  String? amountDisplay;

  String? label;

  factory AgingBucket.fromJson(Map<String, dynamic> json) =>
      _$AgingBucketFromJson(json);
  Map<String, dynamic> toJson() => _$AgingBucketToJson(this);
}
