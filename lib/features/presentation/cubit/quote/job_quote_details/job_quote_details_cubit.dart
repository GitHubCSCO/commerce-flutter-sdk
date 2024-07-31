import 'package:commerce_flutter_app/features/domain/enums/job_quote_details_status.dart';
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
  String checkoutUrl = '';

  JobQuoteDetailsCubit({
    required QuoteDetailsUsecase quoteDetailsUsecase,
  })  : _quoteDetailsUsecase = quoteDetailsUsecase,
        super(
          JobQuoteDetailsState(
            status: JobQuoteDetailsStatus.initial,
            jobQuoteLines: const [],
            jobOrderQty: const [],
            isGenerateOrderEnabled: false,
            cart: Cart(),
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

  void updateJobQuoteLineQuantity({
    required int index,
    required int? quantity,
  }) {
    state.jobOrderQty[index] = quantity ?? 0;

    emit(
      state.copyWith(
          isGenerateOrderEnabled: (state.jobQuoteLines.isNotEmpty) &&
              (jobQuote?.expirationDate != null &&
                  !jobQuote!.expirationDate!.isBefore(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                  )) &&
              (!state.jobOrderQty.any((e) => e == 0))),
    );
  }

  Future<void> generateOrder() async {
    List<JobQuoteLineUpdate> updatedItems = [];

    for (int i = 0; i < state.jobOrderQty.length; i++) {
      if (state.jobOrderQty[i] == 0) {
        continue;
      }

      updatedItems.add(
        JobQuoteLineUpdate(
          id: state.jobQuoteLines[i].id,
          qtyOrdered: state.jobOrderQty[i],
        ),
      );
    }

    final parameter = JobQuoteUpdateParameter(
      jobQuoteId: jobQuoteId,
      jobQuoteLineCollection: updatedItems,
    );

    emit(
      state.copyWith(
        status: JobQuoteDetailsStatus.generateOrderLoading,
      ),
    );

    final updatedJobQuote =
        await _quoteDetailsUsecase.updateJobQuote(parameter: parameter);

    if (updatedJobQuote == null) {
      emit(
        state.copyWith(
          status: JobQuoteDetailsStatus.generateOrderFailure,
        ),
      );
      return;
    }

    final isAuthenticated = await _quoteDetailsUsecase.isAuthenticatedAsync();
    switch (isAuthenticated) {
      case Failure():
        emit(
          state.copyWith(
            status: JobQuoteDetailsStatus.generateOrderFailureAuth,
          ),
        );
        return;
      default:
    }

    final checkoutUrl = await _quoteDetailsUsecase.getCheckoutUrl();
    if (!checkoutUrl.isNullOrEmpty) {
      final url = await _quoteDetailsUsecase.getAuthorizedURL(checkoutUrl);
      if (url.isNullOrEmpty) {
        state.copyWith(status: JobQuoteDetailsStatus.generateOrderFailure);
        return;
      }

      this.checkoutUrl = url!;
      state.copyWith(
        status: JobQuoteDetailsStatus.generateOrderSuccessWithCheckoutUrl,
      );
      return;
    }

    emit(
      state.copyWith(
        cart: updatedJobQuote as Cart,
      ),
    );
    
    final currentCart = await _quoteDetailsUsecase.getCurrentCart(
      CartQueryParameters(
        expand: ['cartlines'],
      ),
    );

    switch (currentCart) {
      case Success(value: final cart):
        if ((cart?.cartLines ?? []).isNotEmpty) {
          emit(
            state.copyWith(
              status: JobQuoteDetailsStatus.quoteAcceptMessageShow,
            ),
          );
          return;
        }

        break;
      case Failure():
        break;
    }

    await acceptJobQuote();
  }

  Future<void> acceptJobQuote() async {
    emit(
      state.copyWith(
        status: JobQuoteDetailsStatus.proceedToCheckout,
      ),
    );
  }
}
