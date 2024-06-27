import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';

abstract class TokenExState {}

class TokenExInitial extends TokenExState {}

class TokenExLoading extends TokenExState {}

class TokenExLoaded extends TokenExState {
  final TokenExEntity tokenExEntity;
  TokenExLoaded({required this.tokenExEntity});
}

class TokenExEncodeState extends TokenExState {
  TokenExEncodeState();
}

class TokenExValidateState extends TokenExState {
  TokenExValidateState();
}

class TokenExEncodingFinishedState extends TokenExState {
  final String cardNumber;
  final String cardType;
  final String securityCode;
  TokenExEncodingFinishedState(
      {required this.cardNumber,
      required this.cardType,
      required this.securityCode});
}

class TokenExInvalidCvvState extends TokenExState {
  bool showInvalidCVV;
  TokenExInvalidCvvState(this.showInvalidCVV);
}
