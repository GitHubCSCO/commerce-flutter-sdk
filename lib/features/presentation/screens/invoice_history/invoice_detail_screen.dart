import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_app/features/domain/enums/invoice_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/invoice_history/invoice_detail/invoice_detail_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final String invoiceNumber;

  const InvoiceDetailScreen({
    super.key,
    required this.invoiceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceDetailCubit>()
        ..loadInvoiceDetails(
          invoiceNumber: invoiceNumber,
        ),
      child: InvoiceDetailPage(
        invoiceNumber: invoiceNumber,
      ),
    );
  }
}

class InvoiceDetailPage extends StatelessWidget {
  final String invoiceNumber;

  const InvoiceDetailPage({
    super.key,
    required this.invoiceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        actions: const [],
        title: Text(invoiceNumber),
      ),
      body: BlocConsumer<InvoiceDetailCubit, InvoiceDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == InvoiceStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == InvoiceStatus.failure) {
            return const Center(
              child: Text('Failed to fetch invoice details'),
            );
          } else {
            final cubit = context.watch<InvoiceDetailCubit>();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InvoiceInfoSection(cubit: cubit),
                  _InvoicePaymentSummarySection(cubit: cubit),
                  _InvoiceProductsSectionWidget(
                    invoiceLines: state.invoice.invoiceLines ?? [],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _InvoicePaymentSummarySection extends StatelessWidget {
  const _InvoicePaymentSummarySection({required this.cubit});

  final InvoiceDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Text(
            LocalizationConstants.orderSummary,
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          color: OptiAppColors.backgroundWhite,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TwoTextsRow(
                label: cubit.subtotalTitle,
                value: cubit.subtotalValue,
                textStyle: OptiTextStyles.subtitle,
              ),
              TwoTextsRow(
                label: cubit.taxTitle,
                value: cubit.taxValue,
                textStyle: OptiTextStyles.body,
              ),
              TwoTextsRow(
                label: cubit.shippingTitle,
                value: cubit.shippingValue,
                textStyle: OptiTextStyles.body,
              ),
              TwoTextsRow(
                label: cubit.discountTitle,
                value: cubit.discountValue,
                textStyle: OptiTextStyles.body,
              ),
              TwoTextsRow(
                label: cubit.otherChargesTitle,
                value: cubit.otherChargesValue,
                textStyle: OptiTextStyles.body,
              ),
              const SizedBox(height: 10),
              TwoTextsRow(
                label: cubit.totalTitle,
                value: cubit.totalValue,
                textStyle: OptiTextStyles.subtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InvoiceProductsSectionWidget extends StatelessWidget {
  final List<InvoiceLine> invoiceLines;

  const _InvoiceProductsSectionWidget({
    required this.invoiceLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.products,
                style: OptiTextStyles.titleLarge,
              ),
              const SizedBox(width: 8),
              Text(
                '(${invoiceLines.length} item)',
                style: OptiTextStyles.body,
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final invoiceLine = invoiceLines[index];
            return LineItemWidget(
              imagePath: invoiceLine.mediumImagePath,
              shortDescription:
                  invoiceLine.shortDescription ?? invoiceLine.description,
              productNumber: invoiceLine.productErpNumber,
              manufacturerItem: !invoiceLine.manufacturerItem.isNullOrEmpty
                  ? LocalizationConstants.mFGNumberSign +
                      (invoiceLine.manufacturerItem ?? '')
                  : null,
              discountMessage: DiscountValueConverter().convert(invoiceLine),
              priceValueText: invoiceLine.unitPriceDisplay,
              unitOfMeasureValueText: !invoiceLine.unitOfMeasure.isNullOrEmpty
                  ? ' / ${invoiceLine.unitOfMeasure!}'
                  : null,
              qtyOrdered: (invoiceLine.qtyInvoiced ?? 0).toInt().toString(),
              subtotalPriceText: invoiceLine.lineTotalDisplay,
              canEditQty: false,
              showViewQuantityPricing: false,
              unitOfMeasure: invoiceLine.unitOfMeasure,
              showViewAvailabilityByWarehouse: false,
              lineNotes: invoiceLine.notes,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: invoiceLines.length,
        )
      ],
    );
  }
}

class _InvoiceInfoSection extends StatelessWidget {
  const _InvoiceInfoSection({
    required this.cubit,
  });

  final InvoiceDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!cubit.invoiceDateValue.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.invoiceDate,
              value: cubit.invoiceDateValue,
            ),
            const SizedBox(height: 10),
          ],
          if (!cubit.invoiceDueDateValue.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.invoiceDueDate,
              value: cubit.invoiceDueDateValue,
            ),
            const SizedBox(height: 10),
          ],
          if (!cubit.termsValue.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.terms,
              value: cubit.termsValue,
            ),
            const SizedBox(height: 10),
          ],
          if (!cubit.poNumberValue.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.poNumber,
              value: cubit.poNumberValue,
            ),
            const SizedBox(height: 10),
          ],
          if (!cubit.statusValue.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.status,
              value: cubit.statusValue,
            ),
            const SizedBox(height: 10),
          ],

          // Billing Address
          _TextEntries(
            title: cubit.billingAddress,
            value: cubit.billCompany,
          ),
          if (!cubit.billLineOne.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.billLineOne,
            ),
          ],
          if (!cubit.billLineTwo.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.billLineTwo,
            ),
          ],
          if (!cubit.billFormat.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.billFormat,
            ),
          ],
          if (!cubit.billCountry.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.billCountry,
            ),
          ],
          const SizedBox(height: 10),

          // Shipping Address
          _TextEntries(
            title: cubit.shippingAddress,
            value: cubit.shipCompany,
          ),
          if (!cubit.shipLineOne.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.shipLineOne,
            ),
          ],
          if (!cubit.shipLineTwo.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.shipLineTwo,
            ),
          ],
          if (!cubit.shipFormat.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.shipFormat,
            ),
          ],
          if (!cubit.shipCountry.isNullorWhitespace) ...[
            _TextEntries(
              title: '',
              value: cubit.shipCountry,
            ),
          ],
          const SizedBox(height: 10),

          // Shipping Method
          if (!cubit.shippingMethod.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.shippingMethodTitle,
              value: cubit.shippingMethod,
            ),
            const SizedBox(height: 10),
          ],

          // Order Notes
          if (!cubit.orderNotes.isNullorWhitespace) ...[
            _TextEntries(
              title: cubit.orderNotesTitle,
              value: cubit.orderNotes,
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _TextEntries extends StatelessWidget {
  final String title;
  final String value;

  const _TextEntries({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: OptiTextStyles.subtitle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: OptiTextStyles.body,
          ),
        ),
      ],
    );
  }
}
