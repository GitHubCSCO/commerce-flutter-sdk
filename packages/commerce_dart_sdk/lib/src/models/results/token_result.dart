import '../models.dart';

part 'token_result.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenResult {
  TokenResult({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.tokenType,
  });

  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'expires_in')
  int? expiresIn;

  @JsonKey(name: 'token_type')
  String? tokenType;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  factory TokenResult.fromJson(Map<String, dynamic> json) =>
      _$TokenResultFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResultToJson(this);
}
