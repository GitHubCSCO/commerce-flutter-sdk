import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/enums/invoice_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/invoice_history/invoice_detail/invoice_detail_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InvoiceDetailScreen extends BaseStatelessWidget {
  final String invoiceNumber;

  const InvoiceDetailScreen({
    super.key,
    required this.invoiceNumber,
  });

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<InvoiceDetailCubit>()
            ..loadInvoiceDetails(
              invoiceNumber: invoiceNumber,
            ),
        ),
        BlocProvider(
          create: (context) => sl<BottomMenuCubit>(), // for print path
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<BottomMenuCubit, BottomMenuState>(
          // for determining the print path
          listener: (context, state) {
            switch (state) {
              case BottomMenuWebsiteUrlLoaded():
                launchUrlString(state.url);
                break;
              case BottomMenuWebsiteUrlFailed():
                displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.error.localized(),
                  message: state.message,
                  actions: [
                    DialogPlainButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(LocalizationConstants.oK.localized()),
                    ),
                  ],
                );
                break;
            }
          },
          child: InvoiceDetailPage(
            invoiceNumber: invoiceNumber,
          ),
        );
      }),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    var viewScreenEvent = AnalyticsEvent(AnalyticsConstants.eventViewScreen,
            AnalyticsConstants.screenNameInvoiceDetail)
        .withProperty(
            name: AnalyticsConstants.screenNameInvoiceDetail,
            strValue: invoiceNumber);
    return viewScreenEvent;
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
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.invoiceDetailWebsitePath.format(
              [invoiceNumber],
            ),
            toolMenuList: [
              ToolMenu(
                title: LocalizationConstants.print.localized(),
                action: () {
                  context.read<RootBloc>().add(
                        RootAnalyticsEvent(
                          AnalyticsEvent(
                            AnalyticsConstants.eventPrintPdf,
                            AnalyticsConstants.screenNameInvoiceDetail,
                          ).withProperty(
                              name: AnalyticsConstants.eventPropertyUrl,
                              strValue: PrintPaths.invoiceDetailPrintPath
                                  .format([invoiceNumber])),
                        ),
                      );
                  context.read<BottomMenuCubit>().loadWebsiteUrl(
                        PrintPaths.invoiceDetailPrintPath
                            .format([invoiceNumber]),
                      );
                },
              ),
              ToolMenu(
                title: LocalizationConstants.email.localized(),
                action: () {
                  AppRoute.invoiceEmail.navigateBackStack(
                    context,
                    pathParameters: {
                      'invoiceNumber': invoiceNumber,
                    },
                  );
                },
              ),
            ],
          ),
        ],
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
            LocalizationConstants.orderSummary.localized(),
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
              if (!cubit.taxValue.isNullOrEmpty)
                TwoTextsRow(
                  label: cubit.taxTitle,
                  value: cubit.taxValue,
                  textStyle: OptiTextStyles.body,
                ),
              if (!cubit.shippingValue.isNullOrEmpty)
                TwoTextsRow(
                  label: cubit.shippingTitle,
                  value: cubit.shippingValue,
                  textStyle: OptiTextStyles.body,
                ),
              if (!cubit.discountValue.isNullOrEmpty)
                TwoTextsRow(
                  label: cubit.discountTitle,
                  value: cubit.discountValue,
                  textStyle: OptiTextStyles.body,
                ),
              if (!cubit.otherChargesValue.isNullOrEmpty)
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
                LocalizationConstants.products.localized(),
                style: OptiTextStyles.titleLarge,
              ),
              const SizedBox(width: 8),
              Text(
                invoiceLines.length == 1
                    ? LocalizationConstants.item.localized().format(
                        ['1'],
                      )
                    : LocalizationConstants.items.localized().format(
                        [invoiceLines.length.toString()],
                      ),
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
                  ? LocalizationConstants.mFGNumberSign.localized() +
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
          _TextEntries(
            title: cubit.invoiceDate,
            value: cubit.invoiceDateValue,
          ),
          const SizedBox(height: 10),

          _TextEntries(
            title: cubit.invoiceDueDate,
            value: cubit.invoiceDueDateValue,
          ),
          const SizedBox(height: 10),

          _TextEntries(
            title: cubit.terms,
            value: cubit.termsValue,
          ),
          const SizedBox(height: 10),

          _TextEntries(
            title: cubit.poNumber,
            value: cubit.poNumberValue,
          ),
          const SizedBox(height: 10),

          _TextEntries(
            title: cubit.status,
            value: cubit.statusValue,
          ),
          const SizedBox(height: 10),

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
          _TextEntries(
            title: cubit.shippingMethodTitle,
            value: cubit.shippingMethod,
          ),
          const SizedBox(height: 10),

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
