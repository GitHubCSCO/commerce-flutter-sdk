import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/token_ex_view_mode.dart';
import 'package:commerce_flutter_app/features/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardBloc extends Bloc<AddCreditCardEvent, AddCreditCardState> {
  final AddCreditCardUsecase _addCreditCardUsecase;

  bool useAsDefaultCard = false;

  String messageNameRequired =
      SiteMessageConstants.defaultValueAddressNameRequired;
  String messageCountryRequired =
      SiteMessageConstants.defaultValueAddressCountryRequired;
  String messageCityRequired =
      SiteMessageConstants.defaultValueAddressCityRequired;
  String messageZipRequired =
      SiteMessageConstants.defaultValueAddressZipRequired;
  String messageStateRequired =
      SiteMessageConstants.defaultAllProductCountExceed;

  AddCreditCardBloc({required AddCreditCardUsecase addCreditCardUsecase})
      : _addCreditCardUsecase = addCreditCardUsecase,
        super(AddCreditCardInitialState()) {
    on<SetUpDataSourceEvent>(_onSetUpDataSourceEvent);
    on<SavePaymentProfileEvent>(_onSavePaymentProfile);
    on<UpdateUseAsDefaultCardEvent>(_onUpdateUseAsDefaultCard);
    on<DeletCreditCardEvent>(_onDeleteCreditCard);
  }

  Future<void> _onSetUpDataSourceEvent(
      SetUpDataSourceEvent event, Emitter<AddCreditCardState> emit) async {
    emit(AddCreditCardLoadingState());
    await _loadSiteMessages();
    if (event.addCreditCardEntity?.isAddNewCreditCard == false) {
      useAsDefaultCard =
          event.addCreditCardEntity?.accountPaymentProfile?.isDefault ?? false;
    }

    var currentCartResponse = await _addCreditCardUsecase.getCurrentCart();

    Cart currentCart = (currentCartResponse is Success)
        ? (currentCartResponse as Success).value
        : null;
    PaymentOptionsDto? paymentOptions = currentCart.paymentOptions;

    var tokenExStyle = TokenExStyleDto(
      baseColor: OptiAppColors.lightGrayTextColor.toString(),
      focusColor: OptiAppColors.primaryColor.toString(),
      errorColor: OptiAppColors.invalidColor.toString(),
      textColor: OptiAppColors.darkGrayTextColor.toString(),
    );

    var tokenExResponse =
        await _addCreditCardUsecase.getTokenExConfiguration("");

    var tokenExConfiguration = (tokenExResponse is Success)
        ? (tokenExResponse as Success).value
        : null;

    var tokeExUrl = _addCreditCardUsecase.tokenExIFrameUrl;
    var tokenExEnity = TokenExEntity(
        tokenExConfiguration: tokenExConfiguration,
        tokenexStyle: tokenExStyle,
        tokenexMode: TokenExViewMode.full,
        cardType: "",
        tokenExUrl: tokeExUrl);

    emit(AddCreditCardLoadedState(
        tokenExEntity: tokenExEnity,
        expirationMonths: paymentOptions?.expirationMonths,
        expirationYears: paymentOptions?.expirationYears));
  }

  Future<void> _onSavePaymentProfile(
      SavePaymentProfileEvent event, Emitter<AddCreditCardState> emit) async {
    var response = await _addCreditCardUsecase
        .savePaymentProfile(event.accountPaymentProfile);

    switch (response) {
      case Success(value: final value):
        emit(SavedPaymentAddedSuccessState(accountPaymentProfile: value!));

      case Failure(errorResponse: final errorResponse):
        emit(SavedPaymentAddedFailureState(
            errorMessage:
                errorResponse.message ?? "Credit card could not be saved"));
    }
  }

  Future<void> _onUpdateUseAsDefaultCard(UpdateUseAsDefaultCardEvent event,
      Emitter<AddCreditCardState> emit) async {
    useAsDefaultCard = !useAsDefaultCard;
    emit(UseAsDefaultCardUpdatedState());
  }

  Future<void> _onDeleteCreditCard(
      DeletCreditCardEvent event, Emitter<AddCreditCardState> emit) async {
    var response = await _addCreditCardUsecase
        .deleteCreditCard(event.accountPaymentProfile.id ?? "");

    switch (response) {
      case Success(value: final value):
        if (value == true) {
          emit(CreditCardDeletedSuccessState());
        } else {
          emit(CreditCardDeletedFailureState());
        }

      case Failure():
        emit(CreditCardDeletedFailureState());
    }
  }

  Future<void> _loadSiteMessages() async {
    final futureResult = await Future.wait([
      _addCreditCardUsecase.getSiteMessage(
          SiteMessageConstants.nameCreditCardInfoCardHolderNameRequired,
          SiteMessageConstants
              .defaultValueCreditCardInfoCardHolderNameRequired),
      _addCreditCardUsecase.getSiteMessage(
        SiteMessageConstants.nameAddressInfoCountryRequired,
        SiteMessageConstants.defaultValueAddressCountryRequired,
      ),
      _addCreditCardUsecase.getSiteMessage(
        SiteMessageConstants.nameAddressInfoCityRequired,
        SiteMessageConstants.defaultValueAddressCityRequired,
      ),
      _addCreditCardUsecase.getSiteMessage(
        SiteMessageConstants.nameAddressInfoZipRequired,
        SiteMessageConstants.defaultValueAddressZipRequired,
      ),
      _addCreditCardUsecase.getSiteMessage(
        SiteMessageConstants.nameAddressInfoStateRequired,
        SiteMessageConstants.defaultValueAddressStateRequired,
      ),
    ]);

    messageNameRequired = futureResult[0];
    messageCountryRequired = futureResult[1];
    messageCityRequired = futureResult[2];
    messageZipRequired = futureResult[3];
    messageStateRequired = futureResult[4];

    return;
  }
}
