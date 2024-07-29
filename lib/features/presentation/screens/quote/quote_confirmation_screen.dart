import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteConfirmationScreen extends StatelessWidget {
  final QuoteDto quote;

  const QuoteConfirmationScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote Confirmation'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTitleWidget(LocalizationConstants.quoteInformation),
        QuoteInformationWidget(
          quoteDto: quote,
        ),
      ]),
    );
  }

  Widget _buildTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 5),
      child: Text(
        title,
        style: OptiTextStyles.body,
      ),
    );
  }
}
