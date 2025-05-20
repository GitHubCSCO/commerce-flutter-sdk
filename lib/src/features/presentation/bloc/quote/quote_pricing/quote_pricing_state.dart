import 'package:commerce_flutter_sdk/src/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quote_line_pricing_break_item_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuotePricingState extends Equatable {}

class QuotePricingInitialState extends QuotePricingState {
  @override
  List<Object?> get props => [];
}

class QuotePricingLoadingState extends QuotePricingState {
  @override
  List<Object?> get props => [];
}

class QuotePricingLoadedState extends QuotePricingState {
  final QuoteLineEntity quoteLineEntity;
  final List<QuoteLinePricingBreakItemEntity> quoteLinePricingBreakItemEntities;

  QuotePricingLoadedState(
      {required this.quoteLineEntity,
      required this.quoteLinePricingBreakItemEntities});

  @override
  List<Object?> get props =>
      [quoteLineEntity, quoteLinePricingBreakItemEntities];
}

class QuotePriceBreakValidationState extends QuotePricingState {
  final bool isValid;
  final String message;

  QuotePriceBreakValidationState(
      {required this.isValid, required this.message});

  @override
  List<Object?> get props => [isValid, message];
}

class QuoteLinePricingApplySuccessState extends QuotePricingState {
  final QuoteDto quoteDto;

  QuoteLinePricingApplySuccessState({required this.quoteDto});

  @override
  List<Object?> get props => [quoteDto];
}

class QuoteLinePricingApplyFailureState extends QuotePricingState {
  @override
  List<Object?> get props => [];
}
