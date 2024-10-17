import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
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
  AccountPaymentProfile? accountPaymentProfile;
  TokenExDto? tokenExConfiguration;
  final _poNumberController = TextEditingController();
  final _orderNotesController = TextEditingController();
  bool isSelectedNewAddedCard = false;
  bool isCreditCardSectionCompleted = false;
  bool isCVVFieldOpened = false;

  PaymentDetailsBloc({required PaymentDetailsUseCase paymentDetailsUseCase})
      : _paymentDetailsUseCase = paymentDetailsUseCase,
        super(PaymentDetailsInitial()) {
    on<LoadPaymentDetailsEvent>(
        (event, emit) => _loadPaymentDetailsData(event, emit));
    on<UpdatePaymentMethodEvent>(
        (event, emit) => _updatePaymentMethod(event, emit));
    on<UpdateCreditCartInfoEvent>(
        (event, emit) => _updateCreditCardInfoToCart(event, emit));
    on<UpdateNewAccountPaymentProfileEvent>((event, emit) async {
      await _updateNewAccountPaymentPorfile(event, emit);
    });
  }

  void _updateCreditCardInfoToCart(
      UpdateCreditCartInfoEvent event, Emitter<PaymentDetailsState> emit) {
    cart?.paymentOptions?.creditCard?.cardNumber = event.cardNumber;
    cart?.paymentOptions?.creditCard?.cardType = event.cardType;
    cart?.paymentOptions?.creditCard?.securityCode = event.securityCode;
    isCreditCardSectionCompleted = true;
    updateCart(emit);
  }

  Future<void> _loadPaymentDetailsData(
      LoadPaymentDetailsEvent event, Emitter<PaymentDetailsState> emit) async {
    emit(PaymentDetailsLoading());

    var cartResponse = await _paymentDetailsUseCase.getCurrentCart();
    cart = (cartResponse is Success)
        ? (cartResponse as Success).value
        : event.cart;
    _setUpSelectedPaymentMethod(cart!);
    var showPOField = cart?.showPoNumber;
    emit(PaymentDetailsLoaded(
        isNewCreditCard: false,
        showPOField: showPOField,
        poTextEditingController: _poNumberController,
        orderNotesTextEditingController: _orderNotesController,
        shouldShowOrderNotes: shouldShowOrderNotes,
        cart: cart));
  }

  Future<void> _updateNewAccountPaymentPorfile(
      UpdateNewAccountPaymentProfileEvent event,
      Emitter<PaymentDetailsState> emit) async {
    cart?.paymentOptions = PaymentOptionsDto(
        creditCard: CreditCardDto(
      cardHolderName: event.accountPaymentProfile.cardHolderName,
      cardNumber: event.accountPaymentProfile.cardIdentifier,
      cardType: event.accountPaymentProfile.cardType,
      expirationMonth: event.accountPaymentProfile.expirationMonth,
      expirationYear: event.accountPaymentProfile.expirationYear,
    ));

    accountPaymentProfile = event.accountPaymentProfile;
  }

  Future<void> _updatePaymentMethod(
      UpdatePaymentMethodEvent event, Emitter<PaymentDetailsState> emit) async {
    selectedPaymentMethod = event.paymentMethodDto;
    await _setupPaymentDataSources(event, emit);
  }

  Future<void> _setupPaymentDataSources(
      UpdatePaymentMethodEvent event, Emitter<PaymentDetailsState> emit) async {
    if (!event.isCVVRequired) {
      isSelectedNewAddedCard = true;
      emit(PaymentDetailsLoaded(
          tokenExEntity: null,
          showPOField: false,
          poTextEditingController: _poNumberController,
          orderNotesTextEditingController: _orderNotesController,
          isNewCreditCard: true,
          cardDetails: _getCardDetails(accountPaymentProfile!),
          shouldShowOrderNotes: shouldShowOrderNotes,
          cart: cart));
      return;
    }
    isSelectedNewAddedCard = false;
    var showPOField = cart?.showPoNumber;
    if (selectedPaymentMethod != null &&
        selectedPaymentMethod?.isCreditCard != null &&
        !selectedPaymentMethod!.isCreditCard! &&
        selectedPaymentMethod?.cardType != null) {
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
                "${creditCard.cardType} ${LocalizationConstants.endingIn.localized()} ${creditCard.cardNumberEnding}";
            var expDate =
                "${LocalizationConstants.expires.localized()} ${creditCard.expirationDate}";

            var cardDetails = _getCardDetails(creditCard);
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
                  isCVVFieldOpened = false;
                  emit(PaymentDetailsLoaded(
                      isNewCreditCard: false,
                      tokenExEntity: null,
                      cardDetails: cardDetails,
                      showPOField: showPOField,
                      poTextEditingController: _poNumberController,
                      orderNotesTextEditingController: _orderNotesController,
                      shouldShowOrderNotes: shouldShowOrderNotes,
                      cart: cart));
                  return;
              }
            }
            isCreditCardSectionCompleted = false;
            isCVVFieldOpened = true;
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

            emit(PaymentDetailsLoaded(
                isNewCreditCard: false,
                tokenExEntity: tokenExEnity,
                cardDetails: cardDetails,
                showPOField: showPOField,
                poTextEditingController: _poNumberController,
                orderNotesTextEditingController: _orderNotesController,
                shouldShowOrderNotes: shouldShowOrderNotes,
                cart: cart));
          }
        case Failure(errorResponse: final errorResponse):
          break;
      }
    } else {
      emit(PaymentDetailsLoaded(
          isNewCreditCard: false,
          tokenExEntity: null,
          showPOField: showPOField,
          poTextEditingController: _poNumberController,
          orderNotesTextEditingController: _orderNotesController,
          shouldShowOrderNotes: shouldShowOrderNotes,
          cart: cart));
    }
  }

  String _getCardDetails(AccountPaymentProfile creditCard) {
    String creditCardType = creditCard.cardType!.capitalize();
    return "$creditCardType ${creditCard.maskedCardNumber} ${creditCard.expirationDate}";
  }

  void _setUpSelectedPaymentMethod(Cart cart) {
    if (cart.paymentOptions?.paymentMethods != null) {
      List<PaymentMethodDto> paymentMethods =
          cart.paymentOptions!.paymentMethods!;
      if (cart.paymentMethod?.isCreditCard != null &&
          cart.paymentMethod?.isCreditCard == false) {
        selectedPaymentMethod = cart.paymentMethod;
      }

      if (selectedPaymentMethod == null) {
        for (PaymentMethodDto method in paymentMethods) {
          if (method.isCreditCard == false) {
            selectedPaymentMethod = method;
            cart.paymentMethod = selectedPaymentMethod;
            break;
          }
        }
      } else {
        for (PaymentMethodDto method in paymentMethods) {
          if (method.name == selectedPaymentMethod?.name &&
              method.isCreditCard == false) {
            selectedPaymentMethod = method;
            break;
          }
        }
      }
    }
  }

  void updateCart(Emitter<PaymentDetailsState> emit) {
    cart?.paymentMethod = selectedPaymentMethod;
    cart?.poNumber = _poNumberController.text;
    cart?.notes = _orderNotesController.text;
  }

  String getPONumber() {
    return _poNumberController.text;
  }

  String getOrderNotes() {
    return _orderNotesController.text;
  }

  List<PaymentMethodDto>? getPaymentMethods(Cart? cart) {
    List<PaymentMethodDto>? paymentMethods = [];

    if (cart?.paymentOptions?.paymentMethods != null) {
      for (PaymentMethodDto paymentMethod
          in cart!.paymentOptions!.paymentMethods!) {
        if (paymentMethod.isCreditCard == null ||
            !paymentMethod.isCreditCard!) {
          paymentMethods.add(paymentMethod);
        }
      }
    }

    return paymentMethods;
  }

  bool get shouldShowOrderNotes {
    return _paymentDetailsUseCase.shouldShowOrderNotes;
  }
}
