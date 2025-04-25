import 'package:collection/collection.dart';
import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/token_ex_view_mode.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaymentDetailsBloc
    extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  final PaymentDetailsUseCase _paymentDetailsUseCase;
  PaymentMethodDto? selectedPaymentMethod;
  Cart? cart;
  CartSettings? settings;
  WebsiteSettings? websiteSettings;
  AccountPaymentProfile? accountPaymentProfile;
  TokenExDto? tokenExConfiguration;
  final _poNumberController = TextEditingController();
  bool isSelectedNewAddedCard = false;
  bool isCreditCardSectionCompleted = false;
  bool isCVVFieldOpened = false;

  PaymentDetailsBloc({required PaymentDetailsUseCase paymentDetailsUseCase})
      : _paymentDetailsUseCase = paymentDetailsUseCase,
        super(PaymentDetailsInitial()) {
    on<LoadPaymentDetailsEvent>(
        (event, emit) async => _loadPaymentDetailsData(event, emit));
    on<UpdatePaymentMethodEvent>(
        (event, emit) async => _updatePaymentMethod(event, emit));
    on<UpdateCreditCartInfoEvent>(
        (event, emit) => _updateCreditCardInfoToCart(event, emit));
    on<UpdateNewAccountPaymentProfileEvent>((event, emit) async {
      await _updateNewAccountPaymentPorfile(event, emit);
    });
    on<ValidateTokenEvent>((event, emit) async {
      emit(PaymentDetailsValidateTokenState());
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
    var cartSettings = await _paymentDetailsUseCase.getCartSetting();
    var webSiteSetting = await _paymentDetailsUseCase.getWebSiteSetting();
    cart = (cartResponse is Success)
        ? (cartResponse as Success).value
        : event.cart;
    settings = cartSettings.getResultSuccessValue();
    websiteSettings = webSiteSetting.getResultSuccessValue();
    _setUpSelectedPaymentMethod(cart!);
    await _setupPaymentDataSources(
        UpdatePaymentMethodEvent(
            isCVVRequired: true, paymentMethodDto: selectedPaymentMethod),
        emit);
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
      emit(_buildPaymentDetailsLoadedState(
          isNewCreditCard: true,
          cardDetails: _getCardDetails(accountPaymentProfile!)));
      return;
    }

    isSelectedNewAddedCard = false;
    var showPOField = cart?.showPoNumber ?? false;

    if (_isCreditCardSelected()) {
      final response = await _fetchPaymentProfiles();
      if (response is Success) {
        final paymentProfiles = response.getResultSuccessValue();
        final creditCard = _findCreditCard(paymentProfiles);

        if (creditCard != null) {
          _populateCartWithCreditCard(creditCard);

          final cardDetails = _getCardDetails(creditCard);

          if (!_isCVVBypassedForSavedCards(creditCard)) {
            if (tokenExConfiguration != null &&
                tokenExConfiguration!.token
                    .equalsIgnoreCase(creditCard.cardIdentifier)) {
              emit(_buildPaymentDetailsLoadedState(
                isNewCreditCard: false,
                cardDetails: cardDetails,
                showPOField: showPOField,
                tokenExEntity: _createTokenExEntity(creditCard),
                isCVVFieldOpened: true,
              ));
              return;
            } else {
              final tokenExResponse =
                  await _fetchTokenExConfiguration(creditCard.cardIdentifier!);

              if (tokenExResponse is Success) {
                final tokenExDto = tokenExResponse.value;
                tokenExConfiguration = tokenExDto;

                emit(_buildPaymentDetailsLoadedState(
                  isNewCreditCard: false,
                  cardDetails: cardDetails,
                  showPOField: showPOField,
                  tokenExEntity: _createTokenExEntity(creditCard),
                  isCVVFieldOpened: true,
                ));
                return;
              }
            }
          }

          emit(_buildPaymentDetailsLoadedState(
            isNewCreditCard: false,
            cardDetails: cardDetails,
            showPOField: showPOField,
          ));
          return;
        }
      }
    }

    emit(_buildPaymentDetailsLoadedState(
      isNewCreditCard: false,
      showPOField: showPOField,
    ));
  }

  bool _isCreditCardSelected() {
    return selectedPaymentMethod != null &&
        selectedPaymentMethod!.isCreditCard == false &&
        selectedPaymentMethod?.cardType != null;
  }

  Future<Result<AccountPaymentProfileCollectionResult, ErrorResponse>>
      _fetchPaymentProfiles() {
    var parameters = PaymentProfileQueryParameters(
        page: 1, pageSize: double.maxFinite.toInt());
    return _paymentDetailsUseCase.getPaymentProfileData(parameters);
  }

  AccountPaymentProfile? _findCreditCard(
      AccountPaymentProfileCollectionResult? paymentProfiles) {
    return paymentProfiles?.accountPaymentProfiles?.firstWhereOrNull(
      (x) => x.cardIdentifier == selectedPaymentMethod!.name,
    );
  }

  void _populateCartWithCreditCard(AccountPaymentProfile creditCard) {
    cart?.paymentOptions ??= PaymentOptionsDto();
    cart?.paymentOptions?.creditCard = CreditCardDto(
      cardHolderName: creditCard.cardHolderName,
      cardNumber: creditCard.cardIdentifier,
      cardType: creditCard.cardType,
      expirationMonth: creditCard.expirationMonth,
      expirationYear: creditCard.expirationYear,
    );
  }

  bool _isCVVBypassedForSavedCards(AccountPaymentProfile creditCard) {
    return settings?.bypassCvvForSavedCards == true;
  }

  Future<Result> _fetchTokenExConfiguration(String cardIdentifier) {
    return _paymentDetailsUseCase.getTokenExConfiguration(cardIdentifier);
  }

  TokenExEntity _createTokenExEntity(AccountPaymentProfile creditCard) {
    return TokenExEntity(
      tokenExConfiguration: tokenExConfiguration,
      tokenexStyle: TokenExStyleDto(
        baseColor: OptiAppColors.lightGrayTextColor.toString(),
        focusColor: OptiAppColors.primaryColor.toString(),
        errorColor: OptiAppColors.invalidColor.toString(),
        textColor: OptiAppColors.darkGrayTextColor.toString(),
      ),
      tokenexMode: TokenExViewMode.cvv,
      cardType: creditCard.cardType,
      tokenExUrl: _paymentDetailsUseCase.tokenExIFrameUrl,
    );
  }

  PaymentDetailsLoaded _buildPaymentDetailsLoadedState({
    required bool isNewCreditCard,
    TokenExEntity? tokenExEntity,
    String? cardDetails,
    bool showPOField = false,
    bool isCVVFieldOpened = false,
  }) {
    this.isCVVFieldOpened = isCVVFieldOpened;
    return PaymentDetailsLoaded(
        isNewCreditCard: isNewCreditCard,
        tokenExEntity: tokenExEntity,
        cardDetails: cardDetails,
        showPOField: showPOField,
        poTextEditingController: _poNumberController,
        cart: cart,
        useTokenExGateway: websiteSettings?.useTokenExGateway ?? false,
        useSpreedlyDropIn: websiteSettings?.useSpreedlyDropIn ?? false);
  }

  String _getCardDetails(AccountPaymentProfile creditCard) {
    var creditCardType = creditCard.cardType!.capitalize();
    return "$creditCardType ${creditCard.maskedCardNumber} ${creditCard.expirationDate}";
  }

  void _setUpSelectedPaymentMethod(Cart cart) {
    if (cart.paymentOptions?.paymentMethods != null) {
      var paymentMethods = cart.paymentOptions!.paymentMethods!;
      if (cart.paymentMethod?.isCreditCard != null &&
          cart.paymentMethod?.isCreditCard == false) {
        selectedPaymentMethod = cart.paymentMethod;
      }

      if (selectedPaymentMethod == null) {
        for (var method in paymentMethods) {
          if (method.isCreditCard == false) {
            selectedPaymentMethod = method;
            cart.paymentMethod = selectedPaymentMethod;
            break;
          }
        }
      } else {
        for (var method in paymentMethods) {
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
  }

  String getPONumber() {
    return _poNumberController.text;
  }

  List<PaymentMethodDto>? getPaymentMethods(Cart? cart) {
    List<PaymentMethodDto>? paymentMethods = [];

    if (cart?.paymentOptions?.paymentMethods != null) {
      for (var paymentMethod in cart!.paymentOptions!.paymentMethods!) {
        if (paymentMethod.isCreditCard == null ||
            !paymentMethod.isCreditCard!) {
          paymentMethods.add(paymentMethod);
        }
      }
    }

    return paymentMethods;
  }
}
