import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteConfirmationState {}

class QuoteConfirmationInitialState extends QuoteConfirmationState {}

class QuoteConfirmationLoadingState extends QuoteConfirmationState {}

class QuoteConfirmationLoadedState extends QuoteConfirmationState {
  final QuoteDto quoteDto;
  final List<QuoteLineEntity> quoteLineEntities;
  QuoteConfirmationLoadedState({
    required this.quoteDto,
    required this.quoteLineEntities,
  });
}
