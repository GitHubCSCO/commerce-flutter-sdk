import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PaymentDetailsState {}

class PaymentDetailsInitial extends PaymentDetailsState {}

class PaymentDetailsLoading extends PaymentDetailsState {}

class PaymentDetailsLoaded extends PaymentDetailsState {
  final TokenExEntity? tokenExEntity;
  final String? cardDetails;
  final bool? showPOField;
  final TextEditingController? poTextEditingController;
  final Cart? cart;
  final bool isNewCreditCard;
  final bool? shouldShowOrderNotes;
  final bool? useTokenExGateway;
  final bool? useSpreedlyDropIn;

  PaymentDetailsLoaded(
      {this.tokenExEntity,
      required this.isNewCreditCard,
      this.cart,
      this.cardDetails,
      this.showPOField,
      this.poTextEditingController,
      this.shouldShowOrderNotes,
      this.useTokenExGateway,
      this.useSpreedlyDropIn});
}

class PaymentDetailsCompletedState extends PaymentDetailsState {}

class PaymentDetailsNewCardSelectedState extends PaymentDetailsState {}

class PaymentDetailsValidateTokenState extends PaymentDetailsState {}
