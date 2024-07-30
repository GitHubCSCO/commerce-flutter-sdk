import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'job_quote_details_state.dart';

class JobQuoteDetailsCubit extends Cubit<JobQuoteDetailsState> {
  final QuoteDetailsUsecase _quoteDetailsUsecase;
  bool isSalesPerson = false;
  String jobQuoteId = '';
  JobQuoteDto? jobQuote;

  JobQuoteDetailsCubit({
    required QuoteDetailsUsecase quoteDetailsUsecase,
  })  : _quoteDetailsUsecase = quoteDetailsUsecase,
        super(
          const JobQuoteDetailsState(
            status: JobQuoteDetailsStatus.initial,
            jobQuoteLines: [],
            jobOrderQty: [],
          ),
        );

  Future<void> initialize({
    required String? jobQuoteId,
  }) async {
    emit(state.copyWith(status: JobQuoteDetailsStatus.loading));
    this.jobQuoteId = jobQuoteId ?? '';

    final sessionResult = await _quoteDetailsUsecase.getCurrentSession();
    switch (sessionResult) {
      case Failure():
        isSalesPerson = false;
        break;
      case Success(value: final session):
        isSalesPerson = session?.isSalesPerson ?? false;
        break;
    }

    final jobQuote =
        await _quoteDetailsUsecase.getJobQuote(jobQuoteId: jobQuoteId);

    if (jobQuote == null) {
      emit(state.copyWith(status: JobQuoteDetailsStatus.failure));
    } else {
      this.jobQuote = jobQuote;
      emit(
        state.copyWith(
          status: JobQuoteDetailsStatus.loaded,
          jobQuoteLines: jobQuote.jobQuoteLineCollection ?? [],
          jobOrderQty: List.filled(
            (jobQuote.jobQuoteLineCollection ?? []).length,
            0,
          ),
        ),
      );
    }
  }

  bool get isGenerateOrderEnabled =>
      (state.status == JobQuoteDetailsStatus.loaded) &&
      (jobQuote?.expirationDate != null &&
          !jobQuote!.expirationDate!.isBefore(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
          )) &&
      (state.jobOrderQty.any((e) => e > 0));
}
