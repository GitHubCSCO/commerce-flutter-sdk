import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/mixins/validator_mixin.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/invoice_usecase/invoice_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'invoice_email_state.dart';

class InvoiceEmailCubit extends Cubit<InvoiceEmailState> with ValidatorMixin {
  final InvoiceUseCase _invoiceUseCase;

  InvoiceEmailCubit({required InvoiceUseCase invoiceUseCase})
      : _invoiceUseCase = invoiceUseCase,
        super(InvoiceEmailInitial());

  Session? currentSession;

  void initialize() {
    currentSession = _invoiceUseCase.getCurrentSession();
  }

  Future<void> sendEmail({
    required String emailTo,
    required String emailFrom,
    required String subject,
    required String message,
    required String invoiceNumber,
  }) async {
    emit(InvoiceEmailLoading());

    final parameter = InvoiceEmailParameter(
      emailTo: emailTo,
      emailFrom: emailFrom,
      subject: subject,
      message: message,
      entityId: invoiceNumber,
      entityName: LocalizationConstants.invoice.keyword,
    );

    final result = await _invoiceUseCase.sendInvoiceEmail(parameter: parameter);

    if (result) {
      emit(InvoiceEmailSuccess());
    } else {
      emit(
        InvoiceEmailFailure(
          message: LocalizationConstants.emailSentFailed.localized(),
        ),
      );
    }
  }
}
