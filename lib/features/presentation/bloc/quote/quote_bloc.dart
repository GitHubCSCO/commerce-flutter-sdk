import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteUsecase _quoteUsecase;

  QuoteBloc({required QuoteUsecase quoteUsecase})
      : _quoteUsecase = quoteUsecase,
        super(QuoteInitial());
}
