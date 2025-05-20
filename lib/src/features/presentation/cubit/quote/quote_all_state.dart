// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteAllState {}

class QuoteAllInitialState extends QuoteAllState {}

class QuoteAllLoadingState extends QuoteAllState {}

class QuoteAllLoadedState extends QuoteAllState {
  final QuoteDto quoteDto;
  final String titleMsg;
  QuoteAllLoadedState({
    required this.quoteDto,
    required this.titleMsg,
  });
}

class QuoteAllValidationState extends QuoteAllState {
  final bool isValid;
  final String? message;
  QuoteAllValidationState({
    required this.isValid,
    required this.message,
  });
}

class QuoteAllAppliedSuccessState extends QuoteAllState {
  final QuoteDto quoteDto;
  QuoteAllAppliedSuccessState({
    required this.quoteDto,
  });
}
