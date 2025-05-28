import '../models.dart';

part 'job_quote_result.g.dart';

@JsonSerializable()
class JobQuoteResult extends BaseModel {
  List<JobQuoteDto>? jobQuotes;

  Pagination? pagination;

  JobQuoteResult({
    this.jobQuotes,
    this.pagination,
  });

  factory JobQuoteResult.fromJson(Map<String, dynamic> json) =>
      _$JobQuoteResultFromJson(json);

  Map<String, dynamic> toJson() => _$JobQuoteResultToJson(this);
}
