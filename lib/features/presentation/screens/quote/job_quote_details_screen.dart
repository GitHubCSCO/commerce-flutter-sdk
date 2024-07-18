import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quote/job_quote_details/job_quote_details_cubit.dart';
import 'package:intl/intl.dart';

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
            : const Text(LocalizationConstants.myQuoteDetails),
      ),
      body: BlocConsumer<JobQuoteDetailsCubit, JobQuoteDetailsState>(
        listener: (context, state) {},
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
            return SingleChildScrollView(
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
                    shipToAddress: cubit.jobQuote?.shipToFullAddress ?? '',
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
            LocalizationConstants.quoteInformation.toUpperCase(),
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
                  title: LocalizationConstants.jobName,
                  value: jobName,
                ),
                const SizedBox(height: 20),
              ],
              if (expirationDate.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.expirationDate,
                  value: expirationDate,
                ),
                const SizedBox(height: 20),
              ],
              if (customerName.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.customer,
                  value: customerName,
                ),
                const SizedBox(height: 20),
              ],
              if (shipToAddress.isNotEmpty) ...[
                _TextEntries(
                  title: LocalizationConstants.shippingAddress,
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
