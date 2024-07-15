// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteCommunicationState {}

class QuoteCommunicationInitialState extends QuoteCommunicationState {}

class QuoteCommunicationLoadingState extends QuoteCommunicationState {}

class QuoteCommunicationLoadedState extends QuoteCommunicationState {
  final QuoteDto quoteDto;
  QuoteCommunicationLoadedState({
    required this.quoteDto,
  });
}

class QuoteCommunicationFailureState extends QuoteCommunicationState {
  final String message;
  QuoteCommunicationFailureState({
    required this.message,
  });
}

class QuoteCommunicationMessageSendSuccessState
    extends QuoteCommunicationState {}

class QuoteCommunicationMessageSendFailureState
    extends QuoteCommunicationState {}
