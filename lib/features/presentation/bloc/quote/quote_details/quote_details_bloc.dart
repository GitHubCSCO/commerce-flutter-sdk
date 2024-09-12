import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/quote_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum QuoteStatus {
  Cart,
  QuoteProposed,
  AwaitingApproval,
  QuoteRejected,
  QuoteRequested,
  QuoteCreated
}

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final QuoteDetailsUsecase _quoteDetailsUsecase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  ProductSettings? productSettings;
  Session? session;
  QuoteDto? quoteDto;
  Cart? cart;
  QuoteSettings? quoteSettings;
  String? deleteQuoteConfirmation;

  QuoteDetailsBloc(
      {required QuoteDetailsUsecase quoteDetailsUsecase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _quoteDetailsUsecase = quoteDetailsUsecase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(QuoteDetailsInitialState()) {
    on<LoadQuoteDetailsDataEvent>(_onLoadQuoteDetailsDataEvent);
    on<QuoteDetailsInitEvent>(_onLoadQuoteDetailsInitialEvent);
    on<DeleteQuoteEvent>(_onDeleteSalesQuoteEvent);
    on<DeclineQuoteEvent>(_onDeclineQuoteEvent);
    on<SubmitQuoteEvent>(_onSubmitQuoteEvent);
    on<AcceptQuoteEvent>(_onAcceptQuoteEvent);
    on<ProceedToCheckoutEvent>(_onProceedToCheckoutEvent);
    on<ExpirationDateSelectEvent>(_onSelectExpirationDate);
    on<QuoteLineNoteUpdateEvent>(_onUpdateQuoteLineNotes);
  }

  Future<void> _onUpdateQuoteLineNotes(
      QuoteLineNoteUpdateEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoadingState());
    var quoteLine = QuoteLineEntityMapper.toModel(event.quoteLineEntity);
    if (quoteLine != null) {
      if (QuoteStatus.Cart.toString() == event.quoteLineEntity.status) {
        var quotelineUpdateResponse =
            await _quoteDetailsUsecase.updateCartLine(quoteLine);
        switch (quotelineUpdateResponse) {
          case Success(value: final data):
            emit(QuotelineNoetUpdateSuccessState());
          case Failure():
            emit(QuotelineNoetUpdateFailureState());
        }
      } else {
        var quotelineUpdateResponse = await _quoteDetailsUsecase.patchQuoteLine(
            event.quoteLineEntity.quoteId ?? "", quoteLine);
        switch (quotelineUpdateResponse) {
          case Success(value: final data):
            emit(QuotelineNoetUpdateSuccessState());
          case Failure():
            emit(QuotelineNoetUpdateFailureState());
        }
      }
    } else {
      emit(QuotelineNoetUpdateFailureState());
    }
  }

  Future<void> _onLoadQuoteDetailsInitialEvent(
      QuoteDetailsInitEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoadingState());
    var sessionResponse = await _quoteDetailsUsecase.getCurrentSession();
    session = sessionResponse is Success
        ? (sessionResponse as Success).value as Session
        : null;
    var productSettingsResult =
        await _quoteDetailsUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;
    var quoteSettingsResult = await _quoteDetailsUsecase.getQuoteSettings();

    quoteSettings = quoteSettingsResult is Success
        ? (quoteSettingsResult as Success).value as QuoteSettings
        : null;

    deleteQuoteConfirmation = await _quoteDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameDeleteQuoteConfirmation,
        SiteMessageConstants.defaultDeleteQuoteConfirmation);

    emit(QuoteDetailsInitializationSuccessState());
  }

  Future<void> _onLoadQuoteDetailsDataEvent(
      LoadQuoteDetailsDataEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoadingState());

    var result = await _quoteDetailsUsecase.getQuote(event.quoteId);
    switch (result) {
      case Success(value: final data):
        if (data != null) {
          quoteDto = data;
          emit(QuoteDetailsLoadedState(
              quoteDto: data, quoteLines: getQuoteLineEntities(data)));
        } else {
          emit(QuoteDetailsFailedState(error: 'Data not found'));
        }

        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteDetailsFailedState(
            error: errorResponse.errorDescription ?? ''));
        break;
      default:
    }
  }

  Future<void> _onAcceptQuoteEvent(
      AcceptQuoteEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(SubmitButtonLoadingState());
    var isUserAuthenticatedResponse =
        await _quoteDetailsUsecase.isAuthenticatedAsync();

    bool? isAuthenticated = isUserAuthenticatedResponse is Success
        ? (isUserAuthenticatedResponse as Success).value as bool
        : false;

    if (isAuthenticated == true) {
      var checkoutUrl = await _quoteDetailsUsecase.getCheckoutUrl();
      if (checkoutUrl.isNullOrEmpty) {
        var cartLinesParameters = CartQueryParameters(
          expand: ['cartlines'],
        );
        var currentCartResponse =
            await _quoteDetailsUsecase.getCurrentCart(cartLinesParameters);
        Cart? currentCart = currentCartResponse is Success
            ? (currentCartResponse as Success).value as Cart
            : null;
        cart = currentCart;
        if (currentCart != null &&
            currentCart.cartLines != null &&
            currentCart.cartLines!.isNotEmpty) {
          emit(QuoteAcceptMessageShowState());
        } else {
          emit(QuoteAcceptMessageBypassState());
        }
      } else {}
    } else {}
  }

  Future<void> _onProceedToCheckoutEvent(
      ProceedToCheckoutEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteAcceptedCheckoutState(cart: quoteDto as Cart?));
  }

  Future<void> _onSelectExpirationDate(
      ExpirationDateSelectEvent event, Emitter<QuoteDetailsState> emit) async {
    quoteDto?.expirationDate = event.expirationDate;
  }

  Future<void> _onSubmitQuoteEvent(
      SubmitQuoteEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(SubmitButtonLoadingState());
    var quoteDto = event.quoteDto;

    if (isSalesPerson) {
      if (quoteDto.expirationDate == null) {
        var expirationMsgResponse = await _quoteDetailsUsecase.getSiteMessage(
            SiteMessageConstants.nameRfqNoExpirationDate,
            SiteMessageConstants.defaultValueRfqNoExpirationDate);
        var expirationMsg = expirationMsgResponse is Success
            ? (expirationMsgResponse as Success).value as String
            : SiteMessageConstants.defaultValueRfqNoExpirationDate;
        emit(ExpirationDateRequiredState(message: expirationMsg));
        return;
      }

      if (quoteDto.expirationDate != null &&
          quoteDto.expirationDate!.day < DateTime.now().day) {
        var pastExpirationDateMessageResponse =
            await _quoteDetailsUsecase.getSiteMessage(
                SiteMessageConstants.nameRfqPastExpirationDate,
                SiteMessageConstants.defaultValueRfqPastExpirationDate);
        var pastExpirationDateMessage =
            pastExpirationDateMessageResponse is Success
                ? (pastExpirationDateMessageResponse as Success).value as String
                : SiteMessageConstants.defaultValueRfqPastExpirationDate;

        emit(PastExpirationDateState(message: pastExpirationDateMessage));
        return;
      }

      quoteDto.status = "QuoteProposed";
    }

    emit(QuoteDetailsLoadingState());

    var submitQuoteResponse = await _quoteDetailsUsecase.submitQuote(quoteDto);
    switch (submitQuoteResponse) {
      case Success(value: final data):
        if (data != null) {
          emit(QuoteSubmissionSuccessState());
        } else {
          emit(QuoteSubmissionFailedState());
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteSubmissionFailedState());
        break;
      default:
    }
  }

  Future<void> _onDeleteSalesQuoteEvent(
      DeleteQuoteEvent event, Emitter<QuoteDetailsState> emit) async {
    var deleteQuoteResponse =
        await _quoteDetailsUsecase.deleteQuote(event.quoteId);
    switch (deleteQuoteResponse) {
      case Success(value: final data):
        if (data == true) {
          emit(QuoteDeletionSuccessState());
        } else {
          emit(QuoteDeletionFailedState());
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteDeletionFailedState());
        break;
      default:
    }
  }

  Future<void> _onDeclineQuoteEvent(
      DeclineQuoteEvent event, Emitter<QuoteDetailsState> emit) async {
    quoteDto?.status = "QuoteRejected";

    emit(QuoteDetailsLoadingState());

    var submitQuoteResponse = await _quoteDetailsUsecase.submitQuote(quoteDto!);
    switch (submitQuoteResponse) {
      case Success(value: final data):
        if (data != null) {
          emit(QuoteDeclineSuccessState());
        } else {
          emit(QuoteDeclineFailedState());
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteDeclineFailedState());
        break;
      default:
    }
  }

  List<QuoteLineEntity> getQuoteLineEntities(QuoteDto quote) {
    List<QuoteLineEntity> quoteLineEntities = [];
    var hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
    var hideInventoryEnable = _pricingInventoryUseCase.getHideInventoryEnable();
    for (var quoteLine in quote.quoteLineCollection ?? []) {
      var quoteLineEntity = QuoteLineEntityMapper.toEntity(quoteLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              quoteLine.availability.messageType != 0;
      quoteLineEntity = quoteLineEntity.copyWith(
          hidePricingEnable: hidePricingEnable,
          hideInventoryEnable: hideInventoryEnable,
          showInventoryAvailability: shouldShowWarehouseInventoryButton,
          quoteStatus: quote.status,
          isJobQuote: quote.isJobQuote,
          quoteId: quote.id,
          quoteLinePricingBreakList:
              _makeBreakPricingEntityList(quoteLineEntity));
      quoteLineEntities.add(quoteLineEntity);
    }

    return quoteLineEntities;
  }

  List<QuoteLinePricingEntity> _makeBreakPricingEntityList(
      QuoteLineEntity quoteLineEntity) {
    List<QuoteLinePricingEntity> quoteLinePricingEntityList = [];

    for (int i = 0;
        i < (quoteLineEntity.pricing?.unitListBreakPrices ?? []).length;
        i++) {
      var quoteLinePricingEntity = QuoteLinePricingEntity(
        qty: quoteLineEntity.pricing?.unitListBreakPrices![i].breakQty!
            .toStringAsFixed(0),
        price:
            quoteLineEntity.pricing?.unitListBreakPrices![i].breakPriceDisplay,
      );

      if (i < quoteLineEntity.pricing!.unitListBreakPrices!.length - 1) {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty:
              '${quoteLinePricingEntity.qty} - ${(quoteLineEntity.pricing!.unitListBreakPrices![i + 1].breakQty! - 1).toStringAsFixed(0)}',
          price: quoteLinePricingEntity.price,
        );
      } else if (quoteLineEntity.maxQty! > 0) {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty:
              '${quoteLinePricingEntity.qty} - ${quoteLineEntity.maxQty!.toStringAsFixed(0)}',
          price: quoteLinePricingEntity.price,
        );
      } else {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty: '${quoteLinePricingEntity.qty}+',
          price: quoteLinePricingEntity.price,
        );
      }

      quoteLinePricingEntityList.add(quoteLinePricingEntity);
    }
    return quoteLinePricingEntityList;
  }

  int get quoteExpireDays {
    if (quoteSettings != null) {
      return quoteSettings!.quoteExpireDays ?? 0;
    }
    return 0;
  }

  bool get isSalesPerson => session != null && session?.isSalesPerson == true;

  bool expirationDateIsGreaterThanCurrentDate() {
    if (quoteDto == null || quoteDto?.expirationDate == null) {
      return true;
    }

    return quoteDto!.expirationDate!.isAfter(DateTime.now()) ||
        quoteDto!.expirationDate!.isAtSameMomentAs(DateTime.now());
  }

  bool get canBeSubmittedOrDeleted {
    if (compareStatus(QuoteStatus.QuoteProposed)) {
      return !isSalesPerson &&
          quoteDto?.status != null &&
          compareStatus(QuoteStatus.QuoteProposed);
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return isSalesPerson &&
          quoteDto?.status != null &&
          !compareStatus(QuoteStatus.QuoteProposed);
    }

    return isSalesPerson && quoteDto != null && (quoteDto!.isEditable == true);
  }

  String get getSubmitTitle {
    if (compareStatus(QuoteStatus.QuoteProposed) && quoteDto?.type == "Job") {
      return LocalizationConstants.acceptJobQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteProposed)) {
      return LocalizationConstants.acceptSalesQuote.localized();
    } else if ((compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) &&
        quoteDto?.type == "Job") {
      return LocalizationConstants.submitJobQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return LocalizationConstants.submitSalesQuote.localized();
    }
    return "";
  }

  String get acceptedTitle {
    if (compareStatus(QuoteStatus.QuoteProposed) && quoteDto?.type == "Job") {
      return LocalizationConstants.acceptJobQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteProposed)) {
      return LocalizationConstants.acceptSalesQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return LocalizationConstants.quoteAll.localized();
    }

    return "";
  }

  String get declineTile {
    if (compareStatus(QuoteStatus.QuoteProposed) && quoteDto?.type == "Job") {
      return LocalizationConstants.declineJobQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteProposed)) {
      return LocalizationConstants.declineSalesQuote.localized();
    } else if ((compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) &&
        quoteDto?.type == "Job") {
      return LocalizationConstants.deleteJobQuote.localized();
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return LocalizationConstants.deleteSalesQuote.localized();
    }

    return "";
  }

  bool get canBeAccepted {
    var expirationDateIsValid = expirationDateIsGreaterThanCurrentDate();

    if (compareStatus(QuoteStatus.QuoteProposed)) {
      return false;
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return isSalesPerson &&
          quoteDto?.status != null &&
          !compareStatus(QuoteStatus.QuoteProposed);
    }

    return false;
  }

  bool get canBeDeclined {
    var expirationDateIsValid = expirationDateIsGreaterThanCurrentDate();

    if (compareStatus(QuoteStatus.QuoteProposed)) {
      return !isSalesPerson &&
          quoteDto?.status != null &&
          compareStatus(QuoteStatus.QuoteProposed) &&
          expirationDateIsValid;
    } else if (compareStatus(QuoteStatus.QuoteRequested) || isSalesPerson) {
      return isSalesPerson &&
          quoteDto?.status != null &&
          !compareStatus(QuoteStatus.QuoteProposed);
    }

    return false;
  }

  String getEnumValueName(QuoteStatus status) {
    return status.toString().split('.').last.toString().toLowerCase();
  }

  bool compareStatus(QuoteStatus status) {
    return quoteDto?.status != null &&
        quoteDto!.status?.toLowerCase() == getEnumValueName(status);
  }

  bool get shouldShowExpirationDate {
    return isSalesPerson;
  }

  bool get isQuoteProposed {
    return compareStatus(QuoteStatus.QuoteProposed);
  }

  bool get isQuoteRequested {
    return compareStatus(QuoteStatus.QuoteRequested);
  }

  bool get isQuoteCreated {
    return compareStatus(QuoteStatus.QuoteCreated);
  }

  bool get isQuoteRejected {
    return compareStatus(QuoteStatus.QuoteRejected);
  }

  String viewQuotedPricingTitle(QuoteLineEntity? quoteLine) {
    if (isQuoteCreated || isQuoteRequested) {
      var priceDisplay = (quoteLine != null &&
              quoteLine.pricingRfq != null &&
              quoteLine.pricingRfq?.priceBreaks != null &&
              quoteLine.pricingRfq!.priceBreaks!.isNotEmpty &&
              !quoteLine.pricingRfq!.priceBreaks![0].priceDisplay.isNullOrEmpty)
          ? quoteLine.pricingRfq?.priceBreaks![0].priceDisplay
          : quoteLine?.pricingRfq?.customerPriceDisplay;
      return '1+         $priceDisplay';
    } else {
      return LocalizationConstants.viewQuotedPricing.localized();
    }
  }

  bool get showViewQuotedPricing {
    return isSalesPerson || isQuoteProposed;
  }

  bool get showQuoteQuantityAndSubtotal {
    return !isSalesPerson && (isQuoteRequested || isQuoteProposed);
  }

  bool get canEditQuantity {
    return isQuoteProposed;
  }

  bool get showQuoteOption {
    if (isSalesPerson &&
        (isQuoteCreated || isQuoteRequested || isQuoteRejected)) {
      return true;
    }

    return false;
  }
}
