import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/job_quote_details_status.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quote/job_quote_details/job_quote_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quote/job_quote_details/job_quote_details_cubit.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobQuoteDetailsScreen extends StatelessWidget {
  final String? jobQuoteId;

  const JobQuoteDetailsScreen({
    super.key,
    required this.jobQuoteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<JobQuoteDetailsCubit>()
        ..initialize(
          jobQuoteId: jobQuoteId,
        ),
      child: JobQuoteDetailsPage(
        jobQuoteId: jobQuoteId ?? '',
      ),
    );
  }
}

class JobQuoteDetailsPage extends StatelessWidget {
  final String jobQuoteId;

  const JobQuoteDetailsPage({
    super.key,
    required this.jobQuoteId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        title: context.watch<JobQuoteDetailsCubit>().jobQuote != null
            ? Text(
                context.watch<JobQuoteDetailsCubit>().jobQuote?.orderNumber ??
                    '',
              )
            : Text(LocalizationConstants.myQuoteDetails.localized()),
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.jobQuoteDetailsWebsitePath.format(
              [context.watch<JobQuoteDetailsCubit>().jobQuote?.id ?? ''],
            ),
          ),
        ],
      ),
      body: BlocConsumer<JobQuoteDetailsCubit, JobQuoteDetailsState>(
        listener: (context, state) {
          if (state.status == JobQuoteDetailsStatus.generateOrderFailure) {
            _displaySignedOutDialog(context);
          }

          if (state.status == JobQuoteDetailsStatus.generateOrderFailureAuth) {
            _displayErrorDiaglog(context);
          }

          if (state.status ==
              JobQuoteDetailsStatus.generateOrderSuccessWithCheckoutUrl) {
            launchUrlString(context.read<JobQuoteDetailsCubit>().checkoutUrl);
          }

          if (state.status == JobQuoteDetailsStatus.quoteAcceptMessageShow) {
            _displayDialogForAccpetQuote(context);
          }

          if (state.status == JobQuoteDetailsStatus.proceedToCheckout) {
            AppRoute.checkout.navigateBackStack(context, extra: state.cart);
          }
        },
        builder: (context, state) {
          if (state.status == JobQuoteDetailsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == JobQuoteDetailsStatus.failure) {
            return const Center(
              child: Text('Failed to fetch job quote details'),
            );
          } else {
            final cubit = context.watch<JobQuoteDetailsCubit>();
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _JobQuoteInfoSection(
                          jobName: cubit.jobQuote?.jobName ?? '',
                          expirationDate: cubit.jobQuote?.expirationDate != null
                              ? DateFormat(CoreConstants.dateFormatString)
                                  .format(cubit.jobQuote!.expirationDate!)
                              : '',
                          customerName: cubit.jobQuote?.customerName ?? '',
                          shipToAddress:
                              cubit.jobQuote?.shipToFullAddress ?? '',
                        ),
                        _ProductSection(
                          jobQuoteLines: state.jobQuoteLines,
                          jobOrderQty: state.jobOrderQty,
                        ),
                      ],
                    ),
                  ),
                ),
                OrderBottomSectionWidget(
                  actions: [
                    state.status != JobQuoteDetailsStatus.generateOrderLoading
                        ? PrimaryButton(
                            isEnabled: state.isGenerateOrderEnabled,
                            text:
                                LocalizationConstants.generateOrder.localized(),
                            onPressed: context
                                .read<JobQuoteDetailsCubit>()
                                .generateOrder,
                          )
                        : const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _JobQuoteInfoSection extends StatelessWidget {
  final String jobName;
  final String expirationDate;
  final String customerName;
  final String shipToAddress;

  const _JobQuoteInfoSection({
    required this.jobName,
    required this.expirationDate,
    required this.customerName,
    required this.shipToAddress,
  });

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
            LocalizationConstants.quoteInformation.localized().toUpperCase(),
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
              if (jobName.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.jobName.localized(),
                  value: jobName,
                ),
                const SizedBox(height: 20),
              ],
              if (expirationDate.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.expirationDate.localized(),
                  value: expirationDate,
                ),
                const SizedBox(height: 20),
              ],
              if (customerName.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.customer.localized(),
                  value: customerName,
                ),
                const SizedBox(height: 20),
              ],
              if (shipToAddress.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.shippingAddress.localized(),
                  value: shipToAddress,
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ],
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

class _ProductSection extends StatelessWidget {
  final List<JobQuoteLine> jobQuoteLines;
  final List<int> jobOrderQty;

  const _ProductSection({
    required this.jobQuoteLines,
    required this.jobOrderQty,
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
                '(${jobQuoteLines.length} item)',
                style: OptiTextStyles.body,
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final jobQuoteLine = jobQuoteLines[index];
            return JobQuoteLineWidget(
              imagePath: jobQuoteLine.smallImagePath,
              jobQty: (jobQuoteLine.qtyOrdered ?? 0).toInt(),
              purchasedQty: (jobQuoteLine.qtySold ?? 0).toInt(),
              shortDescription: jobQuoteLine.shortDescription,
              productNumber: jobQuoteLine.erpNumber,
              manufacturerItem: !jobQuoteLine.manufacturerItem.isNullOrEmpty
                  ? LocalizationConstants.mFGNumberSign.localized() +
                      (jobQuoteLine.manufacturerItem ?? '')
                  : null,
              priceValueText: (jobQuoteLine.quoteRequired ?? false)
                  ? LocalizationConstants.requiresQuote.localized()
                  : ProductPriceEntityMapper.toEntity(
                          jobQuoteLine.pricing ?? ProductPrice())
                      .getPriceValue(),
              unitOfMeasureValueText:
                  !jobQuoteLine.unitOfMeasureDescription.isNullOrEmpty
                      ? ' / ${jobQuoteLine.unitOfMeasureDescription!}'
                      : jobQuoteLine.unitOfMeasureDisplay,
              qtyOrdered: jobOrderQty[index].toString(),
              unitOfMeasure: jobQuoteLine.unitOfMeasure,
              onQtyChanged: (int? qty) {
                context.read<JobQuoteDetailsCubit>().updateJobQuoteLineQuantity(
                      index: index,
                      quantity: qty,
                    );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: jobQuoteLines.length,
        )
      ],
    );
  }
}

void _displayDialogForAccpetQuote(BuildContext context) {
  displayDialogWidget(
    context: context,
    message: LocalizationConstants.acceptQuoteMessage.localized(),
    actions: [
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.cancel.localized()),
      ),
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
          context.read<JobQuoteDetailsCubit>().acceptJobQuote();
        },
        child: Text(LocalizationConstants.continueText.localized()),
      ),
    ],
  );
}

void _displaySignedOutDialog(BuildContext context) {
  displayDialogWidget(
    context: context,
    message: LocalizationConstants.signInBeforeCheckout.localized(),
    actions: [
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ],
  );
}

void _displayErrorDiaglog(BuildContext context) {
  displayDialogWidget(
    context: context,
    title: LocalizationConstants.error.localized(),
    message: LocalizationConstants.errorCommunicatingWithTheServer.localized(),
    actions: [
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ],
  );
}
