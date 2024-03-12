import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CartShippingWidget extends StatelessWidget {
  const CartShippingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            'Shipping',
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Ship'),
                      value: 'option1',
                      groupValue: 'option1',
                      onChanged: (value) {
                        // radioSelectionBloc.add(SelectOptionEvent(value!));
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Pick Up'),
                      value: 'option2',
                      groupValue: 'option1',
                      onChanged: (value) {
                        // radioSelectionBloc.add(SelectOptionEvent(value!));
                      },
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick Up Location',
                          textAlign: TextAlign.center,
                          style: OptiTextStyles.subtitle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Minniapolis descr',
                          textAlign: TextAlign.center,
                          style: OptiTextStyles.subtitle,
                        ),
                        Text(
                          '110 N 5th Street',
                          textAlign: TextAlign.center,
                          style: OptiTextStyles.body,
                        ),
                        Text(
                          'Minniapolis, MN 55403',
                          textAlign: TextAlign.center,
                          style: OptiTextStyles.body,
                        ),
                        Text(
                          '(612) 673-3000',
                          textAlign: TextAlign.center,
                          style: OptiTextStyles.body,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 24, left: 24, right: 24),
                child: Row(
                  children: [
                    Text(
                      'Hours',
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Directions',
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

}