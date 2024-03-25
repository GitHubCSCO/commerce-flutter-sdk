import 'dart:ffi';

import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:flutter/material.dart';

abstract class PaymentDetailsState {}

class PaymentDetailsInitial extends PaymentDetailsState {}

class PaymentDetailsLoading extends PaymentDetailsState {}

class PaymentDetailsLoaded extends PaymentDetailsState {
  final String paymentMethodValue;
  final TokenExEntity? tokenExEntity;
  final bool? showPOField;
  final TextEditingController? poTextEditingController;

  PaymentDetailsLoaded(
      {required this.paymentMethodValue,
      this.tokenExEntity,
      this.showPOField,
      this.poTextEditingController});
}


class PaymentDetailsCompletedState extends PaymentDetailsState{
  
}