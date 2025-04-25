import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteInformationWidget extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteInformationWidget({super.key, required this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationConstants.quoteInformation.localized(),
            style: OptiTextStyles.bodyFade,
          ),
          SizedBox(height: 10.0),
          DetailRow(
              label: LocalizationConstants.salesRep.localized(),
              value: quoteDto?.salespersonName ?? ''),
          DetailRow(
              label: LocalizationConstants.user.localized(),
              value: quoteDto?.userName ?? ''),
          DetailRow(
              label: LocalizationConstants.status.localized(),
              value: quoteDto?.statusDisplay ?? ''),
          DetailRow(
              label: LocalizationConstants.dateSubmitted.localized(),
              value: quoteDto?.orderDate
                      ?.formatDate(format: CoreConstants.dateFormatString) ??
                  ''),
          DetailRow(
              label: LocalizationConstants.customer.localized(),
              value: quoteDto?.customerName ?? ''),
          DetailRow(
            label: LocalizationConstants.shippingAddress.localized(),
            value: quoteDto?.shipToFullAddress ?? '',
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
