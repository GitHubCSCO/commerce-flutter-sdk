import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/request_quote_type.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/request_quote_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RequestQuoteBloc extends Bloc<RequestQuoteEvent, RequestQuoteState> {
  final RequestQuoteUsecase _requestQuoteUsecase;
  Cart? cart;
  ProductSettings? productSettings;
  Session? session;
  CatalogTypeDto? selectedUser;

  String? msgUserIsRequired;

  RequestQuoteBloc({required RequestQuoteUsecase requestQuoteUsecase})
      : _requestQuoteUsecase = requestQuoteUsecase,
        super(RequestQuoteInitial()) {
    on<LoadRequestQuoteCartLinesEvent>(_onLoadRequestQuoteCartLinesEvent);
    on<DeleteCartLineEvent>(_onDeleteCartLine);
    on<RequestQuoteAddCartEvent>(_onRequestQuotedAddCartEvent);
    on<UpdateCartLineEvent>(_updateCartLineEntityEvent);
    on<SubmitQuoteEvent>(_onSubmitQuoteEvent);
    on<SelectUserForSalesRepEvent>(_onSelectUserForSalesRepEvent);
  }

  Future<void> _onSelectUserForSalesRepEvent(
      SelectUserForSalesRepEvent event, Emitter<RequestQuoteState> emit) async {
    selectedUser = event.selectedUser;
  }

  Future<void> _onRequestQuotedAddCartEvent(
      RequestQuoteAddCartEvent event, Emitter<RequestQuoteState> emit) async {
    cart = event.cart;
    var sessionResponse = await _requestQuoteUsecase.getCurrentSession();
    session = sessionResponse is Success
        ? (sessionResponse as Success).value as Session
        : null;
    msgUserIsRequired = await _requestQuoteUsecase.getSiteMessage(
        SiteMessageConstants.nameRfqUserIsRequired,
        SiteMessageConstants.defaultValueRfqUserIsRequired);
    emit(RequestAddCartInitSuccessState());
  }

  Future<void> _onLoadRequestQuoteCartLinesEvent(
      LoadRequestQuoteCartLinesEvent event,
      Emitter<RequestQuoteState> emit) async {
    emit(RequestQuoteCartLinesLoading());

    var productSettingsResult =
        await _requestQuoteUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    var cartlinesResponse = await _requestQuoteUsecase.getCartLinesAsync();

    switch (cartlinesResponse) {
      case Success(value: final data):
        emit(RequestQuoteCartLinesLoaded(
            cartLineEntities: getCartLineEntities(data?.cartLines ?? [])));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(RequestQuoteCartLinesError(
            message: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onSubmitQuoteEvent(
      SubmitQuoteEvent event, Emitter<RequestQuoteState> emit) async {
    emit(SubmitQuoteLoadingState());

    bool isJobQuote = event.requestQuoteType == RequestQuoteType.jobQuote;
    var newQuoteResponse;
    if (isSalesPerson) {
      if (selectedUser == null) {
        emit(SubmitQuoteErrorState(message: msgUserIsRequired ?? ''));
        return;
      }

      var param = SalesRepRequesteAQuoteParameters(
          isJobQuote: isJobQuote,
          quoteId: "current",
          jobName: event.jobName,
          note: event.note,
          userId: selectedUser?.id);

      newQuoteResponse = await _requestQuoteUsecase.requestQuote(param);
    } else {
      var param = RequesteAQuoteParameters(
          isJobQuote: isJobQuote,
          quoteId: "current",
          jobName: event.jobName,
          note: event.note);
      newQuoteResponse = await _requestQuoteUsecase.requestQuote(param);
    }

    switch (newQuoteResponse) {
      case Success(value: final data):
        if (data != null) {
          emit(SubmitQuoteSuccessState(quoteDto: data));
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(SubmitQuoteErrorState(
            message: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _updateCartLineEntityEvent(
      UpdateCartLineEvent event, Emitter<RequestQuoteState> emit) async {
    emit(RequestQuoteCartLinesLoading());
    var cartLineModel = CartLineEntityMapper.toModel(event.cartLineEntity);

    var cartlineUpdateResponse =
        await _requestQuoteUsecase.updateCartLine(cartLineModel);

    switch (cartlineUpdateResponse) {
      case Success(value: final data):
        if (data != null && data.isQtyAdjusted == true) {}
        emit(UpdateCartlineSuccessState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(UpdateCartlineErrorState());
        break;
    }
  }

  Future<void> _onDeleteCartLine(
      DeleteCartLineEvent event, Emitter<RequestQuoteState> emit) async {
    emit(RequestQuoteCartLinesLoading());

    var cartLineModel = CartLineEntityMapper.toModel(event.cartLineEntity);

    var cartlineDeleteResponse =
        await _requestQuoteUsecase.deleteCartLine(cartLineModel);

    switch (cartlineDeleteResponse) {
      case Success(value: final data):
        if (data == true) {
          emit(DeleteCartLineSuccessState());
        }
        emit(DeleteCartLineErrorState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(DeleteCartLineErrorState());
        break;
    }
  }

  List<CartLineEntity> getCartLineEntities(List<CartLine>? cartLines) {
    List<CartLineEntity> cartLineEntities = [];
    for (var cartLine in cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper.toEntity(cartLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              cartLine.availability.messageType != 0;
      cartLineEntity = cartLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton,
          status: cart?.status);
      cartLineEntities.add(cartLineEntity);
    }

    return cartLineEntities;
  }

  bool get isSalesPerson => session != null && session?.isSalesPerson == true;

  String get submitQuoteTitle {
    if (isSalesPerson) {
      return LocalizationConstants.createQuote.localized();
    } else {
      return LocalizationConstants.submitQuote.localized();
    }
  }
}
