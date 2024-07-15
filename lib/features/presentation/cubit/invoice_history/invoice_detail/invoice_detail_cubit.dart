import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/invoice_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/invoice_usecase/invoice_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'invoice_detail_state.dart';

class InvoiceDetailCubit extends Cubit<InvoiceDetailState> {
  final InvoiceUseCase _invoiceUseCase;

  InvoiceDetailCubit({required InvoiceUseCase invoiceUseCase})
      : _invoiceUseCase = invoiceUseCase,
        super(
          InvoiceDetailState(
            invoice: Invoice(),
            status: InvoiceStatus.initial,
          ),
        );

  Future<void> loadInvoiceDetails({
    required String? invoiceNumber,
  }) async {
    emit(
      state.copyWith(
        status: InvoiceStatus.loading,
      ),
    );

    final result = await _invoiceUseCase.loadInvoice(
      invoiceId: invoiceNumber,
    );

    if (result == null) {
      emit(state.copyWith(status: InvoiceStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        status: InvoiceStatus.success,
        invoice: result,
      ),
    );
  }

  String get _shippingMethod =>
      (state.invoice.shipViaDescription.isNullOrEmpty
          ? state.invoice.shipCode
          : state.invoice.shipViaDescription) ??
      '';

  // Invoice Information
  String get invoiceDate => LocalizationConstants.invoiceDate;
  String get invoiceDueDate => LocalizationConstants.invoiceDueDate;
  String get terms => LocalizationConstants.terms;
  String get poNumber => LocalizationConstants.pONumber;
  String get status => LocalizationConstants.status;
  String get billingAddress => LocalizationConstants.billingAddress;
  String get shippingAddress => LocalizationConstants.shippingAddress;
  String get shippingMethodTitle => LocalizationConstants.shippingMethod;
  String get orderNotesTitle => LocalizationConstants.orderNotes;

  String get invoiceDateValue => state.invoice.invoiceDate != null
      ? DateFormat(CoreConstants.dateFormatString)
          .format(state.invoice.invoiceDate!)
      : '';
  String get invoiceDueDateValue => state.invoice.dueDate != null
      ? DateFormat(CoreConstants.dateFormatString)
          .format(state.invoice.dueDate!)
      : '';
  String get termsValue => state.invoice.terms ?? '';
  String get poNumberValue => state.invoice.customerPO ?? '';
  String get statusValue => state.invoice.status ?? '';
  String get billCompany => state.invoice.btCompanyName ?? '';
  String get billLineOne => state.invoice.btAddress1 ?? '';
  String get billLineTwo => state.invoice.btAddress2 ?? '';
  String get billCountry => state.invoice.btCountry ?? '';
  String get billFormat =>
      '${state.invoice.billToCity ?? ''}, ${state.invoice.billToState ?? ''} ${state.invoice.billToPostalCode ?? ''}';
  String get shipCompany => state.invoice.stCompanyName ?? '';
  String get shipLineOne => state.invoice.stAddress1 ?? '';
  String get shipLineTwo => state.invoice.stAddress2 ?? '';
  String get shipCountry => state.invoice.stCountry ?? '';
  String get shipFormat =>
      '${state.invoice.shipToCity ?? ''}, ${state.invoice.shipToState ?? ''} ${state.invoice.shipToPostalCode ?? ''}';
  String get shippingMethod =>
      _shippingMethod.toLowerCase() == 'hidden' ? '' : _shippingMethod;
  String get orderNotes => state.invoice.notes ?? '';

  // Summary Section
  String get subtotalTitle => LocalizationConstants.subtotal;
  String get subtotalValue => state.invoice.productTotalDisplay ?? '';
  String get taxTitle => LocalizationConstants.tax;
  String get taxValue => (state.invoice.invoiceHistoryTaxes == null ||
          state.invoice.invoiceHistoryTaxes!.isEmpty)
      ? state.invoice.taxAmountDisplay ?? ''
      : (state.invoice.invoiceHistoryTaxes ?? [])
          .map((e) => e.taxAmount)
          .reduce((a, b) => (a ?? 0) + (b ?? 0))
          .toString();
  String get shippingTitle => LocalizationConstants.shipping;
  String get shippingValue => state.invoice.shippingAndHandlingDisplay ?? '';
  String get discountTitle => LocalizationConstants.discounts;
  String get discountValue => state.invoice.discountAmountDisplay ?? '';
  String get totalTitle => LocalizationConstants.total;
  String get totalValue => state.invoice.invoiceTotalDisplay ?? '';
  String get otherChargesTitle => LocalizationConstants.otherCharges;
  String get otherChargesValue => state.invoice.otherChargesDisplay ?? '';
}
