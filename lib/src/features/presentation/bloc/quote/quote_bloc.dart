import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/quote_page_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteUsecase _quoteUsecase;
  QuotePageType pageType = QuotePageType.pending;
  int? numberOfPages;
  int totalQuotes = 0;
  String? notFoundInfoText;

  QuoteQueryParameters parameter = QuoteQueryParameters(
    pageSize: CoreConstants.defaultPageSize,
    expand: ['saleslist'],
  );

  QuoteBloc({required QuoteUsecase quoteUsecase})
      : _quoteUsecase = quoteUsecase,
        super(QuoteInitial()) {
    on<QuoteLoadEvent>((event, emit) => _onQuoteLoadEvent(event, emit));
  }

  Future<void> _onQuoteLoadEvent(
    QuoteLoadEvent event,
    Emitter<QuoteState> emit,
  ) async {
    parameter = event.quoteParameters ?? parameter;
    if (event.quotePageType != pageType) {
      totalQuotes = 0;
      parameter.page = 1;
      numberOfPages = null;
      pageType = event.quotePageType;
    }

    int page = parameter.page ?? 1;
    final newParameter = parameter;

    if (!event.loadMore) {
      emit(QuoteLoading());
    } else {
      if (state is QuoteLoaded) {
        if ((state as QuoteLoaded).moreLoading) {
          return;
        }

        page = (state as QuoteLoaded).page + 1;
        if (page > (numberOfPages ?? 0)) {
          return;
        }
        newParameter.page = page;

        emit((state as QuoteLoaded).copyWith(moreLoading: true));
      }
    }

    switch (event.quotePageType) {
      case QuotePageType.pending:
        var result = (!event.loadMore)
            ? await _quoteUsecase.getQuotes(parameter)
            : await _quoteUsecase.getQuotes(newParameter);

        notFoundInfoText = await _quoteUsecase.getSiteMessage(
            SiteMessageConstants.quoteNotFoundMessage,
            SiteMessageConstants.defaultNoQuotesFoundMessage);

        switch (result) {
          case Success(value: final data):
            parameter.page = data?.pagination?.page ?? 1;
            numberOfPages = data?.pagination?.numberOfPages;
            totalQuotes = data?.pagination?.totalItemCount ?? 0;

            if (!event.loadMore) {
              emit(
                QuoteLoaded(
                  notFoundInfoText: notFoundInfoText,
                  quotePageType: QuotePageType.pending,
                  quotes: data?.quotes ?? [],
                  page: 1,
                ),
              );
            } else {
              final newQuotes = (state as QuoteLoaded).quotes;
              newQuotes?.addAll(data?.quotes ?? []);

              emit(
                (state as QuoteLoaded).copyWith(
                  quotes: newQuotes,
                  moreLoading: false,
                  page: page,
                ),
              );
            }

            break;
          case Failure(errorResponse: final errorResponse):
            emit(
              QuoteFailed(
                error: errorResponse.errorDescription ?? '',
                quotePageType: QuotePageType.pending,
              ),
            );
            break;
        }
        break;

      case QuotePageType.activejobs:
        var result = await _quoteUsecase.getJobQuotes();
        notFoundInfoText = await _quoteUsecase.getSiteMessage(
            SiteMessageConstants.jobQuoteNotFoundMessage,
            SiteMessageConstants.defaultNoJobQuotesFoundMessage);
        switch (result) {
          case Success(value: final data):
            emit(JobQuoteLoaded(
                notFoundInfoText: notFoundInfoText,
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
      final length = totalQuotes;
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
