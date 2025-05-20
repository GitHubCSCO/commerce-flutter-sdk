import 'package:commerce_flutter_sdk/src/features/domain/enums/request_quote_type.dart';
import 'package:equatable/equatable.dart';

class RequestQuoteSelectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestQuoteSelectionDefaultState extends RequestQuoteSelectionState {
  final RequestQuoteType requestQuoteType;

  RequestQuoteSelectionDefaultState(this.requestQuoteType);

  @override
  List<Object?> get props => [requestQuoteType];
}

class RequestQuoteSelectionChangeState extends RequestQuoteSelectionState {
  final RequestQuoteType requestQuoteType;

  RequestQuoteSelectionChangeState(this.requestQuoteType);

  @override
  List<Object?> get props => [requestQuoteType];
}
