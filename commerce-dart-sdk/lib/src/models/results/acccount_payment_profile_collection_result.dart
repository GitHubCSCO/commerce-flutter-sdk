import '../models.dart';

part 'acccount_payment_profile_collection_result.g.dart';

@JsonSerializable()
class AccountPaymentProfileCollectionResult extends BaseModel {
  /// Gets or sets the account payment profile collection.
  List<AccountPaymentProfile>? accountPaymentProfiles;

  /// Gets or sets the pagging.
  Pagination? pagination;

  AccountPaymentProfileCollectionResult({
    this.accountPaymentProfiles,
    this.pagination,
  });

  factory AccountPaymentProfileCollectionResult.fromJson(
          Map<String, dynamic> json) =>
      _$AccountPaymentProfileCollectionResultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AccountPaymentProfileCollectionResultToJson(this);
}
