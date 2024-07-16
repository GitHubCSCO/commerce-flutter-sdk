import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/quote_line_mapper.dart';
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
  ProductSettings? productSettings;
  Session? session;
  QuoteDto? quoteDto;

  QuoteDetailsBloc({required QuoteDetailsUsecase quoteDetailsUsecase})
      : _quoteDetailsUsecase = quoteDetailsUsecase,
        super(QuoteDetailsInitialState()) {
    on<LoadQuoteDetailsDataEvent>(_onLoadQuoteDetailsDataEvent);
    on<QuoteDetailsInitEvent>(_onLoadQuoteDetailsInitialEvent);
    on<DeleteQuoteEvent>(_onDeleteSalesQuoteEvent);
    on<SubmitQuoteEvent>(_onSubmitQuoteEvent);
    on<AcceptQuoteEvent>(_onAcceptQuoteEvent);
  }

  Future<void> _onLoadQuoteDetailsInitialEvent(
      QuoteDetailsInitEvent event, Emitter<QuoteDetailsState> emit) async {
    var sessionResponse = await _quoteDetailsUsecase.getCurrentSession();
    session = sessionResponse is Success
        ? (sessionResponse as Success).value as Session
        : null;
    var productSettingsResult =
        await _quoteDetailsUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;
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
    var isUserAuthenticatedResponse =
        await _quoteDetailsUsecase.isAuthenticatedAsync();

    bool? isAuthenticated = isUserAuthenticatedResponse is Success
        ? (isUserAuthenticatedResponse as Success).value as bool
        : false;

    if (isAuthenticated == true) {
      var checkoutUrl = await _quoteDetailsUsecase.getCheckoutUrl();
      if (checkoutUrl.isNullOrEmpty) {
      } else {}
    } else {}
  }

  Future<void> _onSubmitQuoteEvent(
      SubmitQuoteEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoadingState());
    var submitQuoteResponse =
        await _quoteDetailsUsecase.submitQuote(event.quoteDto);
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

  List<QuoteLineEntity> getQuoteLineEntities(QuoteDto quote) {
    List<QuoteLineEntity> quoteLineEntities = [];
    for (var quoteLine in quote.quoteLineCollection ?? []) {
      var quoteLineEntity = QuoteLineEntityMapper.toEntity(quoteLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              quoteLine.availability.messageType != 0;
      quoteLineEntity = quoteLineEntity.copyWith(
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
        i < quoteLineEntity.pricing!.unitListBreakPrices!.length;
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

  bool get isSalesPerson => session != null && session?.isSalesPerson == true;

  bool expirationDateIsGreaterThanCurrentDate() {
    if (quoteDto == null || quoteDto?.expirationDate == null) {
      return true;
    }

    return quoteDto!.expirationDate!.isAfter(DateTime.now()) ||
        quoteDto!.expirationDate!.isAtSameMomentAs(DateTime.now());
  }

  bool get canBeAccepted {
    var expirationDateIsValid = expirationDateIsGreaterThanCurrentDate();
    return !isSalesPerson &&
        quoteDto?.status != null &&
        (quoteDto!.status!.toLowerCase() ==
                QuoteStatus.QuoteProposed.toString().toLowerCase() ||
            quoteDto!.status == QuoteStatus.AwaitingApproval.toString()) &&
        expirationDateIsValid;
  }

  bool get canBeDeclined {
    var expirationDateIsValid = expirationDateIsGreaterThanCurrentDate();
    return !isSalesPerson &&
        quoteDto?.status != null &&
        quoteDto!.status!.toLowerCase() ==
            QuoteStatus.QuoteProposed.toString().toLowerCase() &&
        expirationDateIsValid;
  }
}
