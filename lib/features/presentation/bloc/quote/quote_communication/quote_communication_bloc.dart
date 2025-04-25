import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/quote_usecase/quote_communication_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/quote/quote_communication/quote_communication_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/quote/quote_communication/quote_communication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteCommunicationBloc
    extends Bloc<QuoteCommunicationEvent, QuoteCommunicationState> {
  final QuoteCommunicationUsecase _quoteCommunicationUsecase;
  QuoteCommunicationBloc(
      {required QuoteCommunicationUsecase quoteCommunicationUsecase})
      : _quoteCommunicationUsecase = quoteCommunicationUsecase,
        super(QuoteCommunicationInitialState()) {
    on<LoadQuoteQummunicationMessagesEvent>(
        _onLoadQuoteQummunicationMessagesEvent);
    on<QuoteAddMessageEvent>(_onQuoteAddMessageEvent);
  }

  Future<void> _onLoadQuoteQummunicationMessagesEvent(
      LoadQuoteQummunicationMessagesEvent event,
      Emitter<QuoteCommunicationState> emit) async {
    emit(QuoteCommunicationLoadingState());
    var quoteCommunicationResponse =
        await _quoteCommunicationUsecase.getQuote(event.quoteDto.id ?? "");

    switch (quoteCommunicationResponse) {
      case Success(value: final value):
        {
          if (value != null) {
            emit(QuoteCommunicationLoadedState(quoteDto: value));
          } else {
            emit(QuoteCommunicationFailureState(
                message: "Failed to load quote  messages"));
          }
        }

      case Failure(errorResponse: final errorResponse):
        {
          emit(QuoteCommunicationFailureState(
              message: errorResponse.message ?? ""));
          break;
        }
    }
  }

  Future<void> _onQuoteAddMessageEvent(
      QuoteAddMessageEvent event, Emitter<QuoteCommunicationState> emit) async {
    emit(QuoteCommunicationLoadingState());

    var param = MessageDto(
        customerOrderId: event.quoteDto.id,
        message: event.message,
        toUserProfileName: event.quoteDto.initiatedByUserName,
        subject:
            "${LocalizationConstants.quote} ${event.quoteDto.orderNumber} ${LocalizationConstants.communication}",
        process: "RFQ");
    var messageResponse = await _quoteCommunicationUsecase.sendMessage(param);

    switch (messageResponse) {
      case Success(value: final value):
        {
          if (value != null) {
            emit(QuoteCommunicationMessageSendSuccessState(
                quoteDto: event.quoteDto));
          } else {
            emit(QuoteCommunicationMessageSendFailureState());
          }
        }

      case Failure(errorResponse: final errorResponse):
        {
          emit(QuoteCommunicationMessageSendFailureState());
          break;
        }
    }
  }
}
