import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final QuoteDetailsUsecase _quoteDetailsUsecase;
  QuoteDetailsBloc({required QuoteDetailsUsecase quoteDetailsUsecase})
      : _quoteDetailsUsecase = quoteDetailsUsecase,
        super(QuoteDetailsInitialState());
}
