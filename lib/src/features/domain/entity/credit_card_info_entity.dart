// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreditCardInfoEntity extends Equatable {
  final String cardIdentifier;
  final String securityCode;
  final String cardType;
  final String maskedCardNumber;

  CreditCardInfoEntity(
      {required this.cardIdentifier,
      this.securityCode = '',
      required this.cardType,
      this.maskedCardNumber = ''});

  CreditCardInfoEntity copyWith({
    String? cardIdentifier,
    String? securityCode,
    String? cardType,
  }) {
    return CreditCardInfoEntity(
      cardIdentifier: cardIdentifier ?? this.cardIdentifier,
      securityCode: securityCode ?? this.securityCode,
      cardType: cardType ?? this.cardType,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
