import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_pricing_break_item_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuotePricingState {}

class QuotePricingInitialState extends QuotePricingState {}

class QuotePricingLoadingState extends QuotePricingState {}

class QuotePricingLoadedState extends QuotePricingState {
  final QuoteLineEntity quoteLineEntity;
  final List<QuoteLinePricingBreakItemEntity> quoteLinePricingBreakItemEntities;

  QuotePricingLoadedState(
      {required this.quoteLineEntity,
      required this.quoteLinePricingBreakItemEntities});
}

class QuotePriceBreakValidationState extends QuotePricingState {
  final bool isValid;
  final String message;

  QuotePriceBreakValidationState(
      {required this.isValid, required this.message});
}

class QuoteLinePricingApplySuccessState extends QuotePricingState {
  final QuoteDto quoteDto;

  QuoteLinePricingApplySuccessState({required this.quoteDto});
}

class QuoteLinePricingApplyFailureState extends QuotePricingState {}
