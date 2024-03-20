import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/payment_details/payment_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsBloc
    extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  final PaymentDetailsUseCase _paymentDetailsUseCase;

  PaymentDetailsBloc({required PaymentDetailsUseCase paymentDetailsUseCase})
      : _paymentDetailsUseCase = paymentDetailsUseCase,
        super(PaymentDetailsInitial()) {}
}
