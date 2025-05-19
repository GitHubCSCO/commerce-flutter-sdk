import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'translation_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class TranslationQueryParameters extends BaseQueryParameters {
  String? keyword;

  String? source;

  String? languageCode;

  TranslationQueryParameters({
    this.keyword,
    this.source,
    this.languageCode,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$TranslationQueryParametersToJson(this));
}
