import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_sdk/features/domain/enums/token_ex_view_mode.dart';

class TokenExEntity extends Equatable {
  TokenExDto? tokenExConfiguration;
  TokenExStyleDto? tokenexStyle;
  TokenExViewMode? tokenexMode;
  String? cardType = "";
  String? tokenExUrl;

  TokenExEntity(
      {this.tokenExConfiguration,
      this.tokenexStyle,
      this.tokenexMode,
      this.cardType,
      this.tokenExUrl});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  TokenExEntity copyWith(
      {TokenExDto? tokenExConfiguration,
      TokenExStyleDto? tokenexStyle,
      TokenExViewMode? tokenexMode,
      String? cardType,
      String? tokenExUrl}) {
    return TokenExEntity(
        tokenExConfiguration: tokenExConfiguration ?? this.tokenExConfiguration,
        tokenexStyle: tokenexStyle ?? this.tokenexStyle,
        tokenexMode: tokenexMode ?? this.tokenexMode,
        cardType: cardType ?? this.cardType,
        tokenExUrl: tokenExUrl ?? this.tokenExUrl);
  }
}
