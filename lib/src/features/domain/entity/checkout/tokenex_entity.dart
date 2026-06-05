import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_sdk/src/features/domain/enums/token_ex_view_mode.dart';

class TokenExEntity extends Equatable {
  TokenExDto? tokenExConfiguration;
  TokenExViewMode? tokenexMode;
  String? cardType = "";
  String? tokenExUrl;

  TokenExEntity(
      {this.tokenExConfiguration,
      this.tokenexMode,
      this.cardType,
      this.tokenExUrl});

  @override
  List<Object?> get props =>
      [tokenExConfiguration, tokenexMode, cardType, tokenExUrl];

  TokenExEntity copyWith(
      {TokenExDto? tokenExConfiguration,
      TokenExViewMode? tokenexMode,
      String? cardType,
      String? tokenExUrl}) {
    return TokenExEntity(
        tokenExConfiguration: tokenExConfiguration ?? this.tokenExConfiguration,
        tokenexMode: tokenexMode ?? this.tokenexMode,
        cardType: cardType ?? this.cardType,
        tokenExUrl: tokenExUrl ?? this.tokenExUrl);
  }
}
