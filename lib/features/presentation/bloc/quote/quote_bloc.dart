import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/quote_page_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteUsecase _quoteUsecase;
  QuotePageType pageType = QuotePageType.pending;

  QuoteQueryParameters parameter = QuoteQueryParameters(
    pageSize: 16,
    expand: ['saleslist'],
  );

  QuoteBloc({required QuoteUsecase quoteUsecase})
      : _quoteUsecase = quoteUsecase,
        super(QuoteInitial()) {
    on<QuoteLoadEvent>((event, emit) => _onQuoteLoadEvent(event, emit));
  }

  Future<void> _onQuoteLoadEvent(
      QuoteLoadEvent event, Emitter<QuoteState> emit) async {
    emit(QuoteLoading());

    parameter = event.quoteParameters ?? parameter;
    pageType = event.quotePageType;

    switch (event.quotePageType) {
      case QuotePageType.pending:
        var result = await _quoteUsecase.getQuotes(parameter);
        switch (result) {
          case Success(value: final data):
            emit(QuoteLoaded(
                quotePageType: QuotePageType.pending,
                quotes: data?.quotes ?? []));
            break;
          case Failure(errorResponse: final errorResponse):
            emit(QuoteFailed(
                error: errorResponse.errorDescription ?? '',
                quotePageType: QuotePageType.pending));
            break;
        }
        break;

      case QuotePageType.activejobs:
        var result = await _quoteUsecase.getJobQuotes();
        switch (result) {
          case Success(value: final data):
            emit(JobQuoteLoaded(
                quotePageType: QuotePageType.activejobs,
                jobQuotes: data?.jobQuotes ?? []));
            break;
          case Failure(errorResponse: final errorResponse):
            emit(QuoteFailed(
                error: errorResponse.errorDescription ?? '',
                quotePageType: QuotePageType.activejobs));
            break;
        }
        break;
    }
  }

  String get title {
    if (state is QuoteLoaded) {
      final length = ((state as QuoteLoaded).quotes ?? []).length;
      return '$length ${length == 1 ? LocalizationConstants.quote.localized() : LocalizationConstants.quotes.localized()}';
    } else if (state is JobQuoteLoaded) {
      final length = ((state as JobQuoteLoaded).jobQuotes ?? []).length;
      return '$length ${length == 1 ? LocalizationConstants.jobQuote.localized() : LocalizationConstants.jobQuotes.localized()}';
    } else {
      return '';
    }
  }

  bool get hasFilter =>
      (!parameter.quoteNumber.isNullOrEmpty) ||
      (!parameter.customerId.isNullOrEmpty) ||
      (!parameter.userId.isNullOrEmpty) ||
      (!parameter.salesRepNumber.isNullOrEmpty) ||
      ((parameter.statuses?.length ?? 0) > 0) ||
      ((parameter.types?.length ?? 0) > 0) ||
      parameter.fromDate != null ||
      parameter.toDate != null ||
      parameter.expireFromDate != null ||
      parameter.expireToDate != null;
}
