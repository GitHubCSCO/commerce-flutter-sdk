import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CartPaymentSummaryWidget extends StatelessWidget {

  const CartPaymentSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            'Payment Summary',
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal (1 Item)',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.subtitle,
                  ),
                  Text(
                    '\$11,440.00',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.subtitle,
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping & Handling',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  ),
                  Text(
                    '\$0.00',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  ),
                  Text(
                    'TBD',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.subtitle,
                  ),
                  Text(
                    '\$11,420.00',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.subtitle,
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Promotion: Hammer20',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.bodyFade,
                  ),
                  Text(
                    '-\$20.00',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.bodyFade,
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Promotion: Comobile 10%',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.bodyFade,
                  ),
                  Text(
                    '-\$501.00',
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.bodyFade,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildColumn(List<Widget> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    );
  }

  Widget _buildText(String text, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF707070),
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: fontWeight,
        height: 0.10,
      ),
    );
  }
  
}