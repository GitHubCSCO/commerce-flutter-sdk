import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/credit_card_info_entity.dart';

abstract class TokenExEvent {}

class LoadTokenExFieldEvent extends TokenExEvent {
  final TokenExEntity tokenExEntity;
  LoadTokenExFieldEvent({required this.tokenExEntity});
}

class HandleTokenExEvent extends TokenExEvent {
  final String urlString;
  HandleTokenExEvent({required this.urlString});
}

class TokenExCongigurationSetEvent extends TokenExEvent {
  final bool isConfigurationSet;
  TokenExCongigurationSetEvent({required this.isConfigurationSet});
}

class TokenExValidateEvent extends TokenExEvent {
  TokenExValidateEvent();
}

class UpdateCreditCardInfo extends TokenExEvent {
  final CreditCardInfoEntity cardInfoEntity;
  UpdateCreditCardInfo({required this.cardInfoEntity});
}
