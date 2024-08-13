// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_app/features/domain/enums/quote_page_type.dart';

abstract class QuoteEvent extends Equatable {}

class QuoteLoadEvent extends QuoteEvent {
  final QuotePageType quotePageType;
  final QuoteQueryParameters? quoteParameters;
  final bool loadMore;

  QuoteLoadEvent({
    required this.quoteParameters,
    required this.quotePageType,
    this.loadMore = false,
  });

  @override
  List<Object?> get props => [
        quotePageType,
        quoteParameters,
        loadMore,
      ];

  QuoteEvent copyWith({
    QuotePageType? quotePageType,
    QuoteQueryParameters? quoteParameters,
    bool? loadMore,
  }) {
    return QuoteLoadEvent(
      quotePageType: quotePageType ?? this.quotePageType,
      quoteParameters: quoteParameters ?? this.quoteParameters,
      loadMore: loadMore ?? this.loadMore,
    );
  }
}
