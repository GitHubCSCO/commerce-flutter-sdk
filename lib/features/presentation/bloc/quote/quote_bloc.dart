import 'package:commerce_flutter_app/features/domain/enums/quote_page_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteUsecase _quoteUsecase;

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

    var result = await _quoteUsecase.getQuotes(parameter);
    switch (result) {
      case Success(value: final data):
        emit(QuoteLoaded(
            quotePageType: QuotePageType.pending, quotes: data?.quotes ?? []));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteFailed(
            error: errorResponse.errorDescription ?? '',
            quotePageType: QuotePageType.pending));
        break;
      default:
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
