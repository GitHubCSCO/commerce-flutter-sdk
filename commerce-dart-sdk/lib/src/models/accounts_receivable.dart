import 'models.dart';

part 'accounts_receivable.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountsReceivable {
  AccountsReceivable({
    this.agingBucketFuture,
    this.agingBucketTotal,
    this.agingBuckets,
  });

  List<AgingBucket>? agingBuckets;

  AgingBucket? agingBucketTotal;

  AgingBucket? agingBucketFuture;

  factory AccountsReceivable.fromJson(Map<String, dynamic> json) =>
      _$AccountsReceivableFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsReceivableToJson(this);
}
