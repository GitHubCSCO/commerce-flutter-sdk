import 'dart:ffi';
import 'dart:math';

import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaymentDetailsBloc
    extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  final PaymentDetailsUseCase _paymentDetailsUseCase;
  PaymentMethodDto? selectedPaymentMethod;
  PaymentDetailsBloc({required PaymentDetailsUseCase paymentDetailsUseCase})
      : _paymentDetailsUseCase = paymentDetailsUseCase,
        super(PaymentDetailsInitial()) {
    on<LoadPaymentDetailsEvent>(
        (event, emit) => _loadPaymentDetailsData(event, emit));
    on<UpdatePaymentMethodEvent>((event, emit) =>
        _updatePaymentMethod(event, emit));
  }

  Future<void> _loadPaymentDetailsData(
      LoadPaymentDetailsEvent event, Emitter<PaymentDetailsState> emit) async {
    emit(PaymentDetailsLoading());
    setUpSelectedPaymentMethod(event.cart);
    var paymentMethodValue = getCurrentlySelectedPaymentMethodTitle();
    emit(PaymentDetailsLoaded(paymentMethodValue: paymentMethodValue));
  }

  Future<void> _updatePaymentMethod(
      UpdatePaymentMethodEvent event, Emitter<PaymentDetailsState> emit) async {
    selectedPaymentMethod = event.paymentMethodDto;
    var paymentMethodValue = getCurrentlySelectedPaymentMethodTitle();
    emit(PaymentDetailsLoaded(paymentMethodValue: paymentMethodValue));
  }

  void setUpSelectedPaymentMethod(Cart cart) {
    if (cart.paymentOptions?.paymentMethods != null) {
      List<PaymentMethodDto> paymentMethods =
          cart.paymentOptions!.paymentMethods!;
      selectedPaymentMethod = cart.paymentMethod;

      if (selectedPaymentMethod == null) {
        selectedPaymentMethod = paymentMethods.first;
        cart.paymentMethod = selectedPaymentMethod;
      } else {
        for (PaymentMethodDto method in paymentMethods) {
          if (method.name == selectedPaymentMethod?.name) {
            selectedPaymentMethod = method;
            break;
          }
        }
      }
    }
  }

  String getCurrentlySelectedPaymentMethodTitle() {
    String paymentMethodValue = '';

    if (selectedPaymentMethod != null) {
      if (selectedPaymentMethod?.description == null ||
          selectedPaymentMethod!.description!.trim().isEmpty) {
        paymentMethodValue = selectedPaymentMethod?.name ?? "";
      } else {
        paymentMethodValue = selectedPaymentMethod!.description!;
      }
    }

    return paymentMethodValue;
  }
}
