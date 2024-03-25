import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/token_ex_view_mode.dart';
import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaymentDetailsBloc
    extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  final PaymentDetailsUseCase _paymentDetailsUseCase;
  PaymentMethodDto? selectedPaymentMethod;
  Cart? cart;
  TokenExDto? tokenExConfiguration;
  final _poNumberController = TextEditingController();

  PaymentDetailsBloc({required PaymentDetailsUseCase paymentDetailsUseCase})
      : _paymentDetailsUseCase = paymentDetailsUseCase,
        super(PaymentDetailsInitial()) {
    on<LoadPaymentDetailsEvent>(
        (event, emit) => _loadPaymentDetailsData(event, emit));
    on<UpdatePaymentMethodEvent>(
        (event, emit) => _updatePaymentMethod(event, emit));
    on<UpdateCreditCartInfoEvent>(
        (event, emit) => _updateCteditCardInfoToCart(event, emit));
  }

  void _updateCteditCardInfoToCart(
      UpdateCreditCartInfoEvent event, Emitter<PaymentDetailsState> emit) {
    cart?.paymentOptions?.creditCard?.cardNumber = event.cardNumber;
    cart?.paymentOptions?.creditCard?.cardType = event.cardType;
    cart?.paymentOptions?.creditCard?.securityCode = event.securityCode;
    updateCart(emit);
  }

  Future<void> _loadPaymentDetailsData(
      LoadPaymentDetailsEvent event, Emitter<PaymentDetailsState> emit) async {
    emit(PaymentDetailsLoading());
    cart = event.cart;
    _setUpSelectedPaymentMethod(event.cart);
    var paymentMethodValue = _getCurrentlySelectedPaymentMethodTitle();
    var showPOField = cart?.showPoNumber;
    emit(PaymentDetailsLoaded(
        paymentMethodValue: paymentMethodValue,
        showPOField: showPOField,
        poTextEditingController: _poNumberController));
  }

  Future<void> _updatePaymentMethod(
      UpdatePaymentMethodEvent event, Emitter<PaymentDetailsState> emit) async {
    selectedPaymentMethod = event.paymentMethodDto;
    await _setupPaymentDataSources(event, emit);
  }

  Future<void> _setupPaymentDataSources(
      UpdatePaymentMethodEvent event, Emitter<PaymentDetailsState> emit) async {
    var paymentMethodValue = _getCurrentlySelectedPaymentMethodTitle();
    var showPOField = cart?.showPoNumber;
    if (selectedPaymentMethod != null &&
        selectedPaymentMethod?.isCreditCard != null &&
        !selectedPaymentMethod!.isCreditCard!) {
      var parameters = PaymentProfileQueryParameters(
        page: 1,
        pageSize: double.maxFinite.toInt(),
      );

      final response =
          await _paymentDetailsUseCase.getPaymentProfileData(parameters);
      switch (response) {
        case Success(value: final paymentProfiles):
          var creditCard = paymentProfiles?.accountPaymentProfiles?.firstWhere(
              (x) =>
                  x != null && x.cardIdentifier == selectedPaymentMethod!.name);
          if (creditCard != null) {
            if (cart?.paymentOptions == null) {
              cart?.paymentOptions = PaymentOptionsDto();
            }
            if (cart?.paymentOptions?.creditCard == null) {
              cart?.paymentOptions?.creditCard = CreditCardDto();
            }

            cart?.paymentOptions?.creditCard?.cardHolderName =
                creditCard.cardHolderName;
            cart?.paymentOptions?.creditCard?.cardNumber =
                creditCard.cardIdentifier;
            cart?.paymentOptions?.creditCard?.cardType = creditCard.cardType;
            cart?.paymentOptions?.creditCard?.expirationMonth =
                creditCard.expirationMonth;
            cart?.paymentOptions?.creditCard?.expirationYear =
                creditCard.expirationYear;

            // Display information
            var cardName = creditCard.cardHolderName;
            var cardNumber =
                "${creditCard.cardType} ${LocalizationConstants.endingIn} ${creditCard.cardNumberEnding}";
            var expDate =
                "${LocalizationConstants.expires} ${creditCard.expirationDate}";

            if (tokenExConfiguration == null ||
                (tokenExConfiguration != null &&
                    !tokenExConfiguration!.token
                        .equalsIgnoreCase(creditCard.cardIdentifier))) {
              var tokenExResponse = await _paymentDetailsUseCase
                  .getTokenExConfiguration(creditCard.cardIdentifier!);
              switch (tokenExResponse) {
                case Success(value: final tokenExDto):
                  tokenExConfiguration = tokenExDto;
                  break;
                case Failure(errorResponse: final errorResponse):
                  break;
              }
            }

            // if (tokenExConfiguration == null) {
            //   return;
            // }
            var tokenExStyle = TokenExStyleDto(
              baseColor: OptiAppColors.lightGrayTextColor.toString(),
              focusColor: OptiAppColors.primaryColor.toString(),
              errorColor: OptiAppColors.invalidColor.toString(),
              textColor: OptiAppColors.darkGrayTextColor.toString(),
            );

            var tokeExUrl = _paymentDetailsUseCase.tokenExIFrameUrl;
            var tokenExEnity = TokenExEntity(
                tokenExConfiguration: tokenExConfiguration,
                tokenexStyle: tokenExStyle,
                tokenexMode: TokenExViewMode.cvv,
                cardType: creditCard.cardType,
                tokenExUrl: tokeExUrl);

            // if (emit.isDone) return;

            emit(PaymentDetailsLoaded(
                paymentMethodValue: paymentMethodValue,
                tokenExEntity: tokenExEnity,
                showPOField: showPOField,
                poTextEditingController: _poNumberController));
          }
        case Failure(errorResponse: final errorResponse):
          break;
      }
    } else {
      emit(PaymentDetailsLoaded(
          paymentMethodValue: paymentMethodValue,
          showPOField: showPOField,
          poTextEditingController: _poNumberController));
    }
  }

  void _setUpSelectedPaymentMethod(Cart cart) {
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

  String _getCurrentlySelectedPaymentMethodTitle() {
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

  void updateCart(
       Emitter<PaymentDetailsState> emit) {
    cart?.paymentMethod = selectedPaymentMethod;
    cart?.poNumber = _poNumberController.text;
    emit(PaymentDetailsCompletedState());
  }
}
