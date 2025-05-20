import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_result.g.dart';

@JsonSerializable()
class QuoteResult extends BaseModel {
  List<QuoteDto>? quotes;

  List<SalespersonListDto>? salespersonList;

  Pagination? pagination;

  QuoteResult({
    this.quotes,
    this.salespersonList,
    this.pagination,
  });

  factory QuoteResult.fromJson(Map<String, dynamic> json) =>
      _$QuoteResultFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteResultToJson(this);
}
