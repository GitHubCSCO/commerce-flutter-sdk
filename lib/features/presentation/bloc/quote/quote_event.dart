import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteEvent {}

class QuoteLoadEvent extends QuoteEvent {
  final QuoteQueryParameters QuoteParameters;

  QuoteLoadEvent({required this.QuoteParameters});
}
