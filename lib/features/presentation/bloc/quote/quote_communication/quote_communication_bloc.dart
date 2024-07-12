import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_communication_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteCommunicationBloc
    extends Bloc<QuoteCommunicationEvent, QuoteCommunicationState> {
  final QuoteCommunicationUsecase _quoteCommunicationUsecase;
  QuoteCommunicationBloc(
      {required QuoteCommunicationUsecase quoteCommunicationUsecase})
      : _quoteCommunicationUsecase = quoteCommunicationUsecase,
        super(QuoteCommunicationInitialState());
}
