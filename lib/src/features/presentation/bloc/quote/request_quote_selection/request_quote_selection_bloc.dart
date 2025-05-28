import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestQuoteSelectionBloc
    extends Bloc<RequestQuoteSelectionEvent, RequestQuoteSelectionState> {
  RequestQuoteSelectionBloc() : super(RequestQuoteSelectionState()) {
    on<RequestQuoteSelectionDefaultEvent>(_onRequestQuoteDefaultEvent);
    on<RequestQuoteSelectionChangeEvent>(_onRequestQuoteSelectionChangeState);
  }

  Future<void> _onRequestQuoteDefaultEvent(
      RequestQuoteSelectionDefaultEvent event,
      Emitter<RequestQuoteSelectionState> emit) async {
    emit(RequestQuoteSelectionDefaultState(event.requestQuoteType));
  }

  Future<void> _onRequestQuoteSelectionChangeState(
      RequestQuoteSelectionChangeEvent event,
      Emitter<RequestQuoteSelectionState> emit) async {
    emit(RequestQuoteSelectionChangeState(event.requestQuoteType));
  }
}
