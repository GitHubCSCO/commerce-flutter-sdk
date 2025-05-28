import '../models.dart';

part 'account_result.g.dart';

@JsonSerializable()
class AccountResult extends BaseModel {
  List<Account>? accounts;

  Pagination? pagination;

  AccountResult({
    this.accounts,
    this.pagination,
  });

  factory AccountResult.fromJson(Map<String, dynamic> json) =>
      _$AccountResultFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResultToJson(this);
}
