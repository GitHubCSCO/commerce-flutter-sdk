import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'token_ex_config_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class TokenExConfigQueryParameters extends BaseQueryParameters {
  String? token;

  String? origin;

  bool? isECheck;

  TokenExConfigQueryParameters({
    this.token,
    this.origin,
    this.isECheck,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() => _$TokenExConfigQueryParametersToJson(this);
}
