import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteDetailsState {}

class QuoteDetailsInitialState extends QuoteDetailsState {}

class QuoteDetailsLoadingState extends QuoteDetailsState {}

class QuoteDetailsInitializationSuccessState extends QuoteDetailsState {}

class QuoteDetailsLoadedState extends QuoteDetailsState {
  final QuoteDto quoteDto;
  final List<QuoteLineEntity> quoteLines;
  QuoteDetailsLoadedState({required this.quoteDto, required this.quoteLines});
}

class QuoteDetailsFailedState extends QuoteDetailsState {
  final String error;
  QuoteDetailsFailedState({required this.error});
}

class QuoteDeletionSuccessState extends QuoteDetailsState {}

class QuoteDeletionFailedState extends QuoteDetailsState {}

class QuoteDeclineSuccessState extends QuoteDetailsState {}

class QuoteDeclineFailedState extends QuoteDetailsState {}

class QuoteSubmissionSuccessState extends QuoteDetailsState {}

class QuoteSubmissionFailedState extends QuoteDetailsState {}

class QuoteAcceptSuccessState extends QuoteDetailsState {}

class QuoteAcceptFailedState extends QuoteDetailsState {}

class QuoteAcceptUnauthorizedState extends QuoteDetailsState {}

class QuoteAcceptMessageShowState extends QuoteDetailsState {}

class QuoteAcceptMessageBypassState extends QuoteDetailsState {}

class QuoteAcceptedCheckoutState extends QuoteDetailsState {
  final Cart? cart;
  QuoteAcceptedCheckoutState({required this.cart});
}

class ExpirationDateRequiredState extends QuoteDetailsState {
  final String message;
  ExpirationDateRequiredState({required this.message});
}

class PastExpirationDateState extends QuoteDetailsState {
  final String message;
  PastExpirationDateState({required this.message});
}
