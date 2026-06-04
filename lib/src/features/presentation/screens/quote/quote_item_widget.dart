import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class QuoteItemWidget extends StatelessWidget {
  final String typeDisplay;
  final String quoteNumber;
  final String companyName;
  final String address;
  final String status;
  final String requestDate;
  final String expiryDate;

  const QuoteItemWidget({
    super.key,
    required this.typeDisplay,
    required this.quoteNumber,
    required this.companyName,
    required this.address,
    required this.status,
    required this.requestDate,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!typeDisplay.isNullOrEmpty)
                  Text(typeDisplay, style: context.text.bodyFade),
                Text(
                  quoteNumber,
                  style: TextStyle(
                    color: context.scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(companyName, style: context.text.body),
                Text(
                  address,
                  style: context.text.body,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Visibility(
                  visible: requestDate.isNotEmpty,
                  child: Text(
                    'Requested $requestDate',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Visibility(
                  visible: expiryDate.isNotEmpty,
                  child: Text(
                    'Expires $expiryDate',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
